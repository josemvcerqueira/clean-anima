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

    fun test_biodome_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"Astral Exploration Technologies".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"Biodome".to_string());
    }

    fun test_sk_viper_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"Obsidian Dynamics".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"SK-Viper".to_string());
    }

    fun test_fang_mk_iv_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"ExoTech Solutions".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"Fang MK IV".to_string());
    }

    fun test_scout_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"StratoTech Industries".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"Scout".to_string());
    }

    fun test_spectre_09_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"Phalanx Defence Corp".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"Spectre-09".to_string());
    }

    fun test_helios_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"Zenith Aerospace".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"Helios".to_string());
    }

    fun test_juggernaut_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"Omega Tactical Systems".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"Juggernaut".to_string());
    }

    fun test_baha_2000_helms(world: &mut World, index: u64, rarity: vector<u8>, colour_way: vector<u8>) {
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].rarity(), rarity.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].colour_way(), colour_way.to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].manufacturer(), b"Roots Robotics".to_string());
        assert_eq(world.genesis_shop.borrow_mut().borrow(attributes::helm())[index].name(), b"Baha-2000".to_string());
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