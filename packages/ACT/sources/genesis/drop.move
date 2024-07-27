/// Sale stores all data relative to the mint, including all Avatar with equipments data
/// Equipment data is stored in attributes in Drop, which corresponds to Avatar.attributes
/// start_times and drops_left and passes are vector corresponding to the different phases
/// passes are the whitelist object that will be airdropped to the users and destroyed upon mint

module act::genesis_drop {

    use std::{
        string::{utf8, String},
    };
    use sui::{
        kiosk::{Kiosk, KioskOwnerCap},
        coin::Coin,
        sui::SUI,
        clock::Clock,
        random::Random,
    };
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };
    use act::{
        attributes,
        avatar::{Self, AvatarRegistry},
        weapon,
        cosmetic,
        genesis_shop::{Item, GenesisShop},
    };

    // === Errors ===

    const EPublicNotOpen: u64 = 1;
    const EWrongPass: u64 = 2;
    const EInvalidTicket: u64 = 3;
    const ESaleNotActive: u64 = 4;
    const EWrongCoinValue: u64 = 5;
    const ETooManyMints: u64 = 6;
    const EInvalidPass: u64 = 7;
    const ENoMoreDrops: u64 = 8;

    // === Constants ===

    const WEAR_RATING_MAX: u64 = 1_000_000_000;
    const MIN_WEAPON_WEAR_RATING: u64 = 930_000_000;

    // === Structs ===

    // pass for whitelist and free mint, public phase doesn't need a pass
    public struct GenesisPass has key, store {
        id: UID,
        phase: u64,
    }

    public struct Sale has key {
        id: UID,
        active: bool, 
        start_times: vector<u64>, // idx -> 0: freemint, 1: whitelist, 2: public, >2: closed
        prices: vector<u64>, // length is number of phases
        max_mints: vector<u64>, // max mint for a pass by phase (for public it corresponds to max purchases in 1 tx)
        drops_left: u64,
    }

    // if the user has no Avatar when he mints, a ticket is sent to him with all the info
    // images, models, hash are generated on the frontend, 
    // then the user can resolve his ticket to mint the Avatar with the equipments
    public struct AvatarTicket has key {
        id: UID,
        drop: vector<Item>,
        // following fields are to be added between mint_to_ticket and mint_to_avatar
        image_url: String, 
        image_hash: String,
        model_url: String, 
    }

    // === Public mutative Functions ===

    fun init(ctx: &mut TxContext) {
        transfer::share_object(Sale {
            id: object::new(ctx),
            active: true,
            start_times: vector::empty(),
            prices: vector::empty(),
            max_mints: vector::empty(),
            drops_left: 3000,
        });
    } 

    // mint equipments to the kiosk
    entry fun mint_to_kiosk(
        sale: &mut Sale, 
        genesis_shop: &mut GenesisShop,
        registry: &AvatarRegistry,
        pass: vector<GenesisPass>, // can't have Option in entry fun so vector instead, if none/empty it must be public sale
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,
        coin: Coin<SUI>, // exact amount
        mut quantity: u64, // number of drops to mint
        random: &Random,
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        registry.assert_has_avatar(ctx.sender());
        assert_can_mint(sale, pass, coin.value(), quantity, clock.timestamp_ms());
        transfer::public_transfer(coin, @treasury);

        let mut gen = random.new_generator(ctx);
        sale.drops_left = sale.drops_left - quantity;

        while (quantity > 0) {
            let mut attributes = attributes::genesis_mint_types();
            while (!attributes.is_empty()) {
                let x = attributes.pop_back();
                let items = genesis_shop.borrow_item_mut(x);

                let index = if (items.length() == 1) { 0 } else { gen.generate_u64_in_range(0, items.length() - 1) };
                let item = items.swap_remove(index);
                let (name, equipment, colour_way, manufacturer, rarity) = item.unpack();

                if (equipment != attributes::primary() && equipment != attributes::secondary() && equipment != attributes::tertiary()) {
                    let cosmetic = cosmetic::new(
                        name,
                        utf8(b""),
                        utf8(b""),
                        utf8(b""),
                        equipment,
                        colour_way,
                        utf8(b"Genesis"),
                        manufacturer,
                        rarity,
                        utf8(b""),
                        gen.generate_u64_in_range(0, WEAR_RATING_MAX),
                        ctx
                    );
                    kiosk.place(cap, cosmetic);
                } else {
                    let weapon = weapon::new(
                        name,
                        utf8(b""),
                        utf8(b""),
                        utf8(b""),
                        equipment,
                        colour_way,
                        utf8(b"Genesis"),
                        manufacturer,
                        rarity,
                        utf8(b""),
                        gen.generate_u64_in_range(MIN_WEAPON_WEAR_RATING, WEAR_RATING_MAX),
                        ctx
                    );
                    kiosk.place(cap, weapon);
                };
            };
            quantity = quantity - 1;
        };
    }

    // mint equipments to a ticket for generating the Avatar
    entry fun mint_to_ticket(
        sale: &mut Sale, 
        genesis_shop: &mut GenesisShop,
        registry: &AvatarRegistry,
        pass: vector<GenesisPass>, // can't have Option in entry fun so vector instead, if none/empty it must be public sale
        coin: Coin<SUI>, // exact amount for one drop at this phase
        random: &Random,
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        registry.assert_no_avatar(ctx.sender());
        assert_can_mint(sale, pass, coin.value(), 1, clock.timestamp_ms());
        transfer::public_transfer(coin, @treasury);

        sale.drops_left = sale.drops_left - 1;

        let mut attributes = attributes::genesis_mint_types();
        let mut gen = random.new_generator(ctx);
        let mut drop = vector::empty();

        while (!attributes.is_empty()) {
            let items = genesis_shop.borrow_item_mut(attributes.pop_back());
            let index = if (items.length() == 1) { 0 } else { gen.generate_u64_in_range(0, items.length() - 1) };
            let item = items.swap_remove(index);
            drop.push_back(item);
        };

        transfer::transfer(
            AvatarTicket {
                id: object::new(ctx),
                drop: drop,
                image_url: utf8(b"TODO"),
                image_hash: utf8(b"TODO"),
                model_url: utf8(b"TODO"),
            },
            ctx.sender() 
        );
    }

    // mint equipments and equip them to the avatar
    entry fun mint_to_avatar(
        ticket: AvatarTicket,
        registry: &mut AvatarRegistry,
        random: &Random,
        ctx: &mut TxContext,
    ) {
        assert_valid_ticket(&ticket);
        let AvatarTicket { id, mut drop, image_url, image_hash, model_url } = ticket;
        id.delete();
        // TODO: set avatar_url avatar_hash
        let mut avatar = avatar::new(registry, image_url, image_hash, model_url, utf8(b""), utf8(b""), utf8(b"Genesis"), ctx);
        let mut gen = random.new_generator(ctx);

        while (!drop.is_empty()) {
            let item = drop.pop_back();
            let (name, equipment, colour_way, manufacturer, rarity) = item.unpack();

            if (equipment != attributes::primary() && equipment != attributes::secondary() && equipment != attributes::tertiary()) {
                let cosmetic = cosmetic::new(
                    name,
                    utf8(b""),
                    utf8(b""),
                    utf8(b""),
                    equipment,
                    colour_way,
                    utf8(b"Genesis"),
                    manufacturer,
                    rarity,
                    utf8(b""),
                    gen.generate_u64_in_range(0, WEAR_RATING_MAX),
                    ctx
                );
                avatar.equip_minted_cosmetic(cosmetic);
            } else {
                let weapon = weapon::new(
                    name,
                    utf8(b""),
                    utf8(b""),
                    utf8(b""),
                    equipment,
                    colour_way,
                    utf8(b"Genesis"),
                    manufacturer,
                    rarity,
                    utf8(b""),
                    gen.generate_u64_in_range(MIN_WEAPON_WEAR_RATING, WEAR_RATING_MAX),
                    ctx
                );
                avatar.equip_minted_weapon(weapon);
            };
        };


        avatar::transfer(avatar, ctx.sender());
    }

    // === Public-View Functions ===

    // === Admin functions ===

    public fun airdrop_freemint(
        access_control: &AccessControl, 
        admin: &Admin,
        recipient: address,
        ctx: &mut TxContext,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        transfer::public_transfer(GenesisPass { id: object::new(ctx), phase: 0 }, recipient);
    }

    public fun airdrop_whitelist(
        access_control: &AccessControl, 
        admin: &Admin,
        recipient: address,
        ctx: &mut TxContext,
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        transfer::public_transfer(GenesisPass { id: object::new(ctx), phase: 1 }, recipient);
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
        start_times: vector
    <u64>) {
        admin::assert_genesis_minter_role(access_control, admin);
        sale.start_times = start_times;
    }

    public fun set_max_mints(
        sale: &mut Sale, 
        access_control: &AccessControl, 
        admin: &Admin,
        max_mints: vector
    <u64>) {
        admin::assert_genesis_minter_role(access_control, admin);
        sale.max_mints = max_mints;
    }

    public fun set_prices(
        sale: &mut Sale, 
        access_control: &AccessControl, 
        admin: &Admin,
        prices: vector
    <u64>) {
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
            let GenesisPass { id, phase } = pass.pop_back();
            assert!(now > sale.start_times[phase], EWrongPass);
            id.delete();
        };
        pass.destroy_empty();
        // check price and quantity
        assert!(amount == sale.prices[phase] * quantity, EWrongCoinValue);
        assert!(quantity <= sale.max_mints[phase], ETooManyMints);
    }

    fun assert_valid_ticket(ticket: &AvatarTicket) {
        assert!(
            !ticket.image_url.is_empty() &&
            !ticket.image_hash.is_empty() &&
            !ticket.model_url.is_empty(),
            EInvalidTicket
        );
    }

    // === Test Functions ===

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx);
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
    public fun drop(self: &AvatarTicket): vector<Item> {
        self.drop
    }

    #[test_only]
    public fun new_genesis_pass(phase: u64, ctx: &mut TxContext): GenesisPass {
        GenesisPass {
            id: object::new(ctx),
            phase
        }
    }
}
