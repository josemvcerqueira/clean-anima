module anima::admin_tests {
    
    use sui::{
        test_utils::{assert_eq, destroy},
        test_scenario::{Self as ts, Scenario}
    };

    use anima::{
        admin,
        access_control::{Admin, AccessControl},
    };

    const OWNER: address = @0xBABE;
    const ACCOLADES_ROLE: vector<u8> = b"ACCOLADES_ROLE";
    const REPUTATION_ROLE: vector<u8> = b"REPUTATION_ROLE";

    #[test]
    fun test_init() {
        let world = start();

        assert_eq(world.super_admin.has_role(&world.access_control, ACCOLADES_ROLE), false);
        assert_eq(world.super_admin.has_role(&world.access_control, REPUTATION_ROLE), false);

        admin::assert_accolades_role(&world.access_control, &world.admin);
        admin::assert_reputation_role(&world.access_control, &world.admin);

        world.end();
    }

    #[test]
    #[expected_failure(abort_code = admin::EInvalidRole)]
    fun test_error_assert_accolades_role() {
        let world = start();

        admin::assert_accolades_role(&world.access_control, &world.super_admin);

        world.end();
    }

    #[test]
    #[expected_failure(abort_code = admin::EInvalidRole)]
    fun test_error_assert_reputation_role() {
        let world = start();

        admin::assert_reputation_role(&world.access_control, &world.super_admin);

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