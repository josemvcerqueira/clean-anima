module act::genesis_drop {

    use std::string::String;
    use sui::{
        package,
        display,
        sui::SUI,
        coin::Coin,
        clock::Clock,
        kiosk::{Kiosk, KioskOwnerCap},
    };
    use kiosk::personal_kiosk;
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };
    use act::{
        attributes,
        avatar::{Self, Avatar},
        weapon,
        cosmetic,
        pseuso_random::rng,
        genesis_shop::GenesisShop,
        profile_pictures::ProfilePictures
    };

    // === Errors ===

    const EPublicNotOpen: u64 = 1;
    const EWrongPass: u64 = 2;
    const ESaleNotActive: u64 = 3;
    const EWrongCoinValue: u64 = 4;
    const ETooManyMints: u64 = 5;
    const EInvalidPass: u64 = 6;
    const ENoMoreDrops: u64 = 7;
    const EMustBeAPersonalKiosk: u64 = 8;

    // === Constants ===

    const WEAR_RATING_MAX: u64 = 1_000_000_000;
    const MIN_WEAPON_WEAR_RATING: u64 = 930_000_000;

    // === Structs ===

    public struct GENESIS_DROP has drop {}

    // pass for whitelist and free mint, public phase doesn't need a pass
    public struct GenesisPass has key {
        id: UID,
        phase: u64,
        name: String,
        image_url: String,
        description: String
    }

    public struct Sale has key {
        id: UID,
        active: bool, 
        start_times: vector<u64>, // idx -> 0: freemint, 1: whitelist, 2: public, >2: closed
        prices: vector<u64>, // length is number of phases
        max_mints: vector<u64>, // max mint for a pass by phase (for public it corresponds to max purchases in 1 tx)
        drops_left: u64,
    }

    // === Public mutative Functions ===

    fun init(otw: GENESIS_DROP, ctx: &mut TxContext) {
        let publisher = package::claim(otw, ctx);

        let mut genesis_pass_display = display::new<GenesisPass>(&publisher, ctx);
        genesis_pass_display.add(b"name".to_string(), b"{name}".to_string());
        genesis_pass_display.add(b"description".to_string(), b"{description}".to_string());
        genesis_pass_display.add(b"phase".to_string(), b"{phase}".to_string());
        genesis_pass_display.add(b"image_url".to_string(), b"{image_url}".to_string());
        genesis_pass_display.update_version();

        transfer::public_transfer(genesis_pass_display, ctx.sender());
        transfer::public_transfer(publisher, ctx.sender());

        transfer::share_object(Sale {
            id: object::new(ctx),
            active: false,
            start_times: vector::empty(),
            prices: vector::empty(),
            max_mints: vector::empty(),
            drops_left: 3150,
        });
    } 

    // mint equipments to the kiosk
    public fun mint_to_kiosk(
        sale: &mut Sale, 
        genesis_shop: &mut GenesisShop,
        pass: vector<GenesisPass>, // can't have Option in entry fun so vector instead, if none/empty it must be public sale
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,
        coin: Coin<SUI>, // exact amount
        quantity: u64, // number of drops to mint
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        assert_can_mint(sale, pass, coin.value(), quantity, clock.timestamp_ms());
        transfer::public_transfer(coin, @treasury);

        sale.drops_left = sale.drops_left - quantity;

        mint_to_kiosk_impl( 
            genesis_shop, 
            kiosk, 
            cap, 
            quantity, 
            clock, 
            ctx
        );
    }

    // mint equipments and equip them to the avatar
    public fun mint_to_avatar(
        sale: &mut Sale, 
        genesis_shop: &mut GenesisShop,
        pass: vector<GenesisPass>, // can't have Option in entry fun so vector instead, if none/empty it must be public sale
        pfps: &ProfilePictures,
        coin: Coin<SUI>, // exact amount for one drop at this phase
        clock: &Clock,
        ctx: &mut TxContext,
    ): Avatar {
        assert_can_mint(sale, pass, coin.value(), 1, clock.timestamp_ms());
        transfer::public_transfer(coin, @treasury);

        sale.drops_left = sale.drops_left - 1;

        let mut attributes = attributes::genesis_mint_types();
        let mut drop = vector::empty();

        while (!attributes.is_empty()) {
            let items = genesis_shop.borrow_item_mut(attributes.pop_back());
            let index = if (items.length() == 1) { 0 } else { rng(0, items.length() - 1, clock, ctx) };
            let item = items.swap_remove(index);
            drop.push_back(item);
        };

        let mut avatar = avatar::new_genesis_edition(ctx);
        let (mut helm, mut chestpiece, mut upper_torso) = (vector[], vector[], vector[]);

        while (!drop.is_empty()) {
            let item = drop.pop_back();
            let (hash, name, equipment, colour_way, manufacturer, rarity, image_url, model_url, texture_url) = item.unpack();

            if (equipment == attributes::helm()) {
                helm = hash;
            } else if (equipment == attributes::chestpiece()) {
                chestpiece = hash;
            } else if (equipment == attributes::upper_torso()) {
                upper_torso = hash;
            };

            if (equipment != attributes::primary() && equipment != attributes::secondary() && equipment != attributes::tertiary()) {
                let cosmetic = cosmetic::new(
                    hash,
                    name,
                    image_url,
                    model_url,
                    texture_url,
                    equipment,
                    colour_way,
                    b"Genesis".to_string(),
                    manufacturer,
                    rarity,
                    rng(0, WEAR_RATING_MAX, clock, ctx),
                    ctx
                );
                avatar.equip_minted_cosmetic(cosmetic);
            } else {
                let weapon = weapon::new(
                    hash,
                    name,
                    image_url,
                    model_url,
                    texture_url,
                    equipment,
                    colour_way,
                    b"Genesis".to_string(),
                    manufacturer,
                    rarity,
                    rng(MIN_WEAPON_WEAR_RATING, WEAR_RATING_MAX, clock, ctx),
                    ctx
                );
                avatar.equip_minted_weapon(weapon);
            };
        };

        let image_url = pfps.get(helm, chestpiece, upper_torso);
        avatar.set_image(image_url);

        avatar
    }

    // === Admin functions ===

    public fun airdrop_freemint(
        access_control: &AccessControl, 
        admin: &Admin,
        recipient: address,
        ctx: &mut TxContext,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        transfer::transfer(
            GenesisPass { 
                id: object::new(ctx), 
                name: b"Anima Labs’ Genesis Free Mint Pass".to_string(),
                phase: 1, 
                image_url: b"ipfs://QmX3vh5JiiArsDkxDuzPYGExsNm3UpjPHFH3P47sNUwzFD".to_string(),
                description: b"A free mint ticket for Anima Labs’ Genesis drop.".to_string() 
            }, 
            recipient
        );
    }

    public fun airdrop_whitelist(
        access_control: &AccessControl, 
        admin: &Admin,
        recipient: address,
        ctx: &mut TxContext,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        transfer::transfer(
            GenesisPass { 
                id: object::new(ctx), 
                name: b"Anima Labs’ Genesis Whitelist Pass".to_string(),
                phase: 2, 
                image_url: b"ipfs://QmaDx1VF1kpR4CKYzTzPRryUusnivWV6GwVFgELS65A8Fd".to_string(), 
                description: b"A whitelist ticket for Anima Labs’ Genesis drop.".to_string() 
            }, 
            recipient
        );
    }

    public fun admin_mint_to_kiosk(
        access_control: &AccessControl, 
        admin: &Admin,
        genesis_shop: &mut GenesisShop,
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,
        quantity: u64, // number of drops to mint
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        mint_to_kiosk_impl(
            genesis_shop, 
            kiosk, 
            cap, 
            quantity, 
            clock, 
            ctx
        );
    }

    public fun set_active(
        sale: &mut Sale, 
        access_control: &AccessControl, 
        admin: &Admin,
        active: bool
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        sale.active = active;
    }

    public fun set_start_times(
        sale: &mut Sale, 
        access_control: &AccessControl, 
        admin: &Admin,
        start_times: vector<u64>
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        sale.start_times = start_times;
    }

    public fun set_max_mints(
        sale: &mut Sale, 
        access_control: &AccessControl, 
        admin: &Admin,
        max_mints: vector<u64>
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        sale.max_mints = max_mints;
    }

    public fun set_prices(
        sale: &mut Sale, 
        access_control: &AccessControl, 
        admin: &Admin,
        prices: vector<u64>
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        sale.prices = prices;
    }

    public fun set_drops_left(
        sale: &mut Sale, 
        access_control: &AccessControl, 
        admin: &Admin,
        drops_left: u64
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        sale.drops_left = drops_left;
    }

    // === Public-Package Functions ===

    // === Private functions ===

    fun mint_to_kiosk_impl(
        genesis_shop: &mut GenesisShop,
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,
        mut quantity: u64, // number of drops to mint
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        assert!(personal_kiosk::is_personal(kiosk), EMustBeAPersonalKiosk);

        while (quantity > 0) {
            let mut attributes = attributes::genesis_mint_types();
            while (!attributes.is_empty()) {
                let x = attributes.pop_back();
                let items = genesis_shop.borrow_item_mut(x);

                let index = if (items.length() == 1) { 0 } else { rng(0, items.length() - 1, clock, ctx) };
                let item = items.swap_remove(index);
                let (hash, name, equipment, colour_way, manufacturer, rarity, image_url, model_url, texture_url) = item.unpack();

                if (equipment != attributes::primary() && equipment != attributes::secondary() && equipment != attributes::tertiary()) {
                    let cosmetic = cosmetic::new(
                        hash,
                        name,
                        image_url,
                        model_url,
                        texture_url,
                        equipment,
                        colour_way,
                        b"Genesis".to_string(),
                        manufacturer,
                        rarity,
                        rng(0, WEAR_RATING_MAX, clock, ctx),
                        ctx
                    );
                    kiosk.place(cap, cosmetic);
                } else {
                    let weapon = weapon::new(
                        hash,
                        name,
                        image_url,
                        model_url,
                        texture_url,
                        equipment,
                        colour_way,
                        b"Genesis".to_string(),
                        manufacturer,
                        rarity,
                        rng(MIN_WEAPON_WEAR_RATING, WEAR_RATING_MAX, clock, ctx),
                        ctx
                    );
                    kiosk.place(cap, weapon);
                };
            };
            quantity = quantity - 1;
        };
    }

    fun assert_can_mint(sale: &Sale, mut pass: vector<GenesisPass>, amount: u64, quantity: u64, now: u64) {
        assert!(sale.active && now > sale.start_times[0], ESaleNotActive);
        assert!(sale.drops_left >= quantity, ENoMoreDrops);
        assert!(pass.length() < 2, EInvalidPass);
        // current phase
        let mut phase = 0;
        let mut i = 0;

        while (sale.start_times.length() > i) {
            if (now > sale.start_times[i]) {
                phase = phase + 1;
            };
            i = i + 1;
        };
        phase = phase - 1;
        
        if (pass.is_empty()) { // public sale (idx = 2)
            assert!(now > sale.start_times[2], EPublicNotOpen);
        } else { // freemint or whitelist sale
            let GenesisPass { id, phase, .. } = pass.pop_back();
            assert!(now > sale.start_times[phase - 1], EWrongPass);
            id.delete();
        };
        pass.destroy_empty();
        // check price and quantity
        assert!(amount >= sale.prices[phase] * quantity, EWrongCoinValue);
        assert!(quantity <= sale.max_mints[phase], ETooManyMints);
    }

    // === Test Functions ===

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(GENESIS_DROP {}, ctx);
    }

    #[test_only]
    public fun active(self: &Sale): bool {
        self.active
    }

    #[test_only]
    public fun start_times(self: &Sale): vector<u64> {
        self.start_times
    }

    #[test_only]
    public fun prices(self: &Sale): vector<u64> {
        self.prices
    }

    #[test_only]
    public fun max_mints(self: &Sale): vector<u64> {
        self.prices
    }

    #[test_only]
    public fun drops_left(self: &Sale): u64 {
        self.drops_left
    }

    #[test_only]
    public fun new_genesis_pass(phase: u64, ctx: &mut TxContext): GenesisPass {
        GenesisPass {
            id: object::new(ctx),
            phase,
            name: b"name".to_string(),
            image_url: b"genesis_pass".to_string(),
            description: b"description".to_string()
        }
    }

    #[test_only]
    public use fun pass_name as GenesisPass.name;
    public fun pass_name(pass: &GenesisPass): String {
        pass.name
    }

    #[test_only]
    public use fun pass_phase as GenesisPass.phase;
    public fun pass_phase(pass: &GenesisPass): u64 {
        pass.phase
    }

    #[test_only]
    public use fun pass_image_url as GenesisPass.image_url;
    public fun pass_image_url(pass: &GenesisPass): String {
        pass.image_url
    }

    #[test_only]
    public use fun pass_description as GenesisPass.description;
    public fun pass_description(pass: &GenesisPass): String {
        pass.description
    } 
}
