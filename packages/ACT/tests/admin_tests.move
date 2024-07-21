module act::admin_tests {
    
    use sui::{
        test_utils::{assert_eq, destroy},
        test_scenario::{Self as ts, Scenario}
    };

    use animalib::access_control::{Admin, AccessControl};

    use act::admin;

    const OWNER: address = @0xBABE;
    const UPGRADES_ROLE: vector<u8> = b"UPGRADES_ROLE";
    const REPUTATION_ROLE: vector<u8> = b"REPUTATION_ROLE";
    const GENESIS_MINTER_ROLE: vector<u8> = b"GENESIS_MINTER_ROLE";

    #[test]
    fun test_init() {
        let world = start();

        assert_eq(world.super_admin.has_role(&world.access_control, UPGRADES_ROLE), false);
        assert_eq(world.super_admin.has_role(&world.access_control, REPUTATION_ROLE), false);
        assert_eq(world.super_admin.has_role(&world.access_control, GENESIS_MINTER_ROLE), false);

        assert_eq(world.access_control.contains(UPGRADES_ROLE), true);
        assert_eq(world.access_control.contains(REPUTATION_ROLE), true);
        assert_eq(world.access_control.contains(GENESIS_MINTER_ROLE), true);

        admin::assert_upgrades_role(&world.access_control, &world.admin);
        admin::assert_reputation_role(&world.access_control, &world.admin);
        admin::assert_genesis_minter_role(&world.access_control, &world.admin);

        world.end();
    }

    #[test]
    #[expected_failure(abort_code = admin::EInvalidRole)]
    fun test_error_assert_reputation_role() {
        let world = start();

        admin::assert_reputation_role(&world.access_control, &world.super_admin);

        world.end();
    }

    #[test]
    #[expected_failure(abort_code = admin::EInvalidRole)]
    fun test_error_assert_upgrades_role() {
        let world = start();

        admin::assert_upgrades_role(&world.access_control, &world.super_admin);

        world.end();
    }

    #[test]
    #[expected_failure(abort_code = admin::EInvalidRole)]
    fun test_error_assert_genesis_minter_role() {
        let world = start();

        admin::assert_genesis_minter_role(&world.access_control, &world.super_admin);

        world.end();
    }

    // === Set Up ===

    public struct World {
        admin: Admin,
        super_admin: Admin,
        access_control: AccessControl,
        scenario: Scenario
    }

    public fun start(): World {
        let mut scenario = ts::begin(OWNER);

        admin::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let access_control = scenario.take_shared<AccessControl>();
        let super_admin = scenario.take_from_sender<Admin>();
        let admin = scenario.take_from_sender<Admin>();

        World {
            access_control,
            super_admin,
            admin, 
            scenario
        }
    }
    
    public fun end(self: World) {
        destroy(self);
    }
}