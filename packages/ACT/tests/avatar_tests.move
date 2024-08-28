#[test_only]
module act::avatar_tests {
    use sui::{
        display::Display,
        test_utils::{assert_eq, destroy},
        kiosk::{Self, Kiosk},
        test_scenario::{Self as ts, Scenario},
        transfer_policy::{TransferPolicy, TransferPolicyCap},
    };
    use kiosk::personal_kiosk::{Self, PersonalKioskCap};
    use animalib::access_control::{Admin, AccessControl};
    use act::{
        attributes,
        weapon::{Self, Weapon},
        cosmetic::{Self, Cosmetic}, 
        set_up_tests::set_up_admins,
        avatar::{Self, Avatar, AvatarSettings},
        profile_pictures::{Self, ProfilePictures}
    };

    const OWNER: address = @0xBABE;

    public struct World {
        scenario: Scenario,
        super_admin: Admin,
        pfps: ProfilePictures,
        kiosk: Kiosk,
        kiosk_cap: PersonalKioskCap,
        access_control: AccessControl,
        avatar_display: Display<Avatar>,
        weapon_equip_transfer_policy: TransferPolicy<Weapon>,
        weapon_trade_transfer_policy: TransferPolicy<Weapon>,
        weapon_equip_transfer_policy_cap: TransferPolicyCap<Weapon>,
        weapon_trade_transfer_policy_cap: TransferPolicyCap<Weapon>,
        weapon_display: Display<Weapon>,
        avatar_settings: AvatarSettings,
        cosmetic_equip_transfer_policy: TransferPolicy<Cosmetic>,
        cosmetic_trade_transfer_policy: TransferPolicy<Cosmetic>,
        cosmetic_equip_transfer_policy_cap: TransferPolicyCap<Cosmetic>,
        cosmetic_trade_transfer_policy_cap: TransferPolicyCap<Cosmetic>,
        cosmetic_display: Display<Cosmetic>,
    }

    #[test]
    fun test_initiates_correctly() {
        let world = start_world();

        assert_eq(world.avatar_display.fields().size(), 5);
        assert_eq(*world.avatar_display.fields().get(&b"name".to_string()), b"ACT Avatar: {alias}".to_string());
        assert_eq(*world.avatar_display.fields().get(&b"description".to_string()), b"An avatar for traversing metaversal worlds, designed by Anima Lab.".to_string());
        assert_eq(*world.avatar_display.fields().get(&b"image_url".to_string()), b"{image_url}".to_string());
        assert_eq(*world.avatar_display.fields().get(&b"project_url".to_string()), b"https://animalabs.io".to_string());
        assert_eq(*world.avatar_display.fields().get(&b"creator".to_string()), b"Anima Labs".to_string());
        assert_eq(world.avatar_settings.edition(), b"".to_string());
        assert_eq(world.avatar_settings.image_url(), b"".to_string());
        assert_eq(world.avatar_settings.avatar_model(), b"".to_string());
        assert_eq(world.avatar_settings.avatar_texture(), b"".to_string());
        assert_eq(world.avatar_settings.active(), false);

        world.end();
    }

