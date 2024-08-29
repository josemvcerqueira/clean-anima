module act::avatar {
    // === Imports ===

    use std::string::String;
    use sui::{
        package, 
        display,
        vec_map::{Self, VecMap},
        transfer_policy::TransferPolicy,
        dynamic_object_field as dof,
        kiosk::{Kiosk, KioskOwnerCap},
    };
    use animalib::{
        admin,
        access_control::{Admin, AccessControl}
    };
    use act::{
        attributes,
        weapon::{Self, Weapon}, 
        cosmetic::{Self, Cosmetic},
        profile_pictures::ProfilePictures,
    }; 

    // === Errors ===

    const EWeaponSlotAlreadyEquipped: u64 = 1;
    const ECosmeticSlotAlreadyEquipped: u64 = 2;
    const EWrongWeaponSlot: u64 = 3;
    const EWrongCosmeticType: u64 = 4;
    const EAvatarMintingIsDisabled: u64 = 5;

    // === Structs ===

    // one-time witness
    public struct AVATAR has drop {}
    
    public struct CosmeticKey(String) has copy, store, drop; 

    public struct WeaponKey(String) has copy, store, drop;

    public struct Avatar has key, store {
        id: UID,
        image_url: String,
        avatar_model: String,
        avatar_texture: String,
        edition: String,
        attributes: VecMap<String, String>,
        attributes_hash: VecMap<String, vector<u8>>,
        misc: VecMap<String, String>
    }

    public struct AvatarSettings has key {
        id: UID,
        edition: String,
        image_url: String,
        avatar_model: String,
        avatar_texture: String,
        active: bool
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(otw: AVATAR, ctx: &mut TxContext) {
        let keys = vector[
            b"name".to_string(),
            b"description".to_string(),
            b"image_url".to_string(),
            b"project_url".to_string(),
            b"creator".to_string(),
        ];
        let values = vector[
            b"ACT Avatar: {alias}".to_string(),
            b"An avatar for traversing metaversal worlds, designed by Anima Lab.".to_string(),
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

        let avatar_settings = AvatarSettings {
            id: object::new(ctx),
            edition: b"".to_string(),
            image_url: b"".to_string(),
            avatar_model: b"".to_string(),
            avatar_texture: b"".to_string(),
            active: false
        };

        transfer::share_object(avatar_settings);
    }

    public fun new(settings: &AvatarSettings, ctx: &mut TxContext): Avatar {
        assert!(settings.active, EAvatarMintingIsDisabled);

        Avatar {
            id: object::new(ctx),
            image_url: settings.image_url,
            avatar_model: settings.avatar_model,
            avatar_texture: settings.avatar_texture,
            edition: settings.edition,
            attributes: attributes::new(),
            attributes_hash: attributes::new_hashes(),
            misc: vec_map::empty()
        }
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
        pfps: &ProfilePictures,
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

        if (cosmetic_type == attributes::helm() || cosmetic_type == attributes::upper_torso() || cosmetic_type == attributes::chestpiece())
            self.update_image(pfps);
    }

    public fun unequip_weapons(
        self: &mut Avatar, 
        weapon_slots: vector<String>,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // trading policy
    ) {
        weapon_slots.do!(|weapon_slot| {
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
        });
    }

    public fun unequip_cosmetics(
        self: &mut Avatar,
        pfps: &ProfilePictures,
        cosmetic_types: vector<String>,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Cosmetic>, // trading policy
    ) {
        cosmetic_types.do!(|cosmetic_type| {
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
        });
        self.update_image(pfps);
    }

    // to be called after un/equip if helmet, chestpiece or upper torso have been changed
    public fun update_image(self: &mut Avatar, pfps: &ProfilePictures) {
        let image_url = pfps.get(
            self.attributes_hash[&attributes::helm()], 
            self.attributes_hash[&attributes::chestpiece()], 
            self.attributes_hash[&attributes::upper_torso()]
        );

        self.image_url = image_url;
    }

    // === Admin Functions ===

    public fun set_settings_edition(
        settings: &mut AvatarSettings,
        access_control: &AccessControl, 
        admin: &Admin,
        edition: String,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);

        settings.edition = edition;
    }

    public fun set_settings_image_url(
        settings: &mut AvatarSettings,
        access_control: &AccessControl, 
        admin: &Admin,
        image_url: String,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);

        settings.image_url = image_url;
    }

    public fun set_settings_avatar_model(
        settings: &mut AvatarSettings,
        access_control: &AccessControl, 
        admin: &Admin,
        avatar_model: String,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);

        settings.avatar_model = avatar_model;
    }

    public fun set_settings_avatar_texture(
        settings: &mut AvatarSettings,
        access_control: &AccessControl, 
        admin: &Admin,
        avatar_texture: String,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);

        settings.avatar_texture = avatar_texture;
    }

    public fun set_settings_active(
        settings: &mut AvatarSettings,
        access_control: &AccessControl, 
        admin: &Admin,
        active: bool
    ) {
        admin::assert_genesis_minter_role(access_control, admin);

        settings.active = active;
    }

    // === Public-Package Functions ===

    public(package) fun image_url(self: &Avatar): String {
        self.image_url
    }  

    public(package) fun avatar_model(self: &Avatar): String {
        self.avatar_model
    }    

    public(package) fun avatar_texture(self: &Avatar): String {
        self.avatar_texture
    }    

    public(package) fun edition(self: &Avatar): String {
        self.edition
    }

    public(package) fun attributes(self: &Avatar): &VecMap<String, String>{
        &self.attributes
    }

    public(package) fun has_weapon(self: &Avatar, slot: String): bool {
        dof::exists_(&self.id, WeaponKey(slot))
    }

    public(package) fun has_cosmetic(self: &Avatar, type_: String): bool {
        dof::exists_(&self.id, CosmeticKey(type_))
    }

    public(package) fun new_genesis_edition(
        ctx: &mut TxContext
    ): Avatar {
        Avatar {
            id: object::new(ctx),
            image_url: b"QmWCfdKVUDLaKyJiyy3rKaHAVYhAGS7k1gXaWoLRX8mjcD".to_string(),
            avatar_model: b"QmaKS7RQCZaLSq6XfmDakZC5boPCDhgGU8AK1Tdn5Xj3oi".to_string(),
            avatar_texture: b"QmefuZMw2GeveTYEmcaJf7QTHtyE99srP6FRK6bHPK2fNe".to_string(),
            edition: b"Genesis".to_string(),
            attributes: attributes::new(),
            attributes_hash: attributes::new_hashes(),
            misc: vec_map::empty()
        }
    }

    public(package) fun set_image(self: &mut Avatar, image_url: String) {
        self.image_url = image_url;
    }

    // === Test Functions === 
    
    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(AVATAR {}, ctx);
    }

    #[test_only]
    public use fun settings_edition as AvatarSettings.edition;
    public fun settings_edition(settings: &AvatarSettings): String {
        settings.edition
    }

    #[test_only]
    public use fun settings_image_url as AvatarSettings.image_url;
    public fun settings_image_url(settings: &AvatarSettings): String {
        settings.image_url
    }

    #[test_only]
    public use fun settings_avatar_model as AvatarSettings.avatar_model;
    public fun settings_avatar_model(settings: &AvatarSettings): String {
        settings.avatar_model
    }

    #[test_only]
    public use fun settings_avatar_texture as AvatarSettings.avatar_texture;
    public fun settings_avatar_texture(settings: &AvatarSettings): String {
        settings.avatar_texture
    }

    #[test_only]
    public use fun settings_avatar_active as AvatarSettings.active;
    public fun settings_avatar_active(settings: &AvatarSettings): bool {
        settings.active
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