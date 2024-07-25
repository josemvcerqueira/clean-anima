#[test_only]
module act::genesis_shop_tests {
    use std::debug::print;
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
    const TOTAL_ITEMS: u64 = 6_000;

    // #[test]
    // fun test_add_primary() {
    //     let mut world = start_world();

    //     let admin = &world.super_admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     let mut primary_builder = world.genesis_shop.add_primary(access_control, admin, world.scenario.ctx());

    //     let mut i = 0;

    //     while (TOTAL_ITEMS > i) {
    //         world.genesis_shop.new_item(&mut primary_builder);
    //         i = i + 1;
    //     };

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::primary()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::primary()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         218,  
    //         156, 
    //         219,
    //         156,
    //         219,
    //         219,
    //         219,
    //         156,
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Fenrir Arms".to_string());
    //         assert_eq(item.name(), b"Talon".to_string());

    //         i  = i + 1;
    //     };

    //     let chances = vector[
    //         185,
    //         132,
    //         185,
    //         132,
    //         185,
    //         185,
    //         185,
    //         132,
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Voloslav Industrial".to_string());
    //         assert_eq(item.name(), b"Renegade".to_string());

    //         i  = i + 1;
    //     };

    //     let chances = vector[
    //         218,  
    //         156, 
    //         218,
    //         156,
    //         218,
    //         218,
    //         218,
    //         156,
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Aegis Tactical".to_string());
    //         assert_eq(item.name(), b"Raptor".to_string());

    //         i  = i + 1;
    //     };

