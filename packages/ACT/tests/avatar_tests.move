#[test_only]
module act::avatar_tests {
    use sui::{
        display::Display,
        test_utils::{assert_eq, destroy},
        kiosk::{Self, Kiosk},
        test_scenario::{Self as ts, receiving_ticket_by_id, Scenario},
        transfer_policy::{TransferPolicy, TransferPolicyCap},
    };
    use kiosk::personal_kiosk::{Self, PersonalKioskCap};
    use animalib::access_control::{Admin, AccessControl};
    use act::{
        attributes,
        weapon::{Self, Weapon},
        cosmetic::{Self, Cosmetic}, 
        set_up_tests::set_up_admins,
        avatar::{Self, Avatar, AvatarRegistry},
    };

    const OWNER: address = @0xBABE;

    public struct World {
        scenario: Scenario,
        super_admin: Admin,
        kiosk: Kiosk,
        avatar_registry: AvatarRegistry,
        kiosk_cap: PersonalKioskCap,
        access_control: AccessControl,
        avatar_display: Display<Avatar>,
        weapon_equip_transfer_policy: TransferPolicy<Weapon>,
        weapon_trade_transfer_policy: TransferPolicy<Weapon>,
        weapon_equip_transfer_policy_cap: TransferPolicyCap<Weapon>,
        weapon_trade_transfer_policy_cap: TransferPolicyCap<Weapon>,
        weapon_display: Display<Weapon>,
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
        assert_eq(*world.avatar_display.fields().get(&b"description".to_string()), b"ACT is a fast-paced, high-skill multiplayer FPS".to_string());
        assert_eq(*world.avatar_display.fields().get(&b"image_url".to_string()), b"{image_url}".to_string());
        assert_eq(*world.avatar_display.fields().get(&b"project_url".to_string()), b"https://animalabs.io".to_string());
        assert_eq(*world.avatar_display.fields().get(&b"creator".to_string()), b"Anima Labs".to_string());

        world.end();
    }

    #[test]
    fun test_new() {
        let mut world = start_world();

        world.avatar_registry.assert_no_avatar(OWNER);

        let avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());

        world.avatar_registry.assert_has_avatar(OWNER);

        assert_eq(avatar.image_url(), b"QmXdqWcqFWNp6RrTy8t2Np1xyNL7TatQGEiRQC1f4iW87x".to_string());
        assert_eq(avatar.edition(), b"Standard".to_string());
        //@ dev 16 cosmetics + 3 weapons
        assert_eq(avatar.attributes().size(), 20);
        assert_eq(avatar.attributes().keys(), attributes::new().keys());

