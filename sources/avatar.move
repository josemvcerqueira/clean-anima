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

    use std::string::String;

    use sui::clock::Clock;
    use sui::table::{Self, Table};
    use sui::dynamic_object_field as dof;
    use sui::kiosk::{Kiosk, KioskOwnerCap};

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

    // @dev Shared object to ensure we have one account per avatar
    public struct AvatarRegistry has key {
        id: UID,
        // ctx.sender() => Avatar.id.uid_to_inner()
        accounts: Table<address, ID>
    }
    
    public struct CosmeticKey has copy, store, drop { 
        key: u8 
    }
    
    public struct WeaponKey has copy, store, drop {
        key: u8
    }

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
        name: String,
        alias: String,
        creation_date: u64,
        reputation: vector<Field>,
        accolades: vector<Field>,
        // What does his represent ?!
        upgrades: u64
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(ctx: &mut TxContext) {
        let avatar_registry = AvatarRegistry {
            id: object::new(ctx),
            accounts: table::new(ctx)
        };

        transfer::share_object(avatar_registry);
    }

    public fun mint(
        clock: &mut Clock,
        registry: &mut AvatarRegistry, 
        name: String,
        alias: String,
        ctx: &mut TxContext
    ) {
        // One Avatar per user
        assert!(!registry.accounts.contains(ctx.sender()), EAlreadyMintedAnAvatar);

        let avatar = Avatar {
            id: object::new(ctx),
            name,
            alias,
            creation_date: clock.timestamp_ms(),
            reputation: vector[],
            accolades: vector[],
            upgrades: 0
        };

        transfer::transfer(avatar, ctx.sender());
    }

    public fun equip_weapon(self: &mut Avatar, weapon: Weapon) {
        let key = WeaponKey { key: weapon.slot() };
        equip(&mut self.id, key, weapon, EWeaponSlotAlreadyEquipped);
    }

    public fun equip_cosmetic(self: &mut Avatar, cosmetic: Cosmetic) {
        let key = CosmeticKey { key: cosmetic.`type`() };
        equip(&mut self.id, key, cosmetic, ECosmeticSlotAlreadyEquipped);    
    }

    public fun unequip_weapon(
        self: &mut Avatar, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap, 
        slot: u8
    ) {
        let key = WeaponKey { key: slot };
        unequip<WeaponKey, Weapon>(&mut self.id, kiosk, cap, key, EWeaponSlotDoesNotExist);
    }

    public fun unequip_cosmetic(
        self: &mut Avatar, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap, 
        `type`: u8
    ) {
        let key = CosmeticKey { key: `type` };
        unequip<CosmeticKey, Cosmetic>(&mut self.id, kiosk, cap, key, ECosmeticKindDoesNotExist);
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
