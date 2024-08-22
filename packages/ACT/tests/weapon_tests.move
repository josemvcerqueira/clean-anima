#[test_only]
module act::weapon_tests {

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
        weapon::{Self, Equip, Weapon}, 
        set_up_tests::set_up_admins
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
        equip_transfer_policy: TransferPolicy<Weapon>,
        trade_transfer_policy: TransferPolicy<Weapon>,
        equip_transfer_policy_cap: TransferPolicyCap<Weapon>,
        trade_transfer_policy_cap: TransferPolicyCap<Weapon>,
        display: Display<Weapon>,
        publisher: Publisher
    }

    #[test]
    fun test_initiates_correctly() {
        let world = start_world();

        assert_eq(world.display.fields().size(), 5);
        assert_eq(*world.display.fields().get(&b"name".to_string()), b"ACT Weapon: {name}".to_string());
        assert_eq(*world.display.fields().get(&b"description".to_string()), b"ACT is a fast-paced, high-skill multiplayer FPS".to_string());
        assert_eq(*world.display.fields().get(&b"image_url".to_string()), b"{image_url}".to_string());
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

        let weapon = new_weapon(world.scenario.ctx());

        assert_eq(weapon.hash(), b"hash");
        assert_eq(weapon.name(), b"warglaive of azzinoth".to_string());
        assert_eq(weapon.image_url(), b"https://conquestcapped.com/image/cache/catalog/wow/transmogs/legendary-items/warglaives-of-azzinoth-630x400.png".to_string());
        assert_eq(weapon.model_url(), b"dual wield sword".to_string());
        assert_eq(weapon.texture_url(), b"texture".to_string());
        assert_eq(weapon.slot(), b"slot1".to_string());
        assert_eq(weapon.colour_way(), b"green".to_string());
        assert_eq(weapon.edition(), b"soulbound".to_string());
        assert_eq(weapon.manufacturer(), b"Illidan Stormrage".to_string());
        assert_eq(weapon.rarity(), b"legendary".to_string());
        assert_eq(weapon.wear_rating(), 100);

        destroy(weapon);
        world.end();
    }

    #[test]
    fun test_upgrade() {
        let mut world = start_world();

        let mut weapon = new_weapon(world.scenario.ctx());

        assert_eq(weapon.upgrades().length(), 0);

        let upgrade = upgrade::new(
            b"upgrade_1".to_string(),
            b"image_1".to_string(),
            b"model_1".to_string(),
            b"texture_url".to_string(),
            world.scenario.ctx()
        );

        let upgrade_address = object::id(&upgrade);

        transfer::public_transfer(upgrade, object::id(&weapon).to_address());

        world.scenario.next_tx(OWNER);

        weapon.upgrade(receiving_ticket_by_id(upgrade_address));

        assert_eq(weapon.image_url(), b"image_1".to_string());
        assert_eq(weapon.model_url(), b"model_1".to_string());
        assert_eq(weapon.texture_url(), b"texture_url".to_string());

        assert_eq(weapon.upgrades().length(), 1);

        let upgrade = upgrade::new(
            b"upgrade_2".to_string(),
            b"image_2".to_string(),
            b"model_2".to_string(),
            b"texture_url_2".to_string(),
            world.scenario.ctx()
        );

        let upgrade_address = object::id(&upgrade);

        transfer::public_transfer(upgrade, object::id(&weapon).to_address());

        world.scenario.next_tx(OWNER);

        weapon.upgrade(receiving_ticket_by_id(upgrade_address));

        assert_eq(weapon.image_url(), b"image_2".to_string());
        assert_eq(weapon.model_url(), b"model_2".to_string());
        assert_eq(weapon.texture_url(), b"texture_url_2".to_string());

        assert_eq(weapon.upgrades().length(), 2);

        destroy(weapon);
        world.end();
    }

    #[test]
    fun test_equip() {
        let mut world = start_world();

        let weapon = new_weapon(world.scenario.ctx());

        let weapon_id = object::id(&weapon);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), weapon);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        assert_eq(dof::exists_(&character.id, WeaponKey {}), false);

        weapon::equip(
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

        let weapon = new_weapon(world.scenario.ctx());

        let weapon_id = object::id(&weapon);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.equip_transfer_policy;
        let trade_transfer_policy = &world.trade_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), weapon);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        weapon::equip(
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

        weapon::unequip(
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

        let weapon = new_weapon(world.scenario.ctx());
        let second_weapon =  new_weapon(world.scenario.ctx());

        let weapon_id = object::id(&weapon);
        let second_weapon_id = object::id(&second_weapon);

        let kiosk_cap = &world.kiosk_cap;
        let equip_transfer_policy = &world.equip_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), weapon);
        world.kiosk.place(kiosk_cap.borrow(), second_weapon);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        weapon::equip(
            &mut character.id,
            WeaponKey {},
            weapon_id,
            &mut world.kiosk,
            kiosk_cap.borrow(),
            equip_transfer_policy,
            world.scenario.ctx()
        );

        weapon::equip(
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

        let weapon = new_weapon(world.scenario.ctx());

        let kiosk_cap = &world.kiosk_cap;
        let trade_transfer_policy = &world.trade_transfer_policy;

        world.kiosk.place(kiosk_cap.borrow(), weapon);

        let mut character = Character {
            id: object::new(world.scenario.ctx())
        };

        weapon::unequip(
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

        weapon::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, super_admin) = set_up_admins(&mut scenario);

        let (mut kiosk, kiosk_cap) = kiosk::new(scenario.ctx());

        let kiosk_cap = personal_kiosk::new(&mut kiosk, kiosk_cap, scenario.ctx());

        let display = scenario.take_from_sender<Display<Weapon>>();
        let publisher = scenario.take_from_sender<Publisher>();
        let equip_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Weapon>>();
        let trade_transfer_policy_cap = scenario.take_from_sender<TransferPolicyCap<Weapon>>();
        let equip_transfer_policy = scenario.take_shared<TransferPolicy<Weapon>>();
        let trade_transfer_policy = scenario.take_shared<TransferPolicy<Weapon>>();

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
            b"slot1".to_string(),
            b"green".to_string(),
            b"soulbound".to_string(),
            b"Illidan Stormrage".to_string(),
            b"legendary".to_string(),
            100,
            ctx
        )
    }

    fun end(world: World) {
        destroy(world);
    }
}