#[test_only]
module act::cosmetic_tests {

    use std::type_name;
    use sui::{
        vec_set,
        display::Display,
        package::Publisher,
        dynamic_object_field as dof,
        test_utils::{assert_eq, destroy},
        kiosk::{Self, Kiosk},
        test_scenario::{Self as ts, receiving_ticket_by_id, Scenario},
        transfer_policy::{TransferPolicy, TransferPolicyCap},
    };
    use kiosk::{
        royalty_rule, 
        kiosk_lock_rule, 
        witness_rule, 
        personal_kiosk_rule,
        personal_kiosk::{Self, PersonalKioskCap}
    };
    use animalib::access_control::{Admin, AccessControl};
    use act::{
        item,
        upgrade,
        set_up_tests::set_up_admins,
        cosmetic::{Self, Equip, Cosmetic}, 
    };

    const OWNER: address = @0xBABE;

    public struct Character has key, store {
        id: UID
    }

    public struct WeaponKey has copy, store, drop {}

    public struct World {
        scenario: Scenario,
        super_admin: Admin,
        kiosk: Kiosk,
        kiosk_cap: PersonalKioskCap,
        access_control: AccessControl,
        equip_transfer_policy: TransferPolicy<Cosmetic>,
        trade_transfer_policy: TransferPolicy<Cosmetic>,
        equip_transfer_policy_cap: TransferPolicyCap<Cosmetic>,
        trade_transfer_policy_cap: TransferPolicyCap<Cosmetic>,
        display: Display<Cosmetic>,
        publisher: Publisher
    }

    #[test]
    fun test_initiates_correctly() {
        let world = start_world();

        assert_eq(world.display.fields().size(), 5);
        assert_eq(*world.display.fields().get(&b"name".to_string()), b"ACT Cosmetic: {name}".to_string());
        assert_eq(*world.display.fields().get(&b"description".to_string()), b"ACT is a fast-paced, high-skill multiplayer FPS".to_string());
        assert_eq(*world.display.fields().get(&b"image_url".to_string()), b"ipfs://{image_url}".to_string());
        assert_eq(*world.display.fields().get(&b"project_url".to_string()), b"https://animalabs.io".to_string());
        assert_eq(*world.display.fields().get(&b"creator".to_string()), b"Anima Labs".to_string());

        let mut rules = vec_set::empty();
        rules.insert(type_name::get<royalty_rule::Rule>());
        rules.insert(type_name::get<kiosk_lock_rule::Rule>());
        rules.insert(type_name::get<personal_kiosk_rule::Rule>());

        assert_eq((*world.trade_transfer_policy.rules()).into_keys(), rules.into_keys());

        let mut rules = vec_set::empty();
        rules.insert(type_name::get<witness_rule::Rule<Equip>>());
        assert_eq((*world.equip_transfer_policy.rules()).into_keys(), rules.into_keys());

        world.end();
    }

    #[test]
    fun test_new() {
        let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());

        assert_eq(cosmetic.hash(), b"hash");
        assert_eq(cosmetic.name(), b"cursed vision of sargeras".to_string());
        assert_eq(cosmetic.image_url(), b"https://wow.zamimg.com/uploads/screenshots/normal/446667-cursed-vision-of-sargeras.jpg".to_string());
        assert_eq(cosmetic.model_url(), b"head".to_string());
        assert_eq(cosmetic.texture_url(), b"texture".to_string());
        assert_eq(cosmetic.type_(), b"leather".to_string());
        assert_eq(cosmetic.colour_way(), b"red".to_string());
        assert_eq(cosmetic.edition(), b"soulbound".to_string());
        assert_eq(cosmetic.manufacturer(), b"Illidan Stormrage".to_string());
        assert_eq(cosmetic.rarity(), b"epic".to_string());
        assert_eq(cosmetic.wear_rating(), 95);

