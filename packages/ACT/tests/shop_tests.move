#[test_only]
module act::genesis_shop_tests {
    use sui::{
        test_utils::{assert_eq, destroy},
        test_scenario::{Self as ts, Scenario},
    };
    use animalib::access_control::{Admin, AccessControl};
    use act::{
        attributes,
        genesis_shop::{Self, GenesisShop}, 
        set_up_tests::set_up_admins
    };

    const OWNER: address = @0xBABE;
    const TOTAL_ITEMS: u64 = 3000;

    #[test]
    fun test_add_primary() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut builder = world.genesis_shop.add_primary(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::primary()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::primary()).length(), TOTAL_ITEMS);

        let mut index = 0;
        
        index = index + 899;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Gunmetal".to_string());
        assert_eq(item.manufacturer(), b"Valenti".to_string());
        assert_eq(item.name(), b"Valenti 12".to_string());

        index = index + 900;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Gunmetal".to_string());
        assert_eq(item.manufacturer(), b"Aegis Tactical".to_string());
        assert_eq(item.name(), b"Raptor".to_string());

        index = index + 900;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Gunmetal".to_string());
        assert_eq(item.manufacturer(), b"Voloslav Industrial".to_string());
        assert_eq(item.name(), b"Renegade".to_string());

        index = index + 300;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Gunmetal".to_string());
        assert_eq(item.manufacturer(), b"Fenrir Arms".to_string());
        assert_eq(item.name(), b"Talon".to_string());

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);
        builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_add_secondary() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut builder = world.genesis_shop.add_secondary(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::secondary()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::secondary()).length(), TOTAL_ITEMS);

        let mut index = 0;

        index = index + 899;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::secondary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Gunmetal".to_string());
        assert_eq(item.manufacturer(), b"Precisione Milano".to_string());
        assert_eq(item.name(), b"Whisper 9mm".to_string());

        index = index + 2100;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::secondary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Gunmetal".to_string());
        assert_eq(item.manufacturer(), b"Liberty Arms Corporation".to_string());
        assert_eq(item.name(), b"Enforcer".to_string());
        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);
        builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_add_tertiary() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut builder = world.genesis_shop.add_tertiary(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::tertiary()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::tertiary()).length(), TOTAL_ITEMS);

        let mut index = 0;

        index = index + 599;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::tertiary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Future".to_string());
        assert_eq(item.manufacturer(), b"ハイパーブレード CORPORATION".to_string());
        assert_eq(item.name(), b"Neo-Katana".to_string());

        index = index + 1200;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::tertiary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"Viceroy".to_string());
        assert_eq(item.manufacturer(), b"Eclipse Steel Forging LTD".to_string());
        assert_eq(item.name(), b"Scalper".to_string());
        
        index = index + 1200;
        let item = world.genesis_shop.borrow_mut().borrow(attributes::tertiary())[index];
        assert_eq(item.rarity(), b"Common".to_string());
        assert_eq(item.colour_way(), b"K1TSUN3".to_string());
        assert_eq(item.manufacturer(), b"Ryujin Industrial".to_string());
        assert_eq(item.name(), b"Wakizashi".to_string());
        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);
        builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_add_helm() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut builder = world.genesis_shop.add_helm(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::helm()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic", b"Ultra Rare"];

        let colour_way = vector[b"Viceroy", b"Dusk", b"Digital Winter", b"Red Damascus", b"Blood Ivory", b"Volt", b"Hikari", b"Vesper"];

        let chances = vector[81, 83, 82, 83, 82, 83, 22, 83];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_baha_2000_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let chances = vector[82, 83, 82, 83, 82, 83, 22, 83];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_helios_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_spectre_09_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_fang_mk_iv_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_sk_viper_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_add_chestpiece() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut builder = world.genesis_shop.add_chestpiece(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::chestpiece()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::chestpiece()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic", b"Ultra Rare"];

        let colour_way = vector[b"Viceroy", b"Dusk", b"Digital Winter", b"Red Damascus", b"Blood Ivory", b"Volt", b"Hikari", b"Vesper"];

        let chances = vector[
            59,
            180,
            180,
            105,
            60, 
            105,
            30,
            180
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::chestpiece())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
            assert_eq(item.name(), b"Neo-Shogunate".to_string());

            i  = i + 1;
        };

        let chances = vector[
            60,
            180,
            180,
            105,
            60, 
            105,
            30,
            180
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::chestpiece())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
            assert_eq(item.name(), b"Helios".to_string());

            i  = i + 1;
        };

        let chances = vector[
            90,
            240,
            240,
            120,
            90,
            120,
            60,
            240
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::chestpiece())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_add_pauldrons() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut left_builder = world.genesis_shop.add_left_pauldron(access_control, admin, world.scenario.ctx());
        let mut right_builder = world.genesis_shop.add_right_pauldron(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut right_builder);
            world.genesis_shop.new_item(&mut left_builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 2);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_pauldron()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron()).length(), TOTAL_ITEMS);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_pauldron()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic", b"Ultra Rare"];

        let colour_way = vector[b"Viceroy", b"Dusk", b"Digital Winter", b"Red Damascus", b"Blood Ivory", b"Volt", b"Hikari", b"Vesper"];

        let chances = vector[
            59,
            180,
            180,
            105,
            60,
            105,
            30,
            180
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
            assert_eq(item.name(), b"Neo-Shogunate".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
            assert_eq(item.name(), b"Neo-Shogunate".to_string());

            i  = i + 1;
        };

        let chances = vector[
            60,
            180,
            180,
            105,
            60,
            105,
            30,
            180
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
            assert_eq(item.name(), b"Helios".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
            assert_eq(item.name(), b"Helios".to_string());

            i  = i + 1;
        };

        let chances = vector[
            90,
            240,
            240,
            120,
            90,
            120,
            60,
            240
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        right_builder.keep(world.scenario.ctx());
        left_builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_add_bracer() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut right_builder = world.genesis_shop.add_left_bracer(access_control, admin, world.scenario.ctx());
        let mut left_builder = world.genesis_shop.add_right_bracer(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut right_builder);
            world.genesis_shop.new_item(&mut left_builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 2);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_bracer()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_bracer()).length(), TOTAL_ITEMS);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_bracer()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_bracer()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic", b"Ultra Rare"];

        let colour_way = vector[b"Viceroy", b"Dusk", b"Digital Winter", b"Red Damascus", b"Blood Ivory", b"Volt", b"Hikari", b"Vesper"];

        let chances = vector[
            59,
            180,
            180,
            105,
            60,
            105,
            30,
            180
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_bracer())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
            assert_eq(item.name(), b"Neo-Shogunate".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_bracer())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
            assert_eq(item.name(), b"Neo-Shogunate".to_string());

            i  = i + 1;
        };

        let chances = vector[
            60,
            180,
            180,
            105,
            60,
            105,
            30,
            180
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_bracer())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
            assert_eq(item.name(), b"Helios".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_bracer())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
            assert_eq(item.name(), b"Helios".to_string());

            i  = i + 1;
        };

        let chances = vector[
            90,
            240,
            240,
            120,
            90,
            120,
            60,
            240
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_bracer())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_bracer())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        right_builder.keep(world.scenario.ctx());
        left_builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_add_legs() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut builder = world.genesis_shop.add_legs(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while ((TOTAL_ITEMS) > i) {
            world.genesis_shop.new_item(&mut builder);
            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::legs()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::legs()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic"];

        let colour_way = vector[b"Digital Winter", b"Dusk", b"Blood Ivory", b"Volt", b"Hikari"];

        let chances = vector[
            359, 
            360,
            360,
            360,
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::legs())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        let chances = vector[
            360,
            360,
            360,
            360,
            120
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::legs())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Helios".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        builder.keep(world.scenario.ctx());
        world.end();
    }

    #[test]
    fun test_gloves() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut right_glove_builder = world.genesis_shop.add_right_glove(access_control, admin, world.scenario.ctx());
        let mut left_glove_builder = world.genesis_shop.add_left_glove(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut right_glove_builder);
            world.genesis_shop.new_item(&mut left_glove_builder);

            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 2);

        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_glove()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_glove()).length(), TOTAL_ITEMS);

        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_glove()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_glove()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare"];

        let colour_way = vector[b"Obsidian"];

        let chances = vector[
            2999
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_glove())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_glove())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);
        right_glove_builder.keep(world.scenario.ctx());
        left_glove_builder.keep(world.scenario.ctx());

        world.end();
    }

    #[test]
    fun test_arms() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut right_arm_builder = world.genesis_shop.add_right_arm(access_control, admin, world.scenario.ctx());
        let mut left_arm_builder = world.genesis_shop.add_left_arm(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut right_arm_builder);
            world.genesis_shop.new_item(&mut left_arm_builder);

            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 2);


        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_arm()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_arm()).length(), TOTAL_ITEMS);

        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_arm()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_arm()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare"];

        let colour_way = vector[b"Obsidian"];

        let chances = vector[
            2999
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_arm())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_arm())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        right_arm_builder.keep(world.scenario.ctx());
        left_arm_builder.keep(world.scenario.ctx());

        world.end();
    }

    #[test]
    fun test_belt_shins() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut belt_builder = world.genesis_shop.add_belt(access_control, admin, world.scenario.ctx());

        let mut shins_builder = world.genesis_shop.add_shins(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut belt_builder);
            world.genesis_shop.new_item(&mut shins_builder);

            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 2);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::shins()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::shins()).length(), TOTAL_ITEMS);

        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::belt()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::belt()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare"];

        let colour_way = vector[b"Obsidian"];

        let chances = vector[
            2999
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::shins())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::belt())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        shins_builder.keep(world.scenario.ctx());
        belt_builder.keep(world.scenario.ctx());

        world.end();
    }

    #[test]
    fun test_upper_torso() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut upper_torso_builder = world.genesis_shop.add_upper_torso(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut upper_torso_builder);

            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);

        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::upper_torso()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::upper_torso()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare"];

        let colour_way = vector[b"Obsidian"];

        let chances = vector[
            2999
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::upper_torso())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        upper_torso_builder.keep(world.scenario.ctx());

        world.end();
    }

    #[test]
    fun test_add_boots() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        let mut boots_builder = world.genesis_shop.add_boots(access_control, admin, world.scenario.ctx());

        let mut i = 0;

        while (TOTAL_ITEMS > i) {
            world.genesis_shop.new_item(&mut boots_builder);

            i = i + 1;
        };

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);

        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::boots()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::boots()).length(), TOTAL_ITEMS);

        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

        let colour_way = vector[b"Dusk", b"Red Damascus", b"Blood Ivory", b"Volt", b"Hikari", b"Vesper"];

        let chances = vector[569, 570, 570, 570, 150, 570];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::boots())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        boots_builder.keep(world.scenario.ctx());

        world.end();
    }

    fun test_baha_2000_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Roots Robotics".to_string());
        assert_eq(item.name(), b"Baha-2000".to_string());
    }

    fun test_helios_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
        assert_eq(item.name(), b"Helios".to_string());
    }

    fun test_spectre_09_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Phalanx Defence Corp".to_string());
        assert_eq(item.name(), b"Spectre-09".to_string());
    }

    fun test_fang_mk_iv_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
        assert_eq(item.name(), b"Fang MK IV".to_string());
    }

    fun test_sk_viper_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
        assert_eq(item.name(), b"SK-Viper".to_string());
    }

    public struct World {
        scenario: Scenario,
        admin: Admin,
        access_control: AccessControl,
        genesis_shop: GenesisShop
    }

    fun start_world(): World {
        let mut scenario = ts::begin(OWNER);

        genesis_shop::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, admin) = set_up_admins(&mut scenario);
        let genesis_shop = scenario.take_shared<GenesisShop>();

        World {
            scenario,
            access_control,
            admin,
            genesis_shop
        }
    }

    fun end(self: World) {
        destroy(self);
    }
}