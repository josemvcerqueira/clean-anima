#[test_only]
module anima::account_tests {
    
    use sui::{
        clock::{Self, Clock},
        test_utils::{assert_eq, destroy},
        test_scenario::{Self as ts, Scenario}
    };
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };
    use anima::{
        account::{Self, System},
    };

    const OWNER: address = @0xBABE;
    const ALICE: address = @0xA11c3;

    // === Set Up ===

    #[test]
    fun test_new_and_account_setters() {
        let mut world = start();

        assert_eq(world.system.accounts().length(), 0);
        world.system.assert_no_avatar(OWNER);

        let c = &mut world.clock;

        c.increment_for_testing(123);

        let alias = b"jose".to_string();
        let username = b"Griffith".to_string();


        let mut account = world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        assert_eq(account.alias(), alias);
        assert_eq(account.username(), username);
        assert_eq(account.creation_date(), 123);
        assert_eq(world.system.accounts().length(), 1);
        assert_eq(*world.system.accounts().borrow(OWNER), object::id(&account).to_address());

        account.update_username(b"Blockrunner".to_string());
        account.update_alias(b"Thouny".to_string());

        assert_eq(account.alias(), b"Thouny".to_string());
        assert_eq(account.username(), b"Blockrunner".to_string());

        account.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_reputation_logic() {
        let mut world = start();

        let c = &world.clock;

        let alias = b"jose".to_string();
        let username = b"Griffith".to_string();

        let owner_account = world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(ALICE);

        let alias = b"alice".to_string();
        let username = b"Super".to_string();

        let alice_account = world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        let alice_account_addr = object::id(&alice_account).to_address();

        world.system.give_reputation(
            &owner_account,
            alice_account_addr, 
            b"behaviour".to_string(), 
            100, 
            true, 
            b"He was nice to all players".to_string(), 
            b"https://sui.io/".to_string(), 
            world.scenario.ctx()
        );

        let reputation = world.system.reputation().borrow(alice_account_addr).borrow(0);

        assert_eq(reputation.type_(), b"behaviour".to_string());
        assert_eq(reputation.value(), 100);
        assert_eq(reputation.positive(), true);
        assert_eq(reputation.description(), b"He was nice to all players".to_string());
        assert_eq(reputation.url(), b"https://sui.io/".to_string());
        assert_eq(reputation.issuer(), object::id(&owner_account).to_address());

        world.scenario.next_tx(OWNER);

        let access_control = &world.access_control;
        let admin = &world.admin;

        world.system.remove_reputation(
            access_control, 
            admin,
            alice_account_addr,
            0
        );

        assert_eq(world.system.reputation().borrow(alice_account_addr).length(), 0);

        destroy(alice_account);
        destroy(owner_account);
        world.end();
    }

    #[test]
    fun test_accolades_logic() {
        let mut world = start();

        let c = &world.clock;

        world.scenario.next_tx(ALICE);

        let alias = b"alice".to_string();
        let username = b"Super".to_string();

        let alice_account = world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        let alice_account_address = object::id(&alice_account).to_address();

        assert_eq(world.system.accolades().contains(alice_account_address), false);

        let access_control = &world.access_control;
        let admin = &world.admin;

        world.system.add_accolade(
            access_control, 
            admin, 
            object::id(&alice_account).to_address(),
            b"Kills".to_string(), 
            b"100 kills in 5 minutes".to_string(),  
            b"accolades.png".to_string(), 
            world.scenario.ctx()
        );

        assert_eq(world.system.accolades().contains(alice_account_address), true);
        assert_eq(world.system.accolades().borrow(alice_account_address).length(), 1);

        let accolades = world.system.accolades().borrow(alice_account_address).borrow(0);

        assert_eq(accolades.type_(), b"Kills".to_string());
        assert_eq(accolades.description(), b"100 kills in 5 minutes".to_string());
        assert_eq(accolades.url(), b"accolades.png".to_string());
        
        world.scenario.next_tx(OWNER);

        let access_control = &world.access_control;
        let admin = &world.admin;

        world.system.remove_accolade(access_control, admin, alice_account_address, 0);

        assert_eq(world.system.accolades().borrow(alice_account_address).length(), 0);

        destroy(alice_account);
        world.end();
    }

    #[test]
    #[expected_failure(abort_code = account::EAlreadyMintedAnAccount)]
    fun test_one_account_per_sender() {
        let mut world = start();

        let c = &world.clock;

        world.scenario.next_tx(ALICE);

        let alias = b"alice".to_string();
        let username = b"Super".to_string();

        world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        ).keep(world.scenario.ctx());

        world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        ).keep(world.scenario.ctx());

        world.end();
    }

    #[test]
    #[expected_failure(abort_code = admin::EInvalidRole)]
    fun test_remove_reputation_admin_role_error() {
        let mut world = start();

        let c = &world.clock;

        let alias = b"jose".to_string();
        let username = b"Griffith".to_string();

        let owner_account = world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(ALICE);

        let alias = b"alice".to_string();
        let username = b"Super".to_string();

        let alice_account = world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        let alice_account_addr = object::id(&alice_account).to_address();

        world.system.give_reputation(
            &owner_account,
            alice_account_addr, 
            b"behaviour".to_string(), 
            100, 
            true, 
            b"He was nice to all players".to_string(), 
            b"https://sui.io/".to_string(), 
            world.scenario.ctx()
        );

        let access_control = &world.access_control;
        let admin = &world.super_admin;

        world.system.remove_reputation(
            access_control, 
            // does not have the role
            admin,
            alice_account_addr,
            0
        );

        destroy(alice_account);
        destroy(owner_account);
        world.end();
    }

    #[test]
    #[expected_failure(abort_code = admin::EInvalidRole)]
    fun test_error_add_accolades_admin_role() {
        let mut world = start();

        let c = &world.clock;

        world.scenario.next_tx(ALICE);

        let alias = b"alice".to_string();
        let username = b"Super".to_string();

        let alice_account = world.system.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);


        let access_control = &world.access_control;
        let admin = &world.admin;

        world.system.add_accolade(
            access_control, 
            admin, 
            object::id(&alice_account).to_address(),
            b"Kills".to_string(), 
            b"100 kills in 5 minutes".to_string(),  
            b"accolades.png".to_string(), 
            world.scenario.ctx()
        );

        let alice_account_address = object::id(&alice_account).to_address();
        
        world.scenario.next_tx(OWNER);

        let access_control = &world.access_control;
        let admin = &world.super_admin;

        world.system.remove_accolade(access_control, admin, alice_account_address, 0);

        destroy(alice_account);
        world.end();
    }

    public struct World {
        admin: Admin,
        super_admin: Admin,
        access_control: AccessControl,
        scenario: Scenario,
        system: System,
        clock: Clock
    }


    fun start(): World {
        let mut scenario = ts::begin(OWNER);

        admin::init_for_testing(scenario.ctx());
        account::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let access_control = scenario.take_shared<AccessControl>();
        let admin = scenario.take_from_sender<Admin>();
        let super_admin = scenario.take_from_sender<Admin>();
        let system = scenario.take_shared<System>();
        let clock = clock::create_for_testing(scenario.ctx());

        World {
            access_control,
            super_admin,
            admin, 
            scenario,
            system,
            clock
        }
    }
    
    fun end(self: World) {
        destroy(self);
    }
}