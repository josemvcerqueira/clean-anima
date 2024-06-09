/// Sale stores all data relative to the mint, including all Avatar with equipments data
/// Equipment data is stored in attributes in Drop, which corresponds to Avatar.attributes
/// start_times and drops_left and passes are vector corresponding to the different phases
/// passes are the whitelist object that will be airdropped to the users and destroyed upon mint

module act::act_drop {
    use std::{
        string::{utf8, String},
        type_name::TypeName,
    };
    use sui::{
        table_vec::{Self, TableVec},
        vec_map::{Self, VecMap},
        kiosk::{Self, Kiosk, KioskOwnerCap},
        coin::{Self, Coin},
        sui::SUI,
        clock::Clock,
    };
    use act::{
        act_avatar::{Self, AvatarRegistry},
        act_weapon,
        act_cosmetic,
        act_factory::{Self, Item},
        act_shop::{Shop, Helm, Chestpiece, UpperTorso, Pauldron, Arm, Glove, Bracer, Legs, Shins, Boots, Accessory, Primary, Secondary, Tertiary},
        drand, uris,
    };

    // === Errors ===

    const ETooMany: u64 = 0;
    const EPublicNotOpen: u64 = 1;
    const EWrongPass: u64 = 2;
    const EInvalidTicket: u64 = 3;
    const ESaleNotActive: u64 = 4;

    // === Constants ===

    const MAX_VEC_SIZE: u64 = 1000;
    const EWrongCoinValue: u64 = 3;
    const ETooManyMints: u64 = 4;

    // === Structs ===

    public struct MintPass has key, store {
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
        // all the data a user will mint 
        // if the user already has an Avatar equipments can be minted within the same PTB
        // otherwise Drop is stored in an AvatarTicket and resolved after processing (image, model, etc)
        drops: TableVec<vector<Item>>,
    }

    // if the user has no Avatar when he mints, a ticket is sent to him with all the info
    // images, models, hash are generated on the frontend, 
    // then the user can resolve his ticket to mint the Avatar with the equipments
    public struct AvatarTicket has key {
        id: UID,
        drop: vector<Item>,
        username: String,
        image_url: String, // to be added between mint_to_ticket and mint_to_avatar
        image_hash: String, // to be added between mint_to_ticket and mint_to_avatar
        model_url: String, // to be added between mint_to_ticket and mint_to_avatar
    }

    // === Public mutative Functions ===

    fun init(ctx: &mut TxContext) {
        transfer::share_object(Sale {
            id: object::new(ctx),
            active: true,
            start_times: vector::empty(),
            prices: vector::empty(),
            max_mints: vector::empty(),
            drops_left: 6000,
            drops: table_vec::empty(ctx), // 6000 drops of equipments
        });
    } 

