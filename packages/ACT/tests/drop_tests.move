#[test_only]
module act::genesis_drop_tests {
    use sui::{
        clock::{Self, Clock},
        random::{Self, Random},
        test_utils::{assert_eq, destroy},
        kiosk::{Self, Kiosk, KioskOwnerCap},
        test_scenario::{Self as ts, Scenario},
    };
    use animalib::access_control::{Admin, AccessControl};
    use act::{
        assets,
        attributes,
        set_up_tests::set_up_admins,
        genesis_drop::{Self, Sale},
        avatar::{Self, AvatarRegistry, Avatar},
        genesis_shop::{Self, new_builder_for_testing, GenesisShop}, 
    };

    public struct World {
        scenario: Scenario,
        clock: Clock,
        random: Random,
        super_admin: Admin,
        access_control: AccessControl,
        genesis_shop: GenesisShop,
        sale: Sale,
        avatar_registry: AvatarRegistry,
        avatar: Avatar,
        kiosk: Kiosk,
        kiosk_cap: KioskOwnerCap,
    }

    const OWNER: address = @0x0;
    const TOTAL_ITEMS: u64 = 10;

    #[test]
    fun test_init() {
        let mut world = start_world();

        assert_eq(world.sale.active(), true);
        assert_eq(world.sale.start_times(), vector[]);
        assert_eq(world.sale.prices(), vector[]);
        assert_eq(world.sale.max_mints(), vector[]);
        assert_eq(world.sale.drops_left(), 3000);

        world.add_genesis_shop();

        world.end();
    }

    fun add_genesis_shop(world: &mut World) {

        let mut primary = new_builder_for_testing(
            &mut world.genesis_shop,
            attributes::primary(),
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
            attributes::secondary(),
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
            attributes::tertiary(),
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
            attributes::helm(),
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
            attributes::chestpiece(),
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
            attributes::left_pauldron(),
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
            attributes::right_pauldron(),
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
            attributes::left_bracer(),
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
            attributes::right_bracer(),
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
            attributes::legs(),
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
            attributes::right_glove(),
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
            attributes::left_glove(),
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
            attributes::right_arm(),
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
            attributes::left_arm(),
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
            attributes::belt(),
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
            attributes::shins(),
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
            attributes::upper_torso(),
            assets::upper_torso_names(), 
            vector[b"Obsidian"],
            assets::upper_torso_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::upper_torso_chances(),
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

            i = i + 1;
        };

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
    }
 
    fun start_world(): World {
        let mut scenario = ts::begin(OWNER);

        avatar::init_for_testing(scenario.ctx());
        genesis_shop::init_for_testing(scenario.ctx());
        genesis_drop::init_for_testing(scenario.ctx());
        random::create_for_testing(scenario.ctx());

        scenario.next_tx(OWNER);

        let (access_control, super_admin) = set_up_admins(&mut scenario);
        let genesis_shop = scenario.take_shared<GenesisShop>();
        let sale = scenario.take_shared<Sale>();
        let random = scenario.take_shared<Random>();
        let mut avatar_registry = scenario.take_shared<AvatarRegistry>();
        let clock = clock::create_for_testing(scenario.ctx());

        let avatar = avatar::new(
            &mut avatar_registry, 
            b"image_url".to_string(),
            b"image_hash".to_string(),
            b"model_url".to_string(),
            b"avatar_url".to_string(),
            b"avatar_hash".to_string(),
            b"edition".to_string(),
            scenario.ctx()
        );

        let (kiosk, kiosk_cap) = kiosk::new(scenario.ctx());

        World {
            sale,
            kiosk,
            kiosk_cap,
            random,
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