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
    use sui::{
        package, 
        display,
        transfer_policy::TransferPolicy,
        clock::Clock,
        table::{Self, Table},
        dynamic_object_field as dof,
        kiosk::{Kiosk, KioskOwnerCap},
    };
    use act::{
        act_weapon::{Self, Weapon}, 
        act_cosmetic::{Self, Cosmetic}
    };

    // === Errors ===

    const EAlreadyMintedAnAvatar: u64 = 0;
    const EWeaponSlotAlreadyEquipped: u64 = 1;
    const ECosmeticSlotAlreadyEquipped: u64 = 2;

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

    // used during the mint in a ptb
    public fun equip_minted_weapon(uid_mut: &mut UID, weapon: Weapon) {
        assert!(!dof::exists_(uid_mut, WeaponKey(weapon.slot())), EWeaponSlotAlreadyEquipped);
        dof::add(uid_mut, WeaponKey(weapon.slot()), weapon)  
    }

    // used during the mint in a ptb
    public fun equip_minted_cosmetic(uid_mut: &mut UID, cosmetic: Cosmetic) {
        assert!(!dof::exists_(uid_mut, CosmeticKey(cosmetic.`type`())), ECosmeticSlotAlreadyEquipped);
        dof::add(uid_mut, CosmeticKey(cosmetic.`type`()), cosmetic)  
    }

    public fun equip_weapon(
        self: &mut Avatar, 
        weapon_id: ID,
        weapon_slot: u8,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // equipping policy
        ctx: &mut TxContext
    ) {
        act_weapon::equip(
            &mut self.id, 
            WeaponKey(weapon_slot), 
            weapon_id, 
            kiosk,
            cap,
            policy,
            ctx
        );
    }

    public fun equip_cosmetic(
        self: &mut Avatar, 
        cosmetic_id: ID,
        cosmetic_type: u8,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Cosmetic>, // equipping policy
        ctx: &mut TxContext
    ) {
        act_cosmetic::equip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            cosmetic_id, 
            kiosk,
            cap,
            policy,
            ctx
        );
    }

    public fun unequip_weapon(
        self: &mut Avatar, 
        weapon_slot: u8,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // trading policy
    ) {
        act_weapon::unequip(
            &mut self.id, 
            WeaponKey(weapon_slot), 
            kiosk,
            cap,
            policy,
        );
    }

    public fun unequip_cosmetic(
        self: &mut Avatar, 
        cosmetic_type: u8,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Cosmetic>, // trading policy
    ) {
        act_cosmetic::unequip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            kiosk,
            cap,
            policy,
        );
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun uid_mut(self: &mut Avatar): &mut UID {
        &mut self.id
    }

    // === Private Functions ===

    // === Test Functions === 
}
