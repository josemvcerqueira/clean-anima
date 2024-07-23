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
    const TOTAL_ITEMS: u64 = 6_000;

    #[test]
    fun test_add_helm() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        world.genesis_shop.add_helm(access_control, admin, world.scenario.ctx());

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::helm()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm()).length(), TOTAL_ITEMS);

        //  6000 * 2% = 120 items === index 119
        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

        let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

        let chances = vector[
            119, // 2%
            60,  // 1%
            90,  // 1.5%
            75,  // 1.25%
            90,  // 1.5%
            120, // 2%
            120, // 2%
            75   // 1.25%
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_biodome_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let chances = vector[
            120, // 2%
            60,  // 1%
            90,  // 1.5%
            75,  // 1.25%
            90,  // 1.5%
            120, // 2%
            120, // 2%
            75   // 1.25%
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_sk_viper_helms(&mut world, index, rarity[i], colour_way[i]);

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
            test_scout_helms(&mut world, index, rarity[i], colour_way[i]);

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
            test_helios_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_juggernaut_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let mut i = 0;

        while (chances.length() > i) {
            index = index + chances[i];
            test_baha_2000_helms(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        world.end();
    }

    #[test]
    fun test_add_chestpiece() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        world.genesis_shop.add_chestpiece(access_control, admin, world.scenario.ctx());

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::chestpiece()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::chestpiece()).length(), TOTAL_ITEMS);

        //  6000 * 2% = 120 items === index 119
        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

        let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

        let chances = vector[
            479, // 8%
            120,  // 2%
            240,  // 4%
            180,  // 3%
            240,  // 4%
            480, // 8%
            480, // 8%
            180,  // 3%
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_gang_mk_iv_chestpieces(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let chances = vector[
            360, // 6%
            60,  // 1%
            210, // 3.5%
            120,  // 2%
            210, // 3.5%
            360, // 6%
            360, // 6%
            120,  // 2%
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_helios_chestpieces(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            test_neo_shogunate_chestpieces(&mut world, index, rarity[i], colour_way[i]);

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        world.end();
    }

    #[test]
    fun test_add_upper_torso() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        world.genesis_shop.add_upper_torso(access_control, admin, world.scenario.ctx());

        assert_eq(world.genesis_shop.borrow_mut().length(), 1);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::upper_torso()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::upper_torso()).length(), TOTAL_ITEMS);

        //  6000 * 2% = 120 items === index 119
        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

        let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

        let chances = vector[
            1199, // 20%
            300,  // 5%
            570,  // 9.5
            480,  // 8%
            570,  // 9.5
            1200, // 20%
            1200, // 20%
            480,  // 8%
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

        world.end();
    }

    #[test]
    fun test_add_pauldrons() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        world.genesis_shop.add_left_pauldron(access_control, admin, world.scenario.ctx());
        world.genesis_shop.add_right_pauldron(access_control, admin, world.scenario.ctx());

        assert_eq(world.genesis_shop.borrow_mut().length(), 2);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_pauldron()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_pauldron()).length(), TOTAL_ITEMS);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_pauldron()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_pauldron()).length(), TOTAL_ITEMS);

        //  6000 * 2% = 120 items === index 119
        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

        let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

        let chances = vector[
            479,  // 8%
            120, // 2%
            240, //4%
            180, // 3% 
            240, //4%
            480,  // 8%
            480,  // 8%
            180, // 3% 
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

        let chances = vector[
            360, // 6% 
            60, // 1%,
            210, // 3.5 
            120, // 2% 
            210, // 3.5 
            360, // 6% 
            360, // 6% 
            120, // 2% 
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

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        world.end();
    }

    #[test]
    fun test_add_arms() {
        let mut world = start_world();

        let admin = &world.admin;
        let access_control = &world.access_control;

        // Shop is empty
        assert_eq(world.genesis_shop.borrow_mut().length(), 0);

        world.genesis_shop.add_left_arm(access_control, admin, world.scenario.ctx());
        world.genesis_shop.add_right_arm(access_control, admin, world.scenario.ctx());

        assert_eq(world.genesis_shop.borrow_mut().length(), 2);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::left_arm()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::left_arm()).length(), TOTAL_ITEMS);
        assert_eq(world.genesis_shop.borrow_mut().contains(attributes::right_arm()), true);
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::right_arm()).length(), TOTAL_ITEMS);

        //  6000 * 2% = 120 items === index 119
        let mut index = 0;
        let rarity = vector[b"Ultra Rare", b"Mythic", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare", b"Ultra Rare"];

        let colour_way = vector[b"Vesper", b"Hikari", b"Volt", b"Blood Ivory", b"Red Damascus", b"Forest", b"Dusk", b"Viceroy"];

        let chances = vector[
            1199,  // 20%
            300, // 5%
            570, // 9.5%
            480, // 8% 
            570, // 9.5%
            1200,  // 20%
            1200,  // 20%
            480, // 8%  
        ];

        let mut i = 0;
        
        while (chances.length() > i) {
            index = index + chances[i];
            let item = world.genesis_shop.borrow_mut().borrow(attributes::left_arm())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            let item = world.genesis_shop.borrow_mut().borrow(attributes::right_arm())[index];
            assert_eq(item.rarity(), rarity[i].to_string());
            assert_eq(item.colour_way(), colour_way[i].to_string());
            assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
            assert_eq(item.name(), b"Fang MK IV".to_string());

            i  = i + 1;
        };

        // last item is length - 1
        assert_eq(index, TOTAL_ITEMS - 1);

        world.end();
    }

    fun test_biodome_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Astral Exploration Technologies".to_string());
        assert_eq(item.name(), b"Biodome".to_string());
    }

    fun test_sk_viper_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Obsidian Dynamics".to_string());
        assert_eq(item.name(), b"SK-Viper".to_string());
    }

    fun test_fang_mk_iv_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"ExoTech Solutions".to_string());
        assert_eq(item.name(), b"Fang MK IV".to_string());
    }

    fun test_scout_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"StratoTech Industries".to_string());
        assert_eq(item.name(), b"Scout".to_string());
    }

    fun test_spectre_09_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Phalanx Defence Corp".to_string());
        assert_eq(item.name(), b"Spectre-09".to_string());
    }

    fun test_helios_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Zenith Aerospace".to_string());
        assert_eq(item.name(), b"Helios".to_string());
    }

    fun test_juggernaut_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Omega Tactical Systems".to_string());
        assert_eq(item.name(), b"Juggernaut".to_string());
    }

    fun test_baha_2000_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        let item = world.genesis_shop.borrow_mut().borrow(attributes::helm())[index];
        assert_eq(item.rarity(), rarity.to_string());
        assert_eq(item.colour_way(), colour_way.to_string());
        assert_eq(item.manufacturer(), b"Roots Robotics".to_string());
        assert_eq(item.name(), b"Baha-2000".to_string());
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
        admin: Admin,
        super_admin: Admin,
        access_control: AccessControl,
        genesis_shop: GenesisShop
    }

    fun start_world(): World {
        let mut scenario = ts::begin(OWNER);

        genesis_shop::init_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, super_admin, admin) = set_up_admins(&mut scenario);
        let genesis_shop = scenario.take_shared<GenesisShop>();

        World {
            scenario,
            access_control,
            super_admin,
            admin,
            genesis_shop
        }
    }

    fun end(self: World) {
        destroy(self);
    }
}