#[test_only]
module act::genesis_drop_tests {

    use sui::{
        coin::mint_for_testing,
        clock::{Self, Clock},
        test_utils::{assert_eq, destroy},
        kiosk::{Self, Kiosk},
       test_scenario::{Self as ts, receiving_ticket_by_id, Scenario},
    };
    use animalib::access_control::{Admin, AccessControl};
    use kiosk::personal_kiosk::{Self, PersonalKioskCap};
    use act::{
        assets,
        attributes,
        set_up_tests::set_up_admins,
        avatar::{Self, AvatarRegistry, Avatar},
        genesis_drop::{Self, Sale, AvatarTicket},
        genesis_shop::{Self, new_builder_for_testing, GenesisShop}, 
    };

    public struct World {
        scenario: Scenario,
        clock: Clock,
        super_admin: Admin,
        access_control: AccessControl,
        genesis_shop: GenesisShop,
        sale: Sale,
        avatar_registry: AvatarRegistry,
        avatar: Avatar,
        kiosk: Kiosk,
        kiosk_cap: PersonalKioskCap,
    }

    const OWNER: address = @0x0;
    const ALICE: address = @0xa11c3;
    const TOTAL_ITEMS: u64 = 10;
    const FREE_MINT_PHASE: u64 = 0;
    const WHITELIST_PHASE: u64 = 1;

    #[test]
    fun test_init() {
        let world = start_world();

        assert_eq(world.sale.active(), true);
        assert_eq(world.sale.start_times(), vector[]);
        assert_eq(world.sale.prices(), vector[]);
        assert_eq(world.sale.max_mints(), vector[]);
        assert_eq(world.sale.drops_left(), 3000);

        world.end();
    }