        avatar.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_equip_minted_weapon() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());
        let weapon = new_weapon(world.scenario.ctx());

        assert_eq(avatar.has_weapon(attributes::primary()), false);

        avatar.equip_minted_weapon(weapon);

        assert_eq(avatar.has_weapon(attributes::primary()), true);

        avatar.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_equip_minted_cosmetic() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());
        let cosmetic = new_cosmetic(world.scenario.ctx());

        assert_eq(avatar.has_cosmetic(attributes::helm()), false);

        avatar.equip_minted_cosmetic(cosmetic);

        assert_eq(avatar.has_cosmetic(attributes::helm()), true);

        avatar.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_unequip_weapon() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());
        let weapon = new_weapon(world.scenario.ctx());
        let weapon_id = object::id(&weapon);

        let kiosk_cap = &world.kiosk_cap;
        let policy = &world.weapon_trade_transfer_policy;

        avatar.equip_minted_weapon(weapon);

        assert_eq(world.kiosk.has_item(weapon_id), false);
        assert_eq(avatar.has_weapon(attributes::primary()), true);

        avatar.unequip_weapon(
            attributes::primary(), 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            policy,
        );

        assert_eq(world.kiosk.has_item(weapon_id), true);
        assert_eq(avatar.has_weapon(attributes::primary()), false);

        avatar.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_unequip_cosmetic() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());
        let cosmetic = new_cosmetic(world.scenario.ctx());
        let cosmetic_id = object::id(&cosmetic);

        let kiosk_cap = &world.kiosk_cap;
        let policy = &world.cosmetic_trade_transfer_policy;

        assert_eq(world.kiosk.has_item(cosmetic_id), false);

        avatar.equip_minted_cosmetic(cosmetic);

        assert_eq(avatar.has_cosmetic(attributes::helm()), true);

        avatar.unequip_cosmetic(
            attributes::helm(), 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            policy,
        );
        
        assert_eq(avatar.has_cosmetic(attributes::helm()), false);
        assert_eq(world.kiosk.has_item(cosmetic_id), true);

        avatar.keep(world.scenario.ctx());
        world.end();
    }  

    #[test]
    fun test_upgrade() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());

        assert_eq(avatar.upgrades().length(), 0);

        avatar::new_upgrade(
            &world.access_control, 
            &world.super_admin, 
            b"upgrade_name".to_string(),
            b"upgrade_image_url".to_string(),
            b"upgrade_model_url".to_string(),
            b"upgrade_texture_url".to_string(),
            object::id(&avatar).to_address(),
            world.scenario.ctx()
        );

        let effects = world.scenario.next_tx(OWNER);

        assert_eq(avatar.upgrades().length(), 0);

        avatar.upgrade(receiving_ticket_by_id(effects.created()[0]));

        assert_eq(avatar.upgrades().length(), 1);
        assert_eq(avatar.image_url(), b"upgrade_image_url".to_string());
        assert_eq(avatar.avatar_model(), b"upgrade_model_url".to_string());
        assert_eq(avatar.avatar_texture(), b"upgrade_texture_url".to_string());

        avatar.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_upgrade_equipped_weapon() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());
        let weapon = new_weapon(world.scenario.ctx());

        assert_eq(weapon.upgrades().length(), 0);

        let weapon_address = object::id(&weapon).to_address();
        let slot = weapon.slot();

        avatar.equip_minted_weapon(weapon);

        assert_eq(avatar.borrow_equipped_weapon(attributes::primary()).upgrades().length(), 0);

        world.scenario.next_tx(OWNER);

        avatar::new_upgrade(
            &world.access_control, 
            &world.super_admin, 
            b"upgrade_name".to_string(),
            b"upgrade_image_url".to_string(),
            b"upgrade_model_url".to_string(),
            b"upgrade_texture_url".to_string(),
            weapon_address,
            world.scenario.ctx()
        );

        let effects = world.scenario.next_tx(OWNER);

        avatar.upgrade_equipped_weapon(receiving_ticket_by_id(effects.created()[0]), slot);

        assert_eq(avatar.borrow_equipped_weapon(attributes::primary()).upgrades().length(), 1);
        assert_eq(avatar.borrow_equipped_weapon(attributes::primary()).image_url(), b"upgrade_image_url".to_string());
        assert_eq(avatar.borrow_equipped_weapon(attributes::primary()).model_url(), b"upgrade_model_url".to_string());
        assert_eq(avatar.borrow_equipped_weapon(attributes::primary()).texture_url(), b"upgrade_texture_url".to_string());

        avatar.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_upgrade_equipped_cosmetic() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());
        let cosmetic = new_cosmetic(world.scenario.ctx());

        let cosmetic_address = object::id(&cosmetic).to_address();
        let type_ = cosmetic.type_();

        assert_eq(cosmetic.upgrades().length(), 0);

        avatar.equip_minted_cosmetic(cosmetic);

        assert_eq(avatar.borrow_equipped_cosmetic(attributes::helm()).upgrades().length(), 0);

        world.scenario.next_tx(OWNER);

        avatar::new_upgrade(
            &world.access_control, 
            &world.super_admin, 
            b"upgrade_name".to_string(),
            b"upgrade_image_url".to_string(),
            b"upgrade_model_url".to_string(),
            b"upgrade_texture_url".to_string(),
            cosmetic_address,
            world.scenario.ctx()
        );

        let effects = world.scenario.next_tx(OWNER);

        avatar.upgrade_equipped_cosmetic(receiving_ticket_by_id(effects.created()[0]), type_);

        assert_eq(avatar.borrow_equipped_cosmetic(attributes::helm()).upgrades().length(), 1);
        assert_eq(avatar.borrow_equipped_cosmetic(attributes::helm()).image_url(), b"upgrade_image_url".to_string());
        assert_eq(avatar.borrow_equipped_cosmetic(attributes::helm()).model_url(), b"upgrade_model_url".to_string());
        assert_eq(avatar.borrow_equipped_cosmetic(attributes::helm()).texture_url(), b"upgrade_texture_url".to_string());

        avatar.keep(world.scenario.ctx());
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

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());

        assert_eq(avatar.has_weapon(slot), false);

        avatar.equip_weapon(
            weapon_id, 
            slot, 
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

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());

        assert_eq(avatar.has_cosmetic(type_), false);

        avatar.equip_cosmetic(
            cosmetic_id, 
            type_, 
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
    fun test_update_avatar_image() {
        let mut world = start_world();

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());

        let access_control = &world.access_control;
        let admin = &world.super_admin;

        avatar::new_avatar_image(
            access_control, 
            admin, 
            b"image2".to_string(), 
            b"hash2".to_string(),
            object::id(&avatar).to_address(),
            world.scenario.ctx()
        );

        assert_eq(avatar.image_url(), b"QmXdqWcqFWNp6RrTy8t2Np1xyNL7TatQGEiRQC1f4iW87x".to_string());
        assert_eq(avatar.equipped_cosmetics_hash(), b"".to_string());

        let effects = world.scenario.next_tx(OWNER);

        avatar.update_avatar(receiving_ticket_by_id(effects.created()[0]));

        assert_eq(avatar.image_url(), b"image2".to_string());
        assert_eq(avatar.equipped_cosmetics_hash(), b"hash2".to_string());

        avatar.keep(world.scenario.ctx());
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

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());

        avatar.equip_weapon(
            weapon_id, 
            attributes::secondary(), 
            &mut world.kiosk, 
            kiosk_cap.borrow(), 
            equip_transfer_policy, 
            world.scenario.ctx()
        );

        destroy(avatar);
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

        let mut avatar = new_avatar(&mut world.avatar_registry, world.scenario.ctx());

        avatar.equip_cosmetic(
            cosmetic_id, 
            attributes::chestpiece(), 
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

        scenario.next_tx(OWNER);

        let avatar_display = scenario.take_from_sender<Display<Avatar>>();
        let avatar_registry = scenario.take_shared<AvatarRegistry>();

        World {
            scenario,
            avatar_registry,
            avatar_display,
            weapon_display,
            cosmetic_display,
            kiosk,
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

    fun new_avatar(registry: &mut AvatarRegistry, ctx: &mut TxContext): Avatar {
        avatar::new(
            registry,
            ctx
        )
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

    fun end(world: World) {
        destroy(world);
    }
}