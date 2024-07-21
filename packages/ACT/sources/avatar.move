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
module act::avatar {
    // === Imports ===

    use std::string::String;
    use sui::{
        package, 
        display,
        table::{Self, Table},
        vec_map::VecMap,
        transfer_policy::TransferPolicy,
        dynamic_object_field as dof,
        kiosk::{Kiosk, KioskOwnerCap},
    };
    use animalib::access_control::{Admin, AccessControl};
    use act::{
        attributes,
        admin,
        upgrade::{Self, Upgrade},
        weapon::{Self, Weapon}, 
        cosmetic::{Self, Cosmetic}
    };

    // === Errors ===

    const EAlreadyMintedAnAvatar: u64 = 0;
    const EWeaponSlotAlreadyEquipped: u64 = 1;
    const ECosmeticSlotAlreadyEquipped: u64 = 2;
    const ECosmeticIsNotEquipped: u64 = 3;
    const EWeaponIsNotEquipped: u64 = 4;
    const ENeedToMintAnAvatar: u64 = 5;

    // === Constants ===

    // === Structs ===

    // one-time witness
    public struct AVATAR has drop {}

    // @dev Shared object to ensure we have one account per avatar
    public struct AvatarRegistry has key {
        id: UID,
        // ctx.sender() => Avatar.id.uid_to_inner()
        accounts: Table<address, ID>
    }
    
    public struct CosmeticKey(String) has copy, store, drop; 

    public struct WeaponKey(String) has copy, store, drop;

    // @dev key only ability to prevent transfers
    // We need to see how we will handle the Kiosk with Weapons and Cosmetics ?! 
    // Should the hold a Kiosk Owner Cap and when an item is on the Avatar Kiosk is considered equipped ?!
    // What rules should weapon and cosmetics have ?!
    public struct Avatar has key {
        id: UID,
        image_url: String,
        image_hash: String,
        model_url: String,
        avatar_url: String,
        avatar_hash: String,
        edition: String,
        upgrades: vector<Upgrade>,
        attributes: VecMap<String, String>
        // see how to manage the secondary image
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(otw: AVATAR, ctx: &mut TxContext) {
        let avatar_registry = AvatarRegistry {
            id: object::new(ctx),
            accounts: table::new(ctx)
        };

        transfer::share_object(avatar_registry);

        let keys = vector[
            b"name".to_string(),
            b"description".to_string(),
            b"image_url".to_string(),
            b"project_url".to_string(),
            b"creator".to_string(),
        ];
        let values = vector[
            b"ACT Avatar: {alias}".to_string(),
            b"ACT is a fast-paced, high-skill multiplayer FPS".to_string(),
            b"ipfs://{image_url}".to_string(),
            b"https://animalabs.io".to_string(), // to change with ACT game page
            b"Anima Labs".to_string(),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<Avatar>(
            &publisher, keys, values, ctx
        );
        display.update_version();

        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }

    public fun new(
        registry: &mut AvatarRegistry, 
        image_url: String,
        image_hash: String,
        model_url: String,
        avatar_url: String,
        avatar_hash: String,
        edition: String,
        ctx: &mut TxContext
    ): Avatar {
        // One Avatar per user
        registry.assert_no_avatar(ctx.sender());
        
        let avatar = Avatar {
            id: object::new(ctx),
            image_url,
            image_hash,
            model_url,
            avatar_url,
            avatar_hash,
            edition,
            upgrades: vector[],
            attributes: attributes::new(),
        };

        registry.accounts.add(ctx.sender(), avatar.id.uid_to_inner());

        avatar
    }

    public fun keep(avatar: Avatar, ctx: &mut TxContext) {
        transfer::transfer(avatar, ctx.sender());
    }

    // used during the mint in a ptb
    public fun equip_minted_weapon(self: &mut Avatar, weapon: Weapon) {
        assert!(!dof::exists_(&self.id, WeaponKey(weapon.slot())), EWeaponSlotAlreadyEquipped);

        let cosmetic_val = self.get_mut_attribute(weapon.slot());
        *cosmetic_val = weapon.name();

        dof::add(&mut self.id, WeaponKey(weapon.slot()), weapon)  
    }

    // used during the mint in a ptb
    public fun equip_minted_cosmetic(self: &mut Avatar, cosmetic: Cosmetic) {
        assert!(!dof::exists_(&self.id, CosmeticKey(cosmetic.type_())), ECosmeticSlotAlreadyEquipped);

        let cosmetic_val = self.get_mut_attribute(cosmetic.type_());
        *cosmetic_val = cosmetic.name();

        dof::add(&mut self.id, CosmeticKey(cosmetic.type_()), cosmetic)  
    }

    public fun equip_weapon(
        self: &mut Avatar, 
        weapon_id: ID,
        weapon_slot: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // equipping policy
        ctx: &mut TxContext
    ) {
        let weapon_name = weapon::equip(
            &mut self.id, 
            WeaponKey(weapon_slot), 
            weapon_id, 
            kiosk,
            cap,
            policy,
            ctx
        );

        let weapon_val = self.get_mut_attribute(weapon_slot);
        *weapon_val = weapon_name;
    }

    public fun equip_cosmetic(
        self: &mut Avatar, 
        cosmetic_id: ID,
        cosmetic_type: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Cosmetic>, // equipping policy
        ctx: &mut TxContext
    ) {
        let cosmetic_name = cosmetic::equip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            cosmetic_id, 
            kiosk,
            cap,
            policy,
            ctx
        );

        let cosmetic_val = self.get_mut_attribute(cosmetic_type);
        *cosmetic_val = cosmetic_name;
    }