    #[test]
    fun test_mint_to_kiosk() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[3, 3, 4]);

        {        // Now we can do the free mint phase - index 0.
            world.clock.set_for_testing(8);

            let sale = &world.sale;
            let avatar_registry = &world.avatar_registry;
            let genesis_pass = vector[
                genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx())
            ];
            let cap = &world.kiosk_cap;
            let quantity = 3;
            let clock = &world.clock;
            let ctx = world.scenario.ctx();
        
            let genesis_shop = &mut world.genesis_shop;
            let kiosk = &mut world.kiosk;

            assert_eq(kiosk.item_count(), 0);
            assert_eq(sale.drops_left(), TOTAL_ITEMS);

            world.sale.mint_to_kiosk(
                genesis_shop, 
                avatar_registry, 
                genesis_pass, 
                kiosk, 
                cap.borrow(), 
                mint_for_testing(10 * quantity, ctx), 
                quantity, 
                clock, 
                ctx
            );

            assert_eq(kiosk.item_count(), 18 * 3);
            assert_eq(world.sale.drops_left(), TOTAL_ITEMS - quantity);
        };

        {
            // === PHASE 1 ===

            world.clock.set_for_testing(15);

            let avatar_registry = &world.avatar_registry;
            let cap = &world.kiosk_cap;
            let quantity = 3;
            let clock = &world.clock;
            let ctx = world.scenario.ctx();
        
            let genesis_shop = &mut world.genesis_shop;
            let kiosk = &mut world.kiosk;

            let genesis_pass = vector[
                genesis_drop::new_genesis_pass(WHITELIST_PHASE, ctx)
            ];

            world.sale.mint_to_kiosk(
                genesis_shop, 
                avatar_registry, 
                genesis_pass, 
                kiosk, 
                cap.borrow(), 
                mint_for_testing(25 * quantity, ctx), 
                quantity, 
                clock, 
                ctx
            );

            assert_eq(kiosk.item_count(), 18 * 6);
            assert_eq(world.sale.drops_left(), TOTAL_ITEMS - 6);
        };

        {
            // === PHASE 2 ===

            world.clock.set_for_testing(21);

            let avatar_registry = &world.avatar_registry;
            let cap = &world.kiosk_cap;
            let quantity = 4;
            let clock = &world.clock;
            let ctx = world.scenario.ctx();
        
            let genesis_shop = &mut world.genesis_shop;
            let kiosk = &mut world.kiosk;

            let genesis_pass = vector[];

            world.sale.mint_to_kiosk(
                genesis_shop, 
                avatar_registry, 
                genesis_pass, 
                kiosk, 
                cap.borrow(), 
                mint_for_testing(50 * quantity, ctx), 
                quantity, 
                clock, 
                ctx
            );

            assert_eq(kiosk.item_count(), 18 * 10);
            assert_eq(world.sale.drops_left(), 0);
        };

        world.end();
    }

    #[test]
    fun test_mint_to_ticket_and_avatar() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[3, 3, 4]);

        world.scenario.next_tx(ALICE);

        {        // Now we can do the free mint phase - index 0.
            world.clock.set_for_testing(8);

            let sale = &world.sale;
            let avatar_registry = &world.avatar_registry;
            let genesis_pass = vector[
                genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx())
            ];
            let clock = &world.clock;
            let ctx = world.scenario.ctx();
        
            let genesis_shop = &mut world.genesis_shop;

            assert_eq(sale.drops_left(), TOTAL_ITEMS);

            world.sale.mint_to_ticket(
                genesis_shop, 
                avatar_registry, 
                genesis_pass, 
                mint_for_testing(10, ctx), 
                clock, 
                ctx
            );

            assert_eq(world.sale.drops_left(), TOTAL_ITEMS - 1);
        };

        world.scenario.next_tx(ALICE);

        let mut avatar_ticket = world.scenario.take_from_sender<AvatarTicket>();

        assert_eq(avatar_ticket.drop().length(), 18);

        let access_control = &world.access_control;
        let admin = &world.super_admin;

        avatar::new_avatar_image(
            access_control, 
            admin, 
            b"image2".to_string(), 
            b"hash2".to_string(),
            object::id(&avatar_ticket).to_address(),
            world.scenario.ctx()
        );

        let effects = world.scenario.next_tx(ALICE);

        avatar_ticket.update_image(receiving_ticket_by_id(effects.created()[0]));

        {
            let clock = &world.clock;
            let avatar_registry = &mut world.avatar_registry;

            avatar_ticket.mint_to_avatar(avatar_registry, clock, world.scenario.ctx());

        };

        world.scenario.next_tx(ALICE);

        let avatar = world.scenario.take_from_sender<Avatar>();

        // all avatar attr values are filled so equipped all items
        assert_eq(attributes::genesis_mint_types().all!(|k| avatar.attributes()[k] != b"".to_string()), true);
        assert_eq(avatar.image_url(), b"image2".to_string());
        assert_eq(avatar.equipped_cosmetics_hash(), b"hash2".to_string());

        assert_eq(world.sale.drops_left(), TOTAL_ITEMS - 1);
        destroy(avatar);    
        world.end();
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::EPublicNotOpen)] 
    fun test_assert_can_mint_error_public_not_open() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[3, 3, 4]);

        {   // Now we can do the free mint phase - index 0. 
            // We do not have a pass.  
            world.clock.set_for_testing(8);

            let avatar_registry = &world.avatar_registry;
            let genesis_pass = vector[];
            let cap = &world.kiosk_cap;
            let quantity = 3;
            let clock = &world.clock;
            let ctx = world.scenario.ctx();
        
            let genesis_shop = &mut world.genesis_shop;
            let kiosk = &mut world.kiosk;

            world.sale.mint_to_kiosk(
                genesis_shop, 
                avatar_registry, 
                genesis_pass, 
                kiosk, 
                cap.borrow(), 
                mint_for_testing(10 * quantity, ctx), 
                quantity, 
                clock, 
                ctx
            );
        };        

        world.end(); 
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::EWrongPass)] 
    fun test_assert_can_mint_error_wrong_pass() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[3, 3, 4]);

        {   // Free mint phase 
            world.clock.set_for_testing(8);

            let avatar_registry = &world.avatar_registry;
            let genesis_pass = vector[
                genesis_drop::new_genesis_pass(WHITELIST_PHASE, world.scenario.ctx())
            ];
            let cap = &world.kiosk_cap;
            let quantity = 3;
            let clock = &world.clock;
            let ctx = world.scenario.ctx();
        
            let genesis_shop = &mut world.genesis_shop;
            let kiosk = &mut world.kiosk;

            world.sale.mint_to_kiosk(
                genesis_shop, 
                avatar_registry, 
                genesis_pass, 
                kiosk, 
                cap.borrow(), 
                mint_for_testing(10 * quantity, ctx), 
                quantity, 
                clock, 
                ctx
            );
        };        

        world.end(); 
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::EInvalidTicket)] 
    fun test_mint_to_avatar_error_invalid_ticket() {
        let mut world = start_world();

        let clock = &world.clock;
        let avatar_registry = &mut world.avatar_registry;

        let avatar_ticket = genesis_drop::new_empty_avatar_ticket(world.scenario.ctx());

        avatar_ticket.mint_to_avatar(avatar_registry, clock, world.scenario.ctx());    

        world.end(); 
    }    

    #[test]
    #[expected_failure(abort_code = genesis_drop::ESaleNotActive)] 
    fun test_assert_can_mint_error_sale_not_active_too_early() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[3, 3, 4]);

        // starts at 8
        world.clock.set_for_testing(7);

        let avatar_registry = &world.avatar_registry;
        let genesis_pass = vector[
            genesis_drop::new_genesis_pass(WHITELIST_PHASE, world.scenario.ctx())
        ];
        let cap = &world.kiosk_cap;
        let quantity = 3;
        let clock = &world.clock;
        let ctx = world.scenario.ctx();
        
        let genesis_shop = &mut world.genesis_shop;
        let kiosk = &mut world.kiosk;

        world.sale.mint_to_kiosk(
            genesis_shop, 
            avatar_registry, 
            genesis_pass, 
            kiosk, 
            cap.borrow(), 
            mint_for_testing(10 * quantity, ctx), 
            quantity, 
            clock, 
            ctx
        );      

        world.end(); 
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::ESaleNotActive)] 
    fun test_assert_can_mint_error_sale_not_active_sale_inactive() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[3, 3, 4]);
        world.sale.set_active(access_control, admin_cap, false);

        // starts at 8
        world.clock.set_for_testing(8);

        let avatar_registry = &world.avatar_registry;
        let genesis_pass = vector[
            genesis_drop::new_genesis_pass(WHITELIST_PHASE, world.scenario.ctx())
        ];
        let cap = &world.kiosk_cap;
        let quantity = 3;
        let clock = &world.clock;
        let ctx = world.scenario.ctx();
        
        let genesis_shop = &mut world.genesis_shop;
        let kiosk = &mut world.kiosk;

        world.sale.mint_to_kiosk(
            genesis_shop, 
            avatar_registry, 
            genesis_pass, 
            kiosk, 
            cap.borrow(), 
            mint_for_testing(10 * quantity, ctx), 
            quantity, 
            clock, 
            ctx
        );      

        world.end(); 
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::EWrongCoinValue)] 
    fun test_assert_can_mint_error_wrong_coin_value() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[3, 3, 4]);

        // starts at 8
        world.clock.set_for_testing(8);

        let avatar_registry = &world.avatar_registry;
        let genesis_pass = vector[
            genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx())
        ];
        let cap = &world.kiosk_cap;
        let quantity = 3;
        let clock = &world.clock;
        let ctx = world.scenario.ctx();
        
        let genesis_shop = &mut world.genesis_shop;
        let kiosk = &mut world.kiosk;

        world.sale.mint_to_kiosk(
            genesis_shop, 
            avatar_registry, 
            genesis_pass, 
            kiosk, 
            cap.borrow(), 
            mint_for_testing((10 * quantity) - 1, ctx), 
            quantity, 
            clock, 
            ctx
        );      

        world.end(); 
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::ETooManyMints)] 
    fun test_assert_can_mint_error_too_many_mints() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[2, 3, 4]);

        // starts at 8
        world.clock.set_for_testing(8);

        let avatar_registry = &world.avatar_registry;
        let genesis_pass = vector[
            genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx())
        ];
        let cap = &world.kiosk_cap;
        let quantity = 3;
        let clock = &world.clock;
        let ctx = world.scenario.ctx();
        
        let genesis_shop = &mut world.genesis_shop;
        let kiosk = &mut world.kiosk;

        world.sale.mint_to_kiosk(
            genesis_shop, 
            avatar_registry, 
            genesis_pass, 
            kiosk, 
            cap.borrow(), 
            mint_for_testing(10 * quantity, ctx), 
            quantity, 
            clock, 
            ctx
        );      

        world.end(); 
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::EInvalidPass)] 
    fun test_assert_can_mint_error_invalid_pass() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[2, 3, 4]);

        // starts at 8
        world.clock.set_for_testing(8);

        let avatar_registry = &world.avatar_registry;
        let genesis_pass = vector[
            genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx()),
            genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx())
        ];
        let cap = &world.kiosk_cap;
        let quantity = 3;
        let clock = &world.clock;
        let ctx = world.scenario.ctx();
        
        let genesis_shop = &mut world.genesis_shop;
        let kiosk = &mut world.kiosk;

        world.sale.mint_to_kiosk(
            genesis_shop, 
            avatar_registry, 
            genesis_pass, 
            kiosk, 
            cap.borrow(), 
            mint_for_testing(10 * quantity, ctx), 
            quantity, 
            clock, 
            ctx
        );      

        world.end(); 
    }

    #[test]
    #[expected_failure(abort_code = genesis_drop::ENoMoreDrops)] 
    fun test_assert_can_mint_error_no_more_drops() {
        let mut world = start_world();

        world.add_genesis_shop();

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_prices(access_control, admin_cap, vector[10, 25, 50]);
        world.sale.set_start_times(access_control, admin_cap, vector[7, 14, 20]);
        world.sale.set_max_mints(access_control, admin_cap, vector[11, 3, 4]);

        // starts at 8
        world.clock.set_for_testing(8);

        let avatar_registry = &world.avatar_registry;
        let genesis_pass = vector[
            genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx()),
            genesis_drop::new_genesis_pass(FREE_MINT_PHASE, world.scenario.ctx())
        ];
        let cap = &world.kiosk_cap;
        let quantity = 11;
        let clock = &world.clock;
        let ctx = world.scenario.ctx();
        
        let genesis_shop = &mut world.genesis_shop;
        let kiosk = &mut world.kiosk;

        world.sale.mint_to_kiosk(
            genesis_shop, 
            avatar_registry, 
            genesis_pass, 
            kiosk, 
            cap.borrow(), 
            mint_for_testing(11 * quantity, ctx), 
            quantity, 
            clock, 
            ctx
        );      

        world.end(); 
    }

    fun add_genesis_shop(world: &mut World) {

        let admin_cap = &world.super_admin;
        let access_control = &world.access_control;

        world.sale.set_drops_left(access_control, admin_cap, TOTAL_ITEMS);

        let mut primary = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::primary_bytes(),
            assets::primary_names(), 
            assets::primary_colour_ways(), // same
            assets::primary_manufacturers(), 
            assets::primary_rarities(),
            assets::primary_chances(), 
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );
        let mut secondary = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::secondary_bytes(),
            assets::secondary_names(), 
            assets::secondary_colour_ways(),
            assets::secondary_manufacturers(), 
            assets::secondary_rarities(),
            assets::secondary_chances(), 
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut tertiary = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::tertiary_bytes(),
            assets::tertiary_names(), 
            assets::tertiary_colour_ways(),
            assets::tertiary_manufacturers(), 
            assets::tertiary_rarities(),
            assets::tertiary_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut helm = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::helm_bytes(),
            assets::helm_names(), 
            assets::cosmetic_colour_ways(),
            assets::helm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::helm_chances(), 
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut chestpiece = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::chestpiece_bytes(),
            assets::chestpiece_names(), 
            assets::cosmetic_colour_ways(),
            assets::chestpiece_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::chestpiece_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut left_pauldron = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::left_pauldron_bytes(),
            assets::pauldrons_names(), 
            assets::cosmetic_colour_ways(),
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut right_pauldron = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::right_pauldron_bytes(),
            assets::pauldrons_names(), 
            assets::cosmetic_colour_ways(),
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut left_bracer = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::left_bracer_bytes(),
            assets::bracer_names(), 
            assets::cosmetic_colour_ways(),
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut right_bracer = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::right_bracer_bytes(),
            assets::bracer_names(), 
            assets::cosmetic_colour_ways(),
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut legs = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::legs_bytes(),
            assets::legs_names(), 
            assets::legs_colour_ways(),
            assets::legs_manufacturers(), 
            assets::leg_rarities(),
            assets::legs_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut right_glove = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::right_glove_bytes(),
            assets::glove_names(), 
            vector[b"Obsidian"],
            assets::glove_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::glove_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut left_glove = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::left_glove_bytes(),
            assets::glove_names(), 
            vector[b"Obsidian"],
            assets::glove_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::glove_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut right_arm = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::right_arm_bytes(),
            assets::arm_names(), 
            vector[b"Obsidian"],
            assets::arm_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::arm_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut left_arm = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::left_arm_bytes(),
            assets::arm_names(), 
            vector[b"Obsidian"],
            assets::arm_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::arm_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut belt = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::belt_bytes(),
            assets::belt_names(), 
            vector[b"Obsidian"],
            assets::belt_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::belt_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut shins = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::shins_bytes(),
            assets::shins_names(), 
            vector[b"Obsidian"],
            assets::shins_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::shins_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut upper_torso = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::upper_torso_bytes(),
            assets::upper_torso_names(), 
            vector[b"Obsidian"],
            assets::upper_torso_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::upper_torso_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut boots = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::boots_bytes(),
            assets::boots_names(), 
            assets::boots_colour_ways(),
            assets::boots_manufacturers(), 
            assets::boots_rarities(),
            assets::boots_chances(),
            TOTAL_ITEMS,
            world.scenario.ctx()            
        );

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut primary);
            world.genesis_shop.new_item(&mut secondary);
            world.genesis_shop.new_item(&mut tertiary);
            world.genesis_shop.new_item(&mut helm);
            world.genesis_shop.new_item(&mut chestpiece);
            world.genesis_shop.new_item(&mut left_pauldron);
            world.genesis_shop.new_item(&mut right_pauldron);
            world.genesis_shop.new_item(&mut left_bracer);
            world.genesis_shop.new_item(&mut right_bracer);
            world.genesis_shop.new_item(&mut right_glove);
            world.genesis_shop.new_item(&mut left_glove);
            world.genesis_shop.new_item(&mut right_arm);
            world.genesis_shop.new_item(&mut right_glove);
            world.genesis_shop.new_item(&mut left_arm);            
            world.genesis_shop.new_item(&mut belt);
            world.genesis_shop.new_item(&mut shins); 
            world.genesis_shop.new_item(&mut upper_torso);
            world.genesis_shop.new_item(&mut legs);   
            world.genesis_shop.new_item(&mut boots);

            i = i + 1;
        };

        world.genesis_shop.new_item(&mut legs); 

        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::boots()).length(), 10);

        destroy(primary);
        destroy(secondary);
        destroy(tertiary);
        destroy(helm);
        destroy(chestpiece);
        destroy(left_pauldron);
        destroy(right_pauldron);
        destroy(left_bracer);
        destroy(right_bracer);
        destroy(left_glove);
        destroy(right_glove);
        destroy(legs);
        destroy(left_arm);
        destroy(right_arm);
        destroy(belt);
        destroy(shins);
        destroy(upper_torso);
        destroy(boots);
    }
 
    fun start_world(): World {
        let mut scenario = ts::begin(OWNER);

        avatar::init_for_testing(scenario.ctx());
        genesis_shop::init_for_testing(scenario.ctx());
        genesis_drop::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, super_admin) = set_up_admins(&mut scenario);
        let genesis_shop = scenario.take_shared<GenesisShop>();
        let sale = scenario.take_shared<Sale>();
        let mut avatar_registry = scenario.take_shared<AvatarRegistry>();
        let clock = clock::create_for_testing(scenario.ctx());

        let avatar = avatar::new_with_image(
            &mut avatar_registry, 
            b"image_url".to_string(),
            b"".to_string(),
            scenario.ctx()
        );

        let (mut kiosk, kiosk_cap) = kiosk::new(scenario.ctx());

        let kiosk_cap = personal_kiosk::new(&mut kiosk, kiosk_cap, scenario.ctx());

        World {
            sale,
            kiosk,
            kiosk_cap,
            scenario,
            access_control,
            super_admin,
            genesis_shop,
            avatar_registry,
            clock,
            avatar
        }
    }

    fun end(self: World) {
        destroy(self);
    }
}