        destroy(cosmetic);
        world.end();
    }

    #[test]
    fun test_upgrade() {
        let mut world = start_world();

        let mut cosmetic = new_cosmetic(world.scenario.ctx());

        assert_eq(cosmetic.upgrades().length(), 0);

        let upgrade = upgrade::new(
            b"upgrade_1".to_string(),
            b"image_1".to_string(),
            b"model_1".to_string(),
            b"texture_url".to_string(),
            world.scenario.ctx()
        );

        let upgrade_address = object::id(&upgrade);

        transfer::public_transfer(upgrade, object::id(&cosmetic).to_address());

        world.scenario.next_tx(OWNER);

        cosmetic.upgrade(receiving_ticket_by_id(upgrade_address));

        assert_eq(cosmetic.image_url(), b"image_1".to_string());
        assert_eq(cosmetic.model_url(), b"model_1".to_string());
        assert_eq(cosmetic.texture_url(), b"texture_url".to_string());

        assert_eq(cosmetic.upgrades().length(), 1);

        let upgrade = upgrade::new(
            b"upgrade_2".to_string(),
            b"image_2".to_string(),
            b"model_2".to_string(),
            b"texture_url_2".to_string(),
            world.scenario.ctx()
        );

        let upgrade_address = object::id(&upgrade);

        transfer::public_transfer(upgrade, object::id(&cosmetic).to_address());

        world.scenario.next_tx(OWNER);

        cosmetic.upgrade(receiving_ticket_by_id(upgrade_address));

        assert_eq(cosmetic.image_url(), b"image_2".to_string());
        assert_eq(cosmetic.model_url(), b"model_2".to_string());
        assert_eq(cosmetic.texture_url(), b"texture_url_2".to_string());

        assert_eq(cosmetic.upgrades().length(), 2);

        destroy(cosmetic);
        world.end();
    }

    #[test]
    fun test_equip() {
        let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());

        let weapon_id = object::id(&cosmetic);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), cosmetic);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        assert_eq(dof::exists_(&character.id, WeaponKey {}), false);

        cosmetic::equip(
            &mut character.id,
            WeaponKey {},
            weapon_id,
            &mut world.kiosk,
            kiosk_cap.borrow(),
            equip_transfer_policy,
            world.scenario.ctx()
        );

        assert_eq(dof::exists_(&character.id, WeaponKey {}), true);

        destroy(character);
        world.end();
    }

    #[test]
    fun test_unequip() {
        let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());

        let weapon_id = object::id(&cosmetic);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.equip_transfer_policy;
        let trade_transfer_policy = &world.trade_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), cosmetic);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        cosmetic::equip(
            &mut character.id,
            WeaponKey {},
            weapon_id,
            &mut world.kiosk,
            kiosk_cap.borrow(),
            equip_transfer_policy,
            world.scenario.ctx()
        );

        assert_eq(dof::exists_(&character.id, WeaponKey {}), true);
        assert_eq(world.kiosk.has_item(weapon_id), false);

        cosmetic::unequip(
            &mut character.id,
            WeaponKey {},
            &mut world.kiosk,
            kiosk_cap.borrow(),
            trade_transfer_policy
        );

        assert_eq(dof::exists_(&character.id, WeaponKey {}), false);
        assert_eq(world.kiosk.has_item(weapon_id), true);

        destroy(character);
        world.end();
    }

    #[test]
    #[expected_failure(abort_code = item::EItemTypeAlreadyEquipped)]
    fun test_equip_error_type_already_equipped() {
        let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());
        let second_weapon =  new_cosmetic(world.scenario.ctx());

        let weapon_id = object::id(&cosmetic);
        let second_weapon_id = object::id(&second_weapon);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), cosmetic);
        world.kiosk.place(kiosk_cap.borrow(), second_weapon);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        cosmetic::equip(
            &mut character.id,
            WeaponKey {},
            weapon_id,
            &mut world.kiosk,
            kiosk_cap.borrow(),
            equip_transfer_policy,
            world.scenario.ctx()
        );

        cosmetic::equip(
            &mut character.id,
            WeaponKey {},
            second_weapon_id,
            &mut world.kiosk,
            kiosk_cap.borrow(),
            equip_transfer_policy,
            world.scenario.ctx()
        );

        destroy(character);
        world.end();
    }

    #[test]
    #[expected_failure(abort_code = item::EItemTypeNotEquipped)]
    fun test_unequip_error_type_not_equipped() {
        let mut world = start_world();

        let cosmetic = new_cosmetic(world.scenario.ctx());

        let kiosk_cap = &world.kiosk_cap;
        let trade_transfer_policy = &world.trade_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), cosmetic);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        cosmetic::unequip(
            &mut character.id,
            WeaponKey {},
            &mut world.kiosk,
            kiosk_cap.borrow(),
            trade_transfer_policy
        );

        destroy(character);
        world.end();
    }

    fun start_world(): World {
        let mut scenario = ts::begin(OWNER);

        cosmetic::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, super_admin) = set_up_admins(&mut scenario);

        let (mut kiosk, kiosk_cap) = kiosk::new(scenario.ctx());
        
        let kiosk_cap = personal_kiosk::new(&mut kiosk, kiosk_cap, scenario.ctx());

        let display = scenario.take_from_sender<Display<Cosmetic>>();
        let publisher = scenario.take_from_sender<Publisher>();
        let equip_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Cosmetic>>();
        let trade_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Cosmetic>>();
        let equip_transfer_policy = scenario.take_shared<TransferPolicy<Cosmetic>>();
        let trade_transfer_policy = scenario.take_shared<TransferPolicy<Cosmetic>>();

        World {
            scenario,
            display,
            publisher,
            kiosk,
            kiosk_cap,
            trade_transfer_policy_cap,
            equip_transfer_policy_cap,
            trade_transfer_policy,
            equip_transfer_policy,
            access_control,
            super_admin
        }
    }

    fun new_cosmetic(ctx: &mut TxContext): Cosmetic {
        cosmetic::new(
            b"hash",
            b"cursed vision of sargeras".to_string(),
            b"https://wow.zamimg.com/uploads/screenshots/normal/446667-cursed-vision-of-sargeras.jpg".to_string(),
            b"head".to_string(),
            b"texture".to_string(),
            b"leather".to_string(),
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