    #[test]
    fun test_new() {
        let mut world = start_world();

        let avatar = avatar::new_genesis_edition(world.scenario.ctx());

        assert_eq(avatar.image_url(), b"ipfs://QmWCfdKVUDLaKyJiyy3rKaHAVYhAGS7k1gXaWoLRX8mjcD".to_string());
        assert_eq(avatar.edition(), b"Genesis".to_string());
        //@ dev 16 cosmetics + 3 weapons
        assert_eq(avatar.attributes().size(), 20);
        assert_eq(avatar.attributes().keys(), attributes::new().keys());

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_equip_minted_weapon() {
        let mut world = start_world();

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());
        let weapon = new_weapon(world.scenario.ctx());

        assert_eq(avatar.has_weapon(attributes::primary()), false);

        avatar.equip_minted_weapon(weapon);

        assert_eq(avatar.has_weapon(attributes::primary()), true);

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_equip_minted_cosmetic() {
        let mut world = start_world();

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());
        let cosmetic = new_cosmetic(world.scenario.ctx());

        assert_eq(avatar.has_cosmetic(attributes::helm()), false);

        avatar.equip_minted_cosmetic(cosmetic);

        assert_eq(avatar.has_cosmetic(attributes::helm()), true);

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_unequip_weapon() {
        let mut world = start_world();

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());
        let weapon = new_weapon(world.scenario.ctx());
        let weapon_id = object::id(&weapon);

        let kiosk_cap = &world.kiosk_cap;
        let policy = &world.weapon_trade_transfer_policy;

        avatar.equip_minted_weapon(weapon);

        assert_eq(world.kiosk.has_item(weapon_id), false);
        assert_eq(avatar.has_weapon(attributes::primary()), true);

        avatar.unequip_weapons(
            vector[attributes::primary()], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            policy,
        );

        assert_eq(world.kiosk.has_item(weapon_id), true);
        assert_eq(avatar.has_weapon(attributes::primary()), false);

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_unequip_cosmetic() {
        let mut world = start_world();

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());
        let cosmetic = new_cosmetic(world.scenario.ctx());
        let cosmetic_id = object::id(&cosmetic);

        let kiosk_cap = &world.kiosk_cap;
        let policy = &world.cosmetic_trade_transfer_policy;

        assert_eq(world.kiosk.has_item(cosmetic_id), false);

        avatar.equip_minted_cosmetic(cosmetic);

        assert_eq(avatar.has_cosmetic(attributes::helm()), true);

        avatar.unequip_cosmetics(
            &world.pfps,
            vector[attributes::helm()], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            policy,
        );
        
        assert_eq(avatar.has_cosmetic(attributes::helm()), false);
        assert_eq(world.kiosk.has_item(cosmetic_id), true);

        destroy(avatar);
        world.end();
    }  