    public fun unequip_weapon(
        self: &mut Avatar, 
        weapon_slot: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // trading policy
    ) {
        let weapon_val = self.get_mut_attribute(weapon_slot);
        *weapon_val = b"".to_string();

        weapon::unequip(
            &mut self.id, 
            WeaponKey(weapon_slot), 
            kiosk,
            cap,
            policy,
        );
    }

    public fun unequip_cosmetic(
        self: &mut Avatar, 
        cosmetic_type: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Cosmetic>, // trading policy
    ) {
        let cosmetic_val = self.get_mut_attribute(cosmetic_type);
        *cosmetic_val = b"".to_string();

        cosmetic::unequip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            kiosk,
            cap,
            policy,
        );
    }

    // === Public-View Functions ===

    public fun image_url(self: &Avatar): String {
        self.image_url
    }

    public fun image_hash(self: &Avatar): String {
        self.image_hash
    }

    public fun model_url(self: &Avatar): String {
        self.model_url
    }    

    public fun avatar_url(self: &Avatar): String {
        self.avatar_url
    }    

    public fun avatar_hash(self: &Avatar): String {
        self.avatar_hash
    }    

    public fun edition(self: &Avatar): String {
        self.edition
    }

    public fun upgrades(self: &Avatar): &vector<Upgrade> {
        &self.upgrades
    }

    public fun attributes(self: &Avatar): &VecMap<String, String>{
        &self.attributes
    }

    public fun has_weapon(self: &Avatar, slot: String): bool {
        dof::exists_(&self.id, WeaponKey(slot))
    }

    public fun has_cosmetic(self: &Avatar, type_: String): bool {
        dof::exists_(&self.id, CosmeticKey(type_))
    }

    public fun assert_no_avatar(self: &AvatarRegistry, addr: address) {
        assert!(!self.accounts.contains(addr), EAlreadyMintedAnAvatar);
    }

    public fun assert_has_avatar(self: &AvatarRegistry, addr: address) {
        assert!(self.accounts.contains(addr), ENeedToMintAnAvatar);
    }

    // === Admin Functions ===

    public fun upgrade(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        url: String
    ) {
        admin::assert_upgrades_role(access_control, admin);
        self.upgrades.push_back(upgrade::new(url));
    }

    public fun upgrade_equipped_weapon(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        slot: String,
        url: String,     
    ) {
        admin::assert_upgrades_role(access_control, admin);
        assert!(dof::exists_(&self.id, WeaponKey(slot)), EWeaponIsNotEquipped);
        let weapon = dof::borrow_mut<WeaponKey, Weapon>(&mut self.id, WeaponKey(slot)); 
        weapon.upgrade(access_control, admin, url);   
    }

    public fun upgrade_equipped_cosmetic(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        `type`: String,
        url: String        
    ) {
        admin::assert_upgrades_role(access_control, admin);
        assert!(dof::exists_(&self.id, CosmeticKey(`type`)), ECosmeticIsNotEquipped);
        let cosmetic = dof::borrow_mut<CosmeticKey, Cosmetic>(&mut self.id, CosmeticKey(`type`)); 
        cosmetic.upgrade(access_control, admin, url);   
    }

    // === Public-Package Functions ===

    public(package) fun transfer(self: Avatar, recipient: address) {
        transfer::transfer(self, recipient);
    }

    // === Private Functions ===

    fun get_mut_attribute(avatar: &mut Avatar, key: String): &mut String {
        if (!avatar.attributes.contains(&key))
            avatar.attributes.insert(key, b"".to_string());

        avatar.attributes.get_mut(&key)
    }

    // === Test Functions === 
    
    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(AVATAR {}, ctx);
    }

    #[test_only]
    public fun borrow_equipped_cosmetic(
        self: &Avatar, 
        `type`: String,       
    ): &Cosmetic {
        dof::borrow<CosmeticKey, Cosmetic>(&self.id, CosmeticKey(`type`))
    }

    #[test_only]
    public fun borrow_equipped_weapon(
        self: &Avatar, 
        slot: String,   
    ): &Weapon {
        dof::borrow<WeaponKey, Weapon>(&self.id, WeaponKey(slot))
    }
}        