    // mint equipments to the kiosk
    public fun mint_to_kiosk(
        sale: &mut Sale, 
        registry: &AvatarRegistry,
        pass: Option<MintPass>, // if none it must be public sale
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,
        coin: Coin<SUI>, // exact amount
        mut quantity: u64, // number of drops to mint
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        registry.assert_has_avatar(ctx.sender());
        let amount = coin.value();
        assert_can_mint(sale, pass, amount, quantity, clock.timestamp_ms());
        transfer::public_transfer(coin, @treasury);

        while (quantity > 0) {
            let mut drop = sale.drops.pop_back();

            while (drop.length() > 11) { // mint weapons
                let item = drop.pop_back();
                let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
                let (image_url, image_hash, model_url) = uris::get_weapon_uris(name, colour_way);
                let hash = utf8(b"hash"); // TODO generate 
                let wear_rating = 0; // TODO generate 
                let weapon = act_weapon::new(name, image_url, image_hash, model_url, kind, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

                kiosk.place(cap, weapon);
            };
            while (drop.length() > 7) { // mint cosmetics until pairs (accessory, boots, shins, legs)
                let item = drop.pop_back();
                let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
                let (image_url, image_hash, model_url) = uris::get_cosmetic_uris(name, colour_way);
                let hash = utf8(b"hash"); // TODO generate 
                let wear_rating = 0; // TODO generate 
                let cosmetic = act_cosmetic::new(name, image_url, image_hash, model_url, kind, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

                kiosk.place(cap, cosmetic);
            };
            while (drop.length() > 3) { // mint cosmetics pairs (pauldron, arm, glove, bracer)
                let item = drop.pop_back();
                let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
                let (image_url, image_hash, model_url) = uris::get_cosmetic_uris(name, colour_way);
                let hash = utf8(b"hash"); // TODO generate 
                let wear_rating = 0; // TODO generate 
                let (mut kind_left, mut kind_right) = (kind, kind);
                kind_left.append_utf8(b"Left");
                kind_right.append_utf8(b"Right");
                let cosmetic_left = act_cosmetic::new(name, image_url, image_hash, model_url, kind_left, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);
                let cosmetic_right = act_cosmetic::new(name, image_url, image_hash, model_url, kind_right, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

                kiosk.place(cap, cosmetic_left);
                kiosk.place(cap, cosmetic_right);
            };
            while (drop.length() > 0) { // mint remaining cosmetics (helm, chestpiece, upper_torso)
                let item = drop.pop_back();
                let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
                let (image_url, image_hash, model_url) = uris::get_cosmetic_uris(name, colour_way);
                let hash = utf8(b"hash"); // TODO generate 
                let wear_rating = 0; // TODO generate 
                let cosmetic = act_cosmetic::new(name, image_url, image_hash, model_url, kind, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

                kiosk.place(cap, cosmetic);
            };

            quantity = quantity - 1;
        }
    }

    // mint equipments to a ticket for generating the Avatar
    public fun mint_to_ticket(
        sale: &mut Sale, 
        registry: &AvatarRegistry,
        pass: Option<MintPass>, // if none it must be public sale
        coin: Coin<SUI>, // exact amount for one drop at this phase
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        registry.assert_has_avatar(ctx.sender());
        let amount = coin.value();
        assert_can_mint(sale, pass, amount, 1, clock.timestamp_ms());
        transfer::public_transfer(coin, @treasury);

        let drop = sale.drops.pop_back();

        transfer::transfer(
            AvatarTicket {
                id: object::new(ctx),
                drop: drop,
                username: utf8(b""),
                image_url: utf8(b""),
                image_hash: utf8(b""),
                model_url: utf8(b""),
            },
            ctx.sender() 
        );
    }

    // mint equipments and equip them to the avatar
    public fun mint_to_avatar(
        ticket: AvatarTicket,
        registry: &mut AvatarRegistry,
        alias: String,
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        assert_valid_ticket(&ticket);
        let AvatarTicket { id, mut drop, username, image_url, image_hash, model_url } = ticket;
        id.delete();
        // TODO: set avatar_url avatar_hash
        let mut avatar = act_avatar::new_impl(registry, alias, username, image_url, image_hash, model_url, utf8(b""), utf8(b""), utf8(b"Genesis"), clock, ctx);

        while (drop.length() > 11) { // mint weapons
            let item = drop.pop_back();
            let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
            let (image_url, image_hash, model_url) = uris::get_weapon_uris(name, colour_way);
            let hash = utf8(b"hash"); // TODO generate 
            let wear_rating = 0; // TODO generate 
            let weapon = act_weapon::new(name, image_url, image_hash, model_url, kind, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

            avatar.equip_minted_weapon(weapon);
        };
        while (drop.length() > 7) { // mint cosmetics until pairs (accessory, boots, shins, legs)
            let item = drop.pop_back();
            let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
            let (image_url, image_hash, model_url) = uris::get_cosmetic_uris(name, colour_way);
            let hash = utf8(b"hash"); // TODO generate 
            let wear_rating = 0; // TODO generate 
            let cosmetic = act_cosmetic::new(name, image_url, image_hash, model_url, kind, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

            avatar.equip_minted_cosmetic(cosmetic);
        };
        while (drop.length() > 3) { // mint cosmetics pairs (pauldron, arm, glove, bracer)
            let item = drop.pop_back();
            let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
            let (image_url, image_hash, model_url) = uris::get_cosmetic_uris(name, colour_way);
            let hash = utf8(b"hash"); // TODO generate 
            let wear_rating = 0; // TODO generate 
            let (mut kind_left, mut kind_right) = (kind, kind);
            kind_left.append_utf8(b"Left");
            kind_right.append_utf8(b"Right");
            let cosmetic_left = act_cosmetic::new(name, image_url, image_hash, model_url, kind_left, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);
            let cosmetic_right = act_cosmetic::new(name, image_url, image_hash, model_url, kind_right, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

            avatar.equip_minted_cosmetic(cosmetic_left);
            avatar.equip_minted_cosmetic(cosmetic_right);
        };
        while (drop.length() > 0) { // mint remaining cosmetics (helm, chestpiece, upper_torso)
            let item = drop.pop_back();
            let (name, kind, colour_way, manufacturer, rarity) = act_factory::unpack_item(item);
            let (image_url, image_hash, model_url) = uris::get_cosmetic_uris(name, colour_way);
            let hash = utf8(b"hash"); // TODO generate 
            let wear_rating = 0; // TODO generate 
            let cosmetic = act_cosmetic::new(name, image_url, image_hash, model_url, kind, colour_way, utf8(b"Genesis"), manufacturer, rarity, hash, wear_rating, ctx);

            avatar.equip_minted_cosmetic(cosmetic);
        };

        act_avatar::transfer(avatar, ctx.sender());
    }

    // === Admin functions ===

    //TODO: add admin
    public fun set_active(sale: &mut Sale, active: bool) {
        sale.active = active;
    }

    public fun set_start_times(sale: &mut Sale, start_times: vector<u64>) {
        sale.start_times = start_times;
    }

    public fun set_prices(sale: &mut Sale, prices: vector<u64>) {
        sale.prices = prices;
    }

    public fun set_drops_left(sale: &mut Sale, drops_left: u64) {
        sale.drops_left = drops_left;
    }

    // this could be done by the user instead of us to reduce costs, only drawback is deterministic randomness
    // loop over it in ptb
    // for each drop we need to generate 1 random cosmetic of each 16 type (name, colour_way)
    // and 1 random weapon of each 3 slots (name, colour_way)
    public fun push_drop(
        sale: &mut Sale, 
        helm_shop: &mut Shop<Helm, vector<vector<Item>>>,
        chestpiece_shop: &mut Shop<Chestpiece, vector<Item>>,
        upper_torso_shop: &mut Shop<UpperTorso, vector<Item>>,
        pauldron_shop: &mut Shop<Pauldron, vector<Item>>,
        arm_shop: &mut Shop<Arm, vector<Item>>,
        glove_shop: &mut Shop<Glove, vector<Item>>,
        bracer_shop: &mut Shop<Bracer, vector<Item>>,
        legs_shop: &mut Shop<Legs, vector<Item>>,
        shins_shop: &mut Shop<Shins, vector<Item>>,
        boots_shop: &mut Shop<Boots, vector<Item>>,
        accessory_shop: &mut Shop<Accessory, vector<Item>>,
        primary_shop: &mut Shop<Primary, vector<vector<Item>>>,
        secondary_shop: &mut Shop<Secondary, vector<Item>>,
        tertiary_shop: &mut Shop<Tertiary, vector<Item>>,
        mut seed: vector<u8>, // random seed
    ) {
        assert!(sale.drops.length() < sale.drops_left, ETooMany);
        let mut drop = vector::empty();

        // get total number of items
        let (mut i, mut len) = (0, 0);
        let items = helm_shop.items();
        while (i < items.length()) {
            len = len + items[i].length();
            i = i + 1;
        };
        // get random number
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(len, &digest);
        // get item
        let vec_idx = rand_number / MAX_VEC_SIZE;
        let idx = rand_number % MAX_VEC_SIZE;
        let helm = items[vec_idx][idx];
        drop.push_back(helm);

        let items = chestpiece_shop.items();
        seed.push_back(1);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let chestpiece = items[rand_number];
        drop.push_back(chestpiece);

        let items = upper_torso_shop.items();
        seed.push_back(2);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let upper_torso = items[rand_number];
        drop.push_back(upper_torso);

        let items = pauldron_shop.items();
        seed.push_back(3);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let pauldron = items[rand_number];
        drop.push_back(pauldron);

        let items = arm_shop.items();
        seed.push_back(4);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let arm = items[rand_number];
        drop.push_back(arm);

        let items = glove_shop.items();
        seed.push_back(5);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let glove = items[rand_number];
        drop.push_back(glove);

        let items = bracer_shop.items();
        seed.push_back(6);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let bracer = items[rand_number];
        drop.push_back(bracer);

        let items = legs_shop.items();
        seed.push_back(7);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let legs = items[rand_number];
        drop.push_back(legs);

        let items = shins_shop.items();
        seed.push_back(8);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let shins = items[rand_number];
        drop.push_back(shins);

        let items = boots_shop.items();
        seed.push_back(9);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let boots = items[rand_number];
        drop.push_back(boots);

        let items = accessory_shop.items();
        seed.push_back(10);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let accessory = items[rand_number];
        drop.push_back(accessory);

        let (mut i, mut len) = (0, 0);
        let items = primary_shop.items();
        while (i < items.length()) {
            len = len + items[i].length();
            i = i + 1;
        };
        seed.push_back(11);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(len, &digest);
        let vec_idx = rand_number / MAX_VEC_SIZE;
        let idx = rand_number % MAX_VEC_SIZE;
        let primary = items[vec_idx][idx];
        drop.push_back(primary);

        let items = secondary_shop.items();
        seed.push_back(12);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let secondary = items[rand_number];
        drop.push_back(secondary);

        let items = tertiary_shop.items();
        seed.push_back(13);
        let digest = drand::derive_randomness(seed);
        let rand_number = drand::safe_selection(items.length(), &digest);
        let tertiary = items[rand_number];
        drop.push_back(tertiary);

        sale.drops.push_back(drop);
    }

    // === Private functions ===

    fun assert_can_mint(sale: &Sale, pass: Option<MintPass>, amount: u64, quantity: u64, now: u64) {
        assert!(sale.active, ESaleNotActive);
        // current phase
        let mut phase = 0;
        while (now <= sale.start_times[phase]) {
            phase = phase + 1;
        };
        if (pass.is_none()) { // public sale (idx = 2)
            assert!(now > sale.start_times[2], EPublicNotOpen);
            pass.destroy_none();
        } else { // freemint or whitelist sale
            let MintPass { id, phase } = pass.destroy_some();
            assert!(now > sale.start_times[phase], EWrongPass);
            id.delete();
        };
        // check price and quantity
        assert!(amount == sale.prices[phase], EWrongCoinValue);
        assert!(quantity <= sale.max_mints[phase], ETooManyMints);
    }

    fun assert_valid_ticket(ticket: &AvatarTicket) {
        assert!(
            !ticket.username.is_empty() &&
            !ticket.image_url.is_empty() &&
            !ticket.image_hash.is_empty() &&
            !ticket.model_url.is_empty(),
            EInvalidTicket
        );
    }
}

