#[test_only]
module anima::account_tests {
    
    use sui::{
        clock::{Self, Clock},
        test_utils::{assert_eq, destroy},
        test_scenario::{Self as ts, Scenario, receiving_ticket_by_id}
    };

    use anima::{
        admin,
        account::{Self, Registry, Reputation},
        access_control::{Admin, AccessControl},
    };

    const OWNER: address = @0xBABE;
    const ALICE: address = @0xA11c3;

    // === Set Up ===

    #[test]
    fun test_new_and_account_setters() {
        let mut world = start();

        assert_eq(world.registry.accounts().length(), 0);
        world.registry.assert_no_avatar(OWNER);

        let c = &mut world.clock;

        c.increment_for_testing(123);

        let alias = b"jose".to_string();
        let username = b"Griffith".to_string();


        let mut account = world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        assert_eq(account.alias(), alias);
        assert_eq(account.username(), username);
        assert_eq(account.creation_date(), 123);
        assert_eq(account.accolades().length(), 0);
        assert_eq(world.registry.accounts().length(), 1);
        assert_eq(*world.registry.accounts().borrow(OWNER), object::id(&account));

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

        let owner_account = world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(ALICE);

        let alias = b"alice".to_string();
        let username = b"Super".to_string();

        let mut alice_account = world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        let alice_account_addr = object::id(&alice_account).to_address();

        owner_account.give_reputation(
            alice_account_addr, 
            b"behaviour".to_string(), 
            100, 
            true, 
            b"He was nice to all players".to_string(), 
            b"https://sui.io/".to_string(), 
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        let reputation = world.scenario.take_from_address<Reputation>(alice_account_addr);

        assert_eq(reputation.type_(), b"behaviour".to_string());
        assert_eq(reputation.value(), 100);
        assert_eq(reputation.positive(), true);
        assert_eq(reputation.description(), b"He was nice to all players".to_string());
        assert_eq(reputation.url(), b"https://sui.io/".to_string());
        assert_eq(reputation.issuer(), object::id(&owner_account));

        let reputation_id = object::id(&reputation);

        ts::return_to_address(alice_account_addr, reputation);

        world.scenario.next_tx(OWNER);

        alice_account.remove_reputation(
            receiving_ticket_by_id(reputation_id), 
            &world.access_control, 
            &world.admin
        );

        let effects = world.scenario.next_tx(OWNER);

        // was deleted
        assert_eq(effects.deleted().contains(&reputation_id), true);

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

        let mut alice_account = world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        assert_eq(alice_account.accolades().length(), 0);

        alice_account.add_accolade(
            &world.access_control, 
            &world.admin, 
            b"Kills".to_string(), 
            b"100 kills in 5 minutes".to_string(),  
            b"accolades.png".to_string(), 
        );

        assert_eq(alice_account.accolades().length(), 1);

        let accolades = &alice_account.accolades()[0];

        assert_eq(accolades.type_(), b"Kills".to_string());
        assert_eq(accolades.description(), b"100 kills in 5 minutes".to_string());
        assert_eq(accolades.url(), b"accolades.png".to_string());
        
        world.scenario.next_tx(OWNER);

        alice_account.remove_accolade(&world.access_control, &world.admin, 0);

        assert_eq(alice_account.accolades().length(), 0);

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

        world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        ).keep(world.scenario.ctx());

        world.registry.new(
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

        let owner_account = world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(ALICE);

        let alias = b"alice".to_string();
        let username = b"Super".to_string();

        let mut alice_account = world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        let alice_account_addr = object::id(&alice_account).to_address();

        owner_account.give_reputation(
            alice_account_addr, 
            b"behaviour".to_string(), 
            100, 
            true, 
            b"He was nice to all players".to_string(), 
            b"https://sui.io/".to_string(), 
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        let reputation = world.scenario.take_from_address<Reputation>(alice_account_addr);

        let reputation_id = object::id(&reputation);

        ts::return_to_address(alice_account_addr, reputation);

        world.scenario.next_tx(OWNER);

        alice_account.remove_reputation(
            receiving_ticket_by_id(reputation_id), 
            &world.access_control, 
            // does not have the role
            &world.super_admin
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

        let mut alice_account = world.registry.new(
            alias,
            username,
            c,
            world.scenario.ctx()
        );

        world.scenario.next_tx(OWNER);

        assert_eq(alice_account.accolades().length(), 0);

        alice_account.add_accolade(
            &world.access_control, 
            // Does not have the roles
            &world.super_admin, 
            b"Kills".to_string(), 
            b"100 kills in 5 minutes".to_string(),  
            b"accolades.png".to_string(), 
        );

        destroy(alice_account);
        world.end();
    }

    public struct World {
        admin: Admin,
        super_admin: Admin,
        access_control: AccessControl,
        scenario: Scenario,
        registry: Registry,
        clock: Clock
    }


    fun start(): World {
        let mut scenario = ts::begin(OWNER);

        admin::init_for_testing(scenario.ctx());
        account::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let access_control = scenario.take_shared<AccessControl>();
        let super_admin = scenario.take_from_sender<Admin>();
        let admin = scenario.take_from_sender<Admin>();
        let registry = scenario.take_shared<Registry>();
        let clock = clock::create_for_testing(scenario.ctx());

        World {
            access_control,
            super_admin,
            admin, 
            scenario,
            registry,
            clock
        }
    }
    
    fun end(self: World) {
        destroy(self);
    }
}