    #[test]
    fun test_equip_weapon() {
        let mut world = start_world();

        let weapon = new_weapon(world.scenario.ctx());

        let weapon_id = object::id(&weapon);
        let slot = weapon.slot();

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.weapon_equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), weapon);

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());

        assert_eq(avatar.has_weapon(slot), false);

        avatar.equip_weapons(
            vector[weapon_id], 
            vector[slot], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            equip_transfer_policy, 
            world.scenario.ctx()
        );

        assert_eq(avatar.has_weapon(slot), true);

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_equip_cosmetic() {
        let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());

        let cosmetic_id = object::id(&cosmetic);
        let type_ = cosmetic.type_();

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.cosmetic_equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), cosmetic);

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());

        assert_eq(avatar.has_cosmetic(type_), false);

        avatar.equip_cosmetics(
            &world.pfps,
            vector[cosmetic_id], 
            vector[type_], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            equip_transfer_policy, 
            world.scenario.ctx()
        );

        assert_eq(avatar.has_cosmetic(type_), true);

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_equip_2_weapons() {
        let mut world = start_world();

        let weapon = new_weapon(world.scenario.ctx());

        let weapon_id = object::id(&weapon);
        let slot = weapon.slot();

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.weapon_equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), weapon);

        let weapon_2 = new_weapon_2(world.scenario.ctx());

        let weapon_2_id = object::id(&weapon_2);
        let slot_2 = weapon_2.slot();

        world.kiosk.place(kiosk_cap.borrow(), weapon_2);

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());

        assert_eq(avatar.has_weapon(slot), false);
        assert_eq(avatar.has_weapon(slot_2), false);
        assert_eq(avatar.attributes()[&slot], b"".to_string());
        assert_eq(avatar.attributes()[&slot_2], b"".to_string());

        avatar.equip_weapons(
            vector[weapon_id, weapon_2_id], 
            vector[slot, slot_2], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            equip_transfer_policy, 
            world.scenario.ctx()
        );

        assert_eq(avatar.attributes()[&slot], b"warglaive of azzinoth".to_string());
        assert_eq(avatar.attributes()[&slot_2], b"weapon2".to_string());
        assert_eq(avatar.has_weapon(slot_2), true);
        assert_eq(avatar.has_weapon(slot), true);

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_equip_2_cosmetics() {
        let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());

        let cosmetic_id = object::id(&cosmetic);
        let type_ = cosmetic.type_();

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.cosmetic_equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), cosmetic);

        let cosmetic_2 = new_cosmetic_2(world.scenario.ctx());

        let cosmetic_2_id = object::id(&cosmetic_2);
        let type_2 = cosmetic_2.type_();

        world.kiosk.place(kiosk_cap.borrow(), cosmetic_2);

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());

        assert_eq(avatar.has_cosmetic(type_), false);
        assert_eq(avatar.has_cosmetic(type_2), false);
        assert_eq(avatar.attributes()[&type_], b"".to_string());
        assert_eq(avatar.attributes()[&type_2], b"".to_string());

        avatar.equip_cosmetics(
            &world.pfps,
            vector[cosmetic_id, cosmetic_2_id], 
            vector[type_, type_2], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            equip_transfer_policy, 
            world.scenario.ctx()
        );

        assert_eq(avatar.has_cosmetic(type_), true);
        assert_eq(avatar.has_cosmetic(type_2), true);
        assert_eq(avatar.attributes()[&type_], b"cursed vision of sargeras".to_string());
        assert_eq(avatar.attributes()[&type_2], b"glove".to_string());

        destroy(avatar);
        world.end();
    }

    #[test]
    #[expected_failure(abort_code = avatar::EWrongWeaponSlot)]
    fun test_equip_weapon_error_wrong_slot() {
        let mut world = start_world();

        let weapon = new_weapon(world.scenario.ctx());

        let weapon_id = object::id(&weapon);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.weapon_equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), weapon);

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());

        avatar.equip_weapons(
            vector[weapon_id], 
            vector[attributes::secondary()], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            equip_transfer_policy, 
            world.scenario.ctx()
        );

        destroy(avatar);
        world.end();
    }

    #[test]
    fun test_avatar_settings_correctly() {
        let mut world = start_world();

        assert_eq(world.avatar_settings.edition(), b"".to_string());
        assert_eq(world.avatar_settings.image_url(), b"".to_string());
        assert_eq(world.avatar_settings.avatar_model(), b"".to_string());
        assert_eq(world.avatar_settings.avatar_texture(), b"".to_string());
        assert_eq(world.avatar_settings.active(), false);

        let admin = &world.super_admin;
        let access_control = &world.access_control;

        world.avatar_settings.set_settings_active(access_control, admin, true);
        world.avatar_settings.set_settings_avatar_model(access_control, admin, b"model".to_string());
        world.avatar_settings.set_settings_avatar_texture(access_control, admin, b"texture".to_string());
        world.avatar_settings.set_settings_edition(access_control, admin, b"Standard".to_string());
        world.avatar_settings.set_settings_image_url(access_control, admin, b"image_url".to_string());

        assert_eq(world.avatar_settings.edition(), b"Standard".to_string());
        assert_eq(world.avatar_settings.image_url(), b"image_url".to_string());
        assert_eq(world.avatar_settings.avatar_model(), b"model".to_string());
        assert_eq(world.avatar_settings.avatar_texture(), b"texture".to_string());
        assert_eq(world.avatar_settings.active(), true);

        world.end();
    }

    #[test]
    #[expected_failure(abort_code = avatar::EWrongCosmeticType)]
    fun test_equip_cosmetic_error_wrong_type() {
       let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());

        let cosmetic_id = object::id(&cosmetic);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.cosmetic_equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), cosmetic);

        let mut avatar = avatar::new_genesis_edition(world.scenario.ctx());

        avatar.equip_cosmetics(
            &world.pfps,
            vector[cosmetic_id], 
            vector[attributes::chestpiece()], 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            equip_transfer_policy, 
            world.scenario.ctx()
        );

        destroy(avatar);
        world.end();
    }

    fun start_world(): World {
        let mut scenario = ts::begin(OWNER);

        avatar::init_for_testing(scenario.ctx());
        weapon::init_for_testing(scenario.ctx());
        cosmetic::init_for_testing(scenario.ctx());
        profile_pictures::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, super_admin) = set_up_admins(&mut scenario);

        let (mut kiosk, kiosk_cap) = kiosk::new(scenario.ctx());

        let kiosk_cap = personal_kiosk::new(&mut kiosk, kiosk_cap, scenario.ctx());

        let weapon_display = scenario.take_from_sender<Display<Weapon>>();
        let weapon_equip_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Weapon>>();
        let weapon_trade_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Weapon>>();
        let weapon_equip_transfer_policy = scenario.take_shared<TransferPolicy<Weapon>>();
        let weapon_trade_transfer_policy = scenario.take_shared<TransferPolicy<Weapon>>();
        
        let cosmetic_display = scenario.take_from_sender<Display<Cosmetic>>();
        let cosmetic_equip_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Cosmetic>>();
        let cosmetic_trade_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Cosmetic>>();
        let cosmetic_equip_transfer_policy = scenario.take_shared<TransferPolicy<Cosmetic>>();
        let cosmetic_trade_transfer_policy = scenario.take_shared<TransferPolicy<Cosmetic>>();

        let avatar_settings = scenario.take_shared<AvatarSettings>();

        let mut pfps = scenario.take_shared<ProfilePictures>();

        pfps.add(
            &access_control, 
            &super_admin, 
            x"1e5f8f12e2ea31bfbf9a0a23df3b428a8214430f07546dc31f676075ea8f3ac9", 
            x"261eca532eda70cad058ae4e5f1f71f477e6828d344d73b6ea66015bfcb29492", 
            x"3ee11c5e2449a9b0778bcd37ac21210e3c83d2569d62c44b5e8f86df992d0354", 
            b"image".to_string()
        );

        pfps.add(
            &access_control, 
            &super_admin, 
            x"68617368", 
            x"", 
            x"", 
            b"image".to_string()
        );

        pfps.add(
            &access_control, 
            &super_admin, 
            x"", 
            x"", 
            x"", 
            b"image".to_string()
        );

        scenario.next_tx(OWNER);

        let avatar_display = scenario.take_from_sender<Display<Avatar>>();

        World {
            pfps,
            scenario,
            avatar_display,
            weapon_display,
            cosmetic_display,
            kiosk,
            avatar_settings,
            kiosk_cap,
            weapon_trade_transfer_policy_cap,
            weapon_equip_transfer_policy_cap,
            weapon_trade_transfer_policy,
            weapon_equip_transfer_policy,
            cosmetic_trade_transfer_policy_cap,
            cosmetic_equip_transfer_policy_cap,
            cosmetic_trade_transfer_policy,
            cosmetic_equip_transfer_policy,
            access_control,
            super_admin,
        }
    }

    fun new_weapon(ctx: &mut TxContext): Weapon {
        weapon::new(
            b"hash",
            b"warglaive of azzinoth".to_string(),
            b"https://conquestcapped.com/image/cache/catalog/wow/transmogs/legendary-items/warglaives-of-azzinoth-630x400.png".to_string(),
            b"dual wield sword".to_string(),
            b"texture".to_string(),
            attributes::primary(),
            b"green".to_string(),
            b"soulbound".to_string(),
            b"Illidan Stormrage".to_string(),
            b"legendary".to_string(),
            100,
            ctx
        )
    }

    fun new_weapon_2(ctx: &mut TxContext): Weapon {
        weapon::new(
            b"hash",
            b"weapon2".to_string(),
            b"".to_string(),
            b"".to_string(),
            b"texture".to_string(),
            attributes::secondary(),
            b"green".to_string(),
            b"".to_string(),
            b"".to_string(),
            b"epic".to_string(),
            95,
            ctx
        )
    }

    fun new_cosmetic(ctx: &mut TxContext): Cosmetic {
        cosmetic::new(
            b"hash",
            b"cursed vision of sargeras".to_string(),
            b"https://wow.zamimg.com/uploads/screenshots/normal/446667-cursed-vision-of-sargeras.jpg".to_string(),
            b"head".to_string(),
            b"texture".to_string(),
            attributes::helm(),
            b"red".to_string(),
            b"soulbound".to_string(),
            b"Illidan Stormrage".to_string(),
            b"epic".to_string(),
            95,
            ctx
        )
    }

    fun new_cosmetic_2(ctx: &mut TxContext): Cosmetic {
        cosmetic::new(
            b"hash",
            b"glove".to_string(),
            b"https://wow.zamimg.com/uploads/screenshots/normal/446667-cursed-vision-of-sargeras.jpg".to_string(),
            b"head".to_string(),
            b"texture".to_string(),
            attributes::right_glove(),
            b"red".to_string(),
            b"soulbound".to_string(),
            b"Illidan Stormrage".to_string(),
            b"epic".to_string(),
            95,
            ctx
        )
    }

    fun end(world: World) {
        destroy(world);
    }
}