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
        vec_map::{Self, VecMap},
        transfer_policy::TransferPolicy,
        dynamic_object_field as dof,
        kiosk::{Kiosk, KioskOwnerCap},
        transfer::{public_receive, Receiving}
    };
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };
    use act::{
        attributes,
        upgrade::{Self, Upgrade, LockedUpgrade},
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
    const EWrongWeaponSlot: u64 = 6;
    const EWrongCosmeticType: u64 = 7;
    const EMaxTwoUpgrades: u64 = 8;

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
    public struct Avatar has key {
        id: UID,
        image_url: String,
        equipped_cosmetics_hash: String,
        avatar_image: String,
        avatar_model: String,
        avatar_texture: String,
        edition: String,
        upgrades: vector<Upgrade>,
        attributes: VecMap<String, String>,
        attributes_hash: VecMap<String, vector<u8>>,
        misc: VecMap<String, String>,
    }

    public struct AvatarImage has key, store {
        id: UID,
        image_url: String,
        equipped_cosmetics_hash: String,
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
            b"{image_url}".to_string(),
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
        ctx: &mut TxContext
    ): Avatar {
        new_with_image(registry, b"QmXdqWcqFWNp6RrTy8t2Np1xyNL7TatQGEiRQC1f4iW87x".to_string(), b"".to_string(), ctx)
    }

    public fun keep(avatar: Avatar, ctx: &mut TxContext) {
        transfer::transfer(avatar, ctx.sender());
    }

    // used during the mint in a ptb
    public fun equip_minted_weapon(self: &mut Avatar, weapon: Weapon) {
        assert!(!dof::exists_(&self.id, WeaponKey(weapon.slot())), EWeaponSlotAlreadyEquipped);

        let weapon_val = &mut self.attributes[&weapon.slot()];
        *weapon_val = weapon.name();

        let weapon_val = &mut self.attributes_hash[&weapon.slot()];
        *weapon_val = weapon.hash();

        dof::add(&mut self.id, WeaponKey(weapon.slot()), weapon);
    }

    // used during the mint in a ptb
    public fun equip_minted_cosmetic(self: &mut Avatar, cosmetic: Cosmetic) {
        assert!(!dof::exists_(&self.id, CosmeticKey(cosmetic.type_())), ECosmeticSlotAlreadyEquipped);

        let cosmetic_val = &mut self.attributes[&cosmetic.type_()];
        *cosmetic_val = cosmetic.name();

        let cosmetic_val = &mut self.attributes_hash[&cosmetic.type_()];
        *cosmetic_val = cosmetic.hash();

        dof::add(&mut self.id, CosmeticKey(cosmetic.type_()), cosmetic);  
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
        let (weapon_name, slot, hash) = weapon::equip(
            &mut self.id, 
            WeaponKey(weapon_slot), 
            weapon_id, 
            kiosk,
            cap,
            policy,
            ctx
        );

        assert!(weapon_slot == slot, EWrongWeaponSlot);

        let weapon_val = &mut self.attributes[&weapon_slot];
        *weapon_val = weapon_name;

        let weapon_val = &mut self.attributes_hash[&weapon_slot];
        *weapon_val = hash;
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
        let (cosmetic_name, type_, hash) = cosmetic::equip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            cosmetic_id, 
            kiosk,
            cap,
            policy,
            ctx
        );

        assert!(cosmetic_type == type_, EWrongCosmeticType);

        let cosmetic_val = &mut self.attributes[&cosmetic_type];
        *cosmetic_val = cosmetic_name;

        let cosmetic_val = &mut self.attributes_hash[&cosmetic_type];
        *cosmetic_val = hash;
    }

    public fun unequip_weapon(
        self: &mut Avatar, 
        weapon_slot: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // trading policy
    ) {
        let weapon_val = &mut self.attributes[&weapon_slot];
        *weapon_val = b"".to_string();

        let weapon_val = &mut self.attributes_hash[&weapon_slot];
        *weapon_val = vector[];

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
        let cosmetic_val = &mut self.attributes[&cosmetic_type];
        *cosmetic_val = b"".to_string();

        let cosmetic_val = &mut self.attributes_hash[&cosmetic_type];
        *cosmetic_val = vector[];

        cosmetic::unequip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            kiosk,
            cap,
            policy,
        );
    }

    public fun update_avatar(self: &mut Avatar, receiving: Receiving<AvatarImage>) {
        let AvatarImage { 
            id, 
            image_url, 
            equipped_cosmetics_hash
        } = public_receive(&mut self.id, receiving);

        self.image_url = image_url;
        self.equipped_cosmetics_hash = equipped_cosmetics_hash;

        id.delete();
    }


    public fun upgrade(
        self: &mut Avatar, 
        receiving: Receiving<LockedUpgrade>
    ) {
        assert!(2 > self.upgrades.length(), EMaxTwoUpgrades);
        let locked_upgrade = public_receive(&mut self.id, receiving);
        let upgrade = locked_upgrade.destroy();

        self.image_url = upgrade.image_url();
        self.avatar_model = upgrade.model_url();
        self.avatar_texture = upgrade.texture_url();

        self.upgrades.push_back(upgrade);
    }

    public fun upgrade_equipped_cosmetic(
        self: &mut Avatar, 
        receiving: Receiving<LockedUpgrade>,
        `type`: String,      
    ) {
        assert!(dof::exists_(&self.id, CosmeticKey(`type`)), ECosmeticIsNotEquipped);
        let cosmetic = dof::borrow_mut<CosmeticKey, Cosmetic>(&mut self.id, CosmeticKey(`type`)); 
        cosmetic.upgrade(receiving);   
    }

    public fun upgrade_equipped_weapon(
        self: &mut Avatar,  
        receiving: Receiving<LockedUpgrade>,
        slot: String,
    ) {
        assert!(dof::exists_(&self.id, WeaponKey(slot)), EWeaponIsNotEquipped);
        let weapon = dof::borrow_mut<WeaponKey, Weapon>(&mut self.id, WeaponKey(slot)); 
        weapon.upgrade(receiving);   
    }

    // === Public-View Functions ===

    public fun image_url(self: &Avatar): String {
        self.image_url
    }

    public fun avatar_image(self: &Avatar): String {
        self.avatar_image
    }    

    public fun equipped_cosmetics_hash(self: &Avatar): String {
        self.equipped_cosmetics_hash
    }  

    public fun avatar_model(self: &Avatar): String {
        self.avatar_model
    }    

    public fun avatar_texture(self: &Avatar): String {
        self.avatar_texture
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

    public fun new_avatar_image(
        access_control: &AccessControl, 
        admin: &Admin, 
        image_url: String,
        equipped_cosmetics_hash: String,
        recipient: address,
        ctx: &mut TxContext
    ) {
        admin::assert_upgrades_role(access_control, admin);
        let image = AvatarImage {
            id: object::new(ctx),
            image_url,
            equipped_cosmetics_hash
        };

        transfer::public_transfer(image, recipient);
    }

    public fun new_upgrade(
        access_control: &AccessControl, 
        admin: &Admin, 
        name: String,
        image_url: String,
        model_url: String,
        texture_url: String,
        recipient: address,
        ctx: &mut TxContext
    ) {
        admin::assert_upgrades_role(access_control, admin);
        transfer::public_transfer(
            upgrade::new(name, image_url, model_url, texture_url, ctx), 
            recipient
        );
    }

    // === Public-Package Functions ===

    public(package) fun new_with_image(
        registry: &mut AvatarRegistry, 
        image_url: String,
        equipped_cosmetics_hash: String,
        ctx: &mut TxContext
    ): Avatar {
        // One Avatar per user
        registry.assert_no_avatar(ctx.sender());
        
        let avatar = Avatar {
            id: object::new(ctx),
            image_url,
            equipped_cosmetics_hash,
            avatar_image: b"QmWCfdKVUDLaKyJiyy3rKaHAVYhAGS7k1gXaWoLRX8mjcD".to_string(),
            avatar_model: b"QmaKS7RQCZaLSq6XfmDakZC5boPCDhgGU8AK1Tdn5Xj3oi".to_string(),
            avatar_texture: b"QmefuZMw2GeveTYEmcaJf7QTHtyE99srP6FRK6bHPK2fNe".to_string(),
            edition: b"Standard".to_string(),
            upgrades: vector[],
            attributes: attributes::new(),
            attributes_hash: attributes::new_hashes(),
            misc: vec_map::empty(),
        };

        registry.accounts.add(ctx.sender(), avatar.id.uid_to_inner());

        avatar
    }

    public(package) fun transfer(self: Avatar, recipient: address) {
        transfer::transfer(self, recipient);
    }

    public(package) fun set_edition(self: &mut Avatar, edition: vector<u8>) {
        self.edition = edition.to_string();
    }

    public use fun destroy_avatar_image as AvatarImage.destroy;
    public(package) fun destroy_avatar_image(avatar_image: AvatarImage): (String, String) {
        let AvatarImage { id, image_url, equipped_cosmetics_hash } = avatar_image;
        id.delete();
        (image_url, equipped_cosmetics_hash)
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