    //     let chances = vector[
    //         218,  
    //         156, 
    //         218,
    //         156,
    //         218,
    //         218,
    //         218,
    //         156,
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::primary())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Valenti".to_string());
    //         assert_eq(item.name(), b"Valenti 12".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);
    //     primary_builder.keep(world.scenario.ctx());
    //     world.end();
    // }

    // #[test]
    // fun test_add_secondary() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_secondary(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::secondary()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::secondary()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"JK's"];

    //     let chances = vector[
    //         299,  
    //         300,
    //         300,
    //         240,
    //         300,
    //         300,
    //         300,
    //         120
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::secondary())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Liberty Arms Corporation".to_string());
    //         assert_eq(item.name(), b"Enforcer".to_string());

    //         i  = i + 1;
    //     };

    //     let chances = vector[
    //         480,
    //         480,
    //         480,
    //         480,
    //         480,
    //         480,
    //         480,
    //         480
    //     ];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::secondary())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Precisione Milano".to_string());
    //         assert_eq(item.name(), b"Whisper 9mm".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_tertiary() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_tertiary(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::tertiary()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::tertiary()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Mythic"];

    //     let colour_way = vector[b"K1TSUN3", b"Volt", b"Viceroy", b"Future"];

    //     let chances = vector[
    //         1499,
    //         1500,
    //         2400,
    //         600
    //     ];

    //     let names = vector[b"Wakizashi", b"Karambit", b"Scalper", b"Neo-Katana"];

    //     let manufacturers = vector[b"Ryujin Industrial", b"Kage Blade Foundry", b"Eclipse Steel Forging LTD", b"\xe3\x83\x8f\xe3\x82\xa4\xe3\x83\x91\xe3\x83\xbc\xe3\x83\x96\xe3\x83\xac\xe3\x83\xbc\xe3\x83\x89 CORPORATION"];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::tertiary())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), manufacturers[i].to_string());
    //         assert_eq(item.name(), names[i].to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    #[test]
    fun test_add_helm() {
        let mut world = start_world();

        let admin = &world.super_admin;
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

        let chances = vector[
            164,
            165,
            165,
            165,
            165,
            165,
            45,
            165,
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_baha_2000_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let chances = vector[
            165,
            165,
            165,
            165,
            165,
            165,
            45,
            165,
        ];

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

    // #[test]
    // fun test_add_chestpiece() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_chestpiece(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::chestpiece()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::chestpiece()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         479, // 8%
    //         120,  // 2%
    //         240,  // 4%
    //         180,  // 3%
    //         240,  // 4%
    //         480, // 8%
    //         480, // 8%
    //         180,  // 3%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         test_gang_mk_iv_chestpieces(&mut world, index, rarity[i], colour_way[i]);

    //         i  = i + 1;
    //     };

    //     let chances = vector[
    //         360, // 6%
    //         60,  // 1%
    //         210, // 3.5%
    //         120,  // 2%
    //         210, // 3.5%
    //         360, // 6%
    //         360, // 6%
    //         120,  // 2%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         test_helios_chestpieces(&mut world, index, rarity[i], colour_way[i]);

    //         i  = i + 1;
    //     };

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         test_neo_shogunate_chestpieces(&mut world, index, rarity[i], colour_way[i]);

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_upper_torso() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_upper_torso(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::upper_torso()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::upper_torso()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         1199, // 20%
    //         300,  // 5%
    //         570,  // 9.5
    //         480,  // 8%
    //         570,  // 9.5
    //         1200, // 20%
    //         1200, // 20%
    //         480,  // 8%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::upper_torso())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_pauldrons() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_left_pauldron(access_control, admin, world.scenario.ctx());
    //     world.genesis_shop.add_right_pauldron(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 2);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_pauldron()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron()).length(), TOTAL_ITEMS);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_pauldron()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         479,  // 8%
    //         120, // 2%
    //         240, //4%
    //         180, // 3% 
    //         240, //4%
    //         480,  // 8%
    //         480,  // 8%
    //         180, // 3% 
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     let chances = vector[
    //         360, // 6% 
    //         60, // 1%,
    //         210, // 3.5 
    //         120, // 2% 
    //         210, // 3.5 
    //         360, // 6% 
    //         360, // 6% 
    //         120, // 2% 
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
    //         assert_eq(item.name(), b"Helios".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
    //         assert_eq(item.name(), b"Helios".to_string());

    //         i  = i + 1;
    //     };

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
    //         assert_eq(item.name(), b"Neo-Shogunate".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
    //         assert_eq(item.name(), b"Neo-Shogunate".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_arms() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_left_arm(access_control, admin, world.scenario.ctx());
    //     world.genesis_shop.add_right_arm(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 2);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_arm()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_arm()).length(), TOTAL_ITEMS);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_arm()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_arm()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         1199,  // 20%
    //         300, // 5%
    //         570, // 9.5%
    //         480, // 8% 
    //         570, // 9.5%
    //         1200,  // 20%
    //         1200,  // 20%
    //         480, // 8%  
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_arm())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_arm())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_gloves() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_left_glove(access_control, admin, world.scenario.ctx());
    //     world.genesis_shop.add_right_glove(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 2);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_glove()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_glove()).length(), TOTAL_ITEMS);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_glove()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_glove()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         1199,  // 20%
    //         300, // 5%
    //         570, // 9.5%
    //         480, // 8% 
    //         570, // 9.5%
    //         1200,  // 20%
    //         1200,  // 20%
    //         480, // 8%  
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_glove())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_glove())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_bracer() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_left_bracer(access_control, admin, world.scenario.ctx());
    //     world.genesis_shop.add_right_bracer(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 2);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_bracer()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_bracer()).length(), TOTAL_ITEMS);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_bracer()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_bracer()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         479, // 8% 
    //         120, // 2%
    //         240, // 4%
    //         180, // 3%
    //         240, // 4%
    //         480, // 8% 
    //         480, // 8% 
    //         180, // 3%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_bracer())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_bracer())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     let chances = vector[
    //         360, // 6% 
    //         60, // 1% 
    //         210, // 3.5% 
    //         120, // 2%
    //         210, // 3.5% 
    //         360, // 6% 
    //         360, // 6% 
    //         120, // 2%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_bracer())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
    //         assert_eq(item.name(), b"Helios".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_bracer())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
    //         assert_eq(item.name(), b"Helios".to_string());

    //         i  = i + 1;
    //     };

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::left_bracer())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
    //         assert_eq(item.name(), b"Neo-Shogunate".to_string());

    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::right_bracer())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
    //         assert_eq(item.name(), b"Neo-Shogunate".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_legs() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_legs(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::legs()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::legs()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         1199, // 20%
    //         300, // 5%
    //         570, // 9.5% 
    //         480, // 8%
    //         570, // 9.5% 
    //         1200, // 20%
    //         1200, // 20%
    //         480, // 8%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::legs())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_shins() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_shins(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::shins()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::shins()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         1199, // 20%
    //         300, // 5%
    //         570, // 9.5% 
    //         480, // 8%
    //         570, // 9.5% 
    //         1200, // 20%
    //         1200, // 20%
    //         480, // 8%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::shins())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_boots() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_boots(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::boots()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::boots()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         1199, // 20%
    //         300, // 5%
    //         570, // 9.5% 
    //         480, // 8%
    //         570, // 9.5% 
    //         1200, // 20%
    //         1200, // 20%
    //         480, // 8%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::boots())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

    // #[test]
    // fun test_add_accessory() {
    //     let mut world = start_world();

    //     let admin = &world.admin;
    //     let access_control = &world.access_control;

    //     // Shop is empty
    //     assert_eq(world.genesis_shop.borrow_mut().length(), 0);

    //     world.genesis_shop.add_accessory(access_control, admin, world.scenario.ctx());

    //     assert_eq(world.genesis_shop.borrow_mut().length(), 1);
    //     assert_eq(world.genesis_shop.borrow_mut().contains(attributes::accessory()), true);
    //     assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::accessory()).length(), TOTAL_ITEMS);

    //     let mut index = 0;
    //     let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

    //     let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

    //     let chances = vector[
    //         1199, // 20%
    //         300, // 5%
    //         570, // 9.5% 
    //         480, // 8%
    //         570, // 9.5% 
    //         1200, // 20%
    //         1200, // 20%
    //         480, // 8%
    //     ];

    //     let mut i = 0;
        
    //     while (chances.length() > i) {
    //         index = index + chances[i];
    //         let item = world.genesis_shop.borrow_mut().borrow(attributes::accessory())[index];
    //         assert_eq(item.rarity(), rarity[i].to_string());
    //         assert_eq(item.colour_way(), colour_way[i].to_string());
    //         assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
    //         assert_eq(item.name(), b"Fang MK IV".to_string());

    //         i  = i + 1;
    //     };

    //     // last item is length - 1
    //     assert_eq(index, TOTAL_ITEMS - 1);

    //     world.end();
    // }

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

    fun test_gang_mk_iv_chestpieces(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::chestpiece())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
        assert_eq(item.name(), b"Fang MK IV".to_string());
    }

    fun test_helios_chestpieces(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::chestpiece())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
        assert_eq(item.name(), b"Helios".to_string());
    }

    fun test_neo_shogunate_chestpieces(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::chestpiece())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
        assert_eq(item.name(), b"Neo-Shogunate".to_string());
    }

    public struct World {
        scenario: Scenario,
        super_admin: Admin,
        access_control: AccessControl,
        genesis_shop: GenesisShop
    }

    fun start_world(): World {
        let mut scenario = ts::begin(OWNER);

        genesis_shop::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, super_admin) = set_up_admins(&mut scenario);
        let genesis_shop = scenario.take_shared<GenesisShop>();

        World {
            scenario,
            access_control,
            super_admin,
            genesis_shop
        }
    }

    fun end(self: World) {
        destroy(self);
    }
}