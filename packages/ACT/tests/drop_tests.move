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
        set_up_tests::set_up_admins,
        genesis_shop::{Self, GenesisShop}, 
        genesis_drop::{Self, Sale},
        avatar::{Self, AvatarRegistry, Avatar},
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

    const OWNER: address = @0xBABE;

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