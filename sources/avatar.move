/*
* @title Anima Avatar
*
* @description
* The Avatar is non-transferable / not decomposable. The account and avatar are one unit/
*
* Questions?!
* 1 - Who can add accolades/reputation? I assume it is via an AdminCap. Can they both be removed/add or just add?!
* 2 - What is the upgrades array in the Avatar object ?!
* 3 - What are the admin rights?! 
* 4 - Is the wear rating generated on-chain or off-chain?!
* 5 - Custom rule of personal_kiosk_rule or equip. Tradeport can ad d acustom rule but takes THEM TIME
* - issue two transfer policies?
*/
module act::act_avatar {
    // === Imports ===

    use std::string::{utf8, String};

    use sui::clock::Clock;
    use sui::table::{Self, Table};
    use sui::dynamic_object_field as dof;
    use sui::kiosk::{Kiosk, KioskOwnerCap};
    use sui::package;
    use sui::display;

    use act::act_weapon::Weapon;
    use act::act_cosmetic::Cosmetic;

    // === Errors ===

    const EAlreadyMintedAnAvatar: u64 = 0;
    const EWeaponSlotAlreadyEquipped: u64 = 1;
    const ECosmeticSlotAlreadyEquipped: u64 = 2;
    const EWeaponSlotDoesNotExist: u64 = 3;
    const ECosmeticKindDoesNotExist: u64 = 4;

    // === Constants ===

    // === Structs ===

    // one-time witness
    public struct ACT_AVATAR has drop {}

    // @dev Shared object to ensure we have one account per avatar
    public struct AvatarRegistry has key {
        id: UID,
        // ctx.sender() => Avatar.id.uid_to_inner()
        accounts: Table<address, ID>
    }
    
    public struct CosmeticKey(u8) has copy, store, drop; 

    public struct WeaponKey(u8) has copy, store, drop;

    public struct Field has store {
        `type`: String,
        description: String,
        link: String
    }

    // @dev key only ability to prevent transfers
    // We need to see how we will handle the Kiosk with Weapons and Cosmetics ?! 
    // Should the hold a Kiosk Owner Cap and when an item is on the Avatar Kiosk is considered equipped ?!
    // What rules should weapon and cosmetics have ?!
    public struct Avatar has key {
        id: UID,
        alias: String,
        username: String, // or account_name
        image_url: String,
        image_hash: String,
        avatar_url: String,
        `type`: String,
        creation_date: u64,
        reputation: vector<Field>,
        accolades: vector<Field>,
        // What does his represent ?!
        upgrades: u64
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(otw: ACT_AVATAR, ctx: &mut TxContext) {
        let avatar_registry = AvatarRegistry {
            id: object::new(ctx),
            accounts: table::new(ctx)
        };
        transfer::share_object(avatar_registry);

        let keys = vector[
            utf8(b"name"),
            utf8(b"description"),
            utf8(b"image_url"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];
        let values = vector[
            utf8(b"ACT Avatar: {alias}"),
            utf8(b"ACT is a fast-paced, high-skill multiplayer FPS"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"https://animalabs.io"), // to change with ACT game page
            utf8(b"Anima Labs"),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<Avatar>(
            &publisher, keys, values, ctx
        );
        display.update_version();

        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }

    public fun mint(
        registry: &mut AvatarRegistry, 
        alias: String,
        username: String,
        image_url: String,
        image_hash: String,
        avatar_url: String,
        `type`: String,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        // One Avatar per user
        assert!(!registry.accounts.contains(ctx.sender()), EAlreadyMintedAnAvatar);

        let avatar = Avatar {
            id: object::new(ctx),
            alias,
            username,
            image_url,
            image_hash,
            avatar_url,
            `type`,
            creation_date: clock.timestamp_ms(),
            reputation: vector[],
            accolades: vector[],
            upgrades: 0
        };

        transfer::transfer(avatar, ctx.sender());
    }

    public fun equip_weapon(self: &mut Avatar, weapon: Weapon) {
        equip(&mut self.id, WeaponKey(weapon.slot()), weapon, EWeaponSlotAlreadyEquipped);
    }

    public fun equip_cosmetic(self: &mut Avatar, cosmetic: Cosmetic) {
        equip(&mut self.id, CosmeticKey(cosmetic.`type`()), cosmetic, ECosmeticSlotAlreadyEquipped);    
    }

    public fun unequip_weapon(
        self: &mut Avatar, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap, 
        slot: u8
    ) {
        unequip<WeaponKey, Weapon>(&mut self.id, kiosk, cap, WeaponKey(slot), EWeaponSlotDoesNotExist);
    }

    public fun unequip_cosmetic(
        self: &mut Avatar, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap, 
        `type`: u8
    ) {
        unequip<CosmeticKey, Cosmetic>(&mut self.id, kiosk, cap, CosmeticKey(`type`), ECosmeticKindDoesNotExist);
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    fun equip<Key: store + copy + drop, Item: key + store>(uid_mut: &mut UID, key: Key, item: Item, error: u64) {
        assert!(!dof::exists_(uid_mut, key), error);
        dof::add(uid_mut, key, item)  
    }

    fun unequip<Key: store + copy + drop, Item: key + store>(
        uid_mut: &mut UID, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,         
        key: Key, 
        error: u64
    ) {
        assert!(dof::exists_(uid_mut, key), error);
        let item = dof::remove<Key, Item>(uid_mut, key);
        kiosk.place(cap, item);
    }

    // === Test Functions === 
}
