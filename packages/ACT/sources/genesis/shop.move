/*
* @title Act Shop
*
* @description Creates the Genesis Shop. 
* 1 - Create each items shop using the AdminCap
* 2 - Store all items in the Genesis Shop
*
* @dev Please call these functions only once.
*/
module act::genesis_shop {
    // === Imports ===

    use std::string::String;
    use sui::{
        table_vec::{Self, TableVec},
        table::{Self, Table},
    };
    use animalib::access_control::{Admin, AccessControl};
    use act::{
        admin,
        attributes,
        assets,
    };

    const EBuilderNotEmpty: u64 = 1;

    // === Constants ===

    const GENESIS_AMOUNT: u64 = 6_000;
    const PRECISION: u64 = 10000; 

    // === Structs ===

    // temporary shared object to build the shops
    public struct Builder has key {
        id: UID,
        equipment: String,
        // each of those are popped when chances_len reach 0
        names: vector<vector<u8>>,
        colour_ways: vector<vector<vector<u8>>>,
        manufacturers: vector<vector<u8>>,
        rarities:vector<vector<vector<u8>>>,
        // never modified because used for each name 
        chances: vector<vector<u64>>,
        // - 1 each time a chance is processed = when num_of_items reach 0, reset for each name
        chances_len: u64,
        // current num of items left for the chance, reset for each chance
        num_of_items: u64,
    }

    public struct GenesisShop has key {
        id: UID,
        // equipment -> Item 
        items: Table<String, TableVec<Item>>
    }

    public struct Item has store, copy, drop {
        name: String,
        equipment: String,
        colour_way: String,
        manufacturer: String,
        rarity: String
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(ctx: &mut TxContext) {
        transfer::share_object(GenesisShop { id: object::new(ctx), items: table::new(ctx) });
    }

    public fun add_helm(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::helm(), table_vec::empty(ctx));

        new_builder(
            attributes::helm(),
            assets::helm_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::helm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::helm_chances(), 
            ctx
        )
    }

    public fun add_upper_torso(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::upper_torso(), table_vec::empty(ctx));

        new_builder(
            attributes::upper_torso(),
            assets::upper_torso_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::upper_torso_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::upper_torso_chances(),
            ctx
        )
    }

    public fun add_chestpiece(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::chestpiece(), table_vec::empty(ctx));

        new_builder(
            attributes::chestpiece(),
            assets::chestpiece_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::chestpiece_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::chestpiece_chances(),
            ctx
        )
    }

    // backpiece has no nft atm

    public fun add_left_arm(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,        
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::left_arm(), table_vec::empty(ctx));

        new_builder(
            attributes::left_arm(),
            assets::arm_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::arm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::arm_chances(),
            ctx
        )
    }

    public fun add_right_arm(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,        
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::right_arm(), table_vec::empty(ctx));

        new_builder(
            attributes::right_arm(),
            assets::arm_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::arm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::arm_chances(),
            ctx
        )
    }

    public fun add_left_bracer(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::left_bracer(), table_vec::empty(ctx));

        new_builder(
            attributes::left_bracer(),
            assets::bracer_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            ctx
        )
    }

    public fun add_right_bracer(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::right_bracer(), table_vec::empty(ctx));

        new_builder(
            attributes::right_bracer(),
            assets::bracer_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            ctx
        )
    }

    public fun add_left_glove(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::left_glove(), table_vec::empty(ctx));

        new_builder(
            attributes::left_glove(),
            assets::glove_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::glove_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::glove_chances(),
            ctx
        )
    }

    public fun add_right_glove(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::right_glove(), table_vec::empty(ctx));

        new_builder(
            attributes::right_glove(),
            assets::glove_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::glove_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::glove_chances(),
            ctx
        )
    }

    public fun add_left_pauldron(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::left_pauldron(), table_vec::empty(ctx));

        new_builder(
            attributes::left_pauldron(),
            assets::pauldrons_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            ctx
        )
    }

    public fun add_right_pauldron(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::right_pauldron(), table_vec::empty(ctx));

        new_builder(
            attributes::right_pauldron(),
            assets::pauldrons_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            ctx
        )
    }

    public fun add_legs(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::legs(), table_vec::empty(ctx));

        new_builder(
            attributes::legs(),
            assets::legs_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::legs_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::legs_chances(),
            ctx
        )
    }

    public fun add_belt(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::belt(), table_vec::empty(ctx));

        new_builder(
            attributes::belt(),
            assets::belt_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::belt_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::belt_chances(),
            ctx
        )
    }

    public fun add_shins(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::shins(), table_vec::empty(ctx));

        new_builder(
            attributes::shins(),
            assets::shins_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::shins_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::shins_chances(),
            ctx
        )
    }

    public fun add_boots(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::boots(), table_vec::empty(ctx));

        new_builder(
            attributes::boots(),
            assets::boots_names(), 
            vector[assets::cosmetic_colour_ways()],
            assets::boots_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::boots_chances(),
            ctx
        )
    }

    public fun add_primary(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::primary(), table_vec::empty(ctx));

        new_builder(
            attributes::primary(),
            assets::primary_names(), 
            vector[assets::cosmetic_colour_ways()], // same
            assets::primary_manufacturers(), 
            assets::primary_rarities(),
            assets::primary_chances(), 
            ctx
        )
    }

    public fun add_secondary(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::secondary(), table_vec::empty(ctx));

        new_builder(
            attributes::secondary(),
            assets::secondary_names(), 
            assets::secondary_colour_ways(),
            assets::secondary_manufacturers(), 
            assets::secondary_rarities(),
            assets::secondary_chances(), 
            ctx
        )
    }

    public fun add_tertiary(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Builder {
        admin::assert_genesis_minter_role(access_control, admin);
        table::add(&mut genesis_shop.items, attributes::tertiary(), table_vec::empty(ctx));
        
        new_builder(
            attributes::tertiary(),
            assets::tertiary_names(), 
            vector[assets::tertiary_colour_ways()],
            assets::tertiary_manufacturers(), 
            vector[assets::tertiary_rarities()],
            vector[assets::tertiary_chances()], 
            ctx
        )
    }

    public fun new_item(
        genesis_shop: &mut GenesisShop,
        builder: &mut Builder,
    ) {
        // let mut i = 0;        
        // let mut remaining = GENESIS_AMOUNT;

        let last_name_idx = builder.names.length() - 1;
        // while (builder.names.length() > i) {

        if (last_name_idx == 0) {
            return; // when names has been emptied it means the whole shop has been filled but we can't know exactly when exactly
        };

            let name = builder.names[last_name_idx];
            let manufacturer = builder.manufacturers[last_name_idx];
            let rarity = if (name == b"Tertiary") { 
                builder.rarities[0]
            } else {
                builder.rarities[last_name_idx]
            };
            let chances = if (name == b"Tertiary") {
                builder.chances[0]
            } else {
                builder.chances[last_name_idx]
            };
            let colour_ways = if (name == b"Secondary") {
                builder.colour_ways[last_name_idx]
            } else {
                builder.colour_ways[0]
            };

            // let mut j = 0; -> j is chances_len

            // while (chances.length() > j) {

                // let mut k = 0; -> k is num_of_items

                // while (num_of_items > k) {

                    if (builder.num_of_items == 0) {
                        builder.chances_len = builder.chances_len - 1;
                        builder.num_of_items = mul_div(chances[builder.chances_len], GENESIS_AMOUNT, PRECISION);
                        // let num_of_items = min(builder.num_of_items, remaining);
                        // remaining = remaining - num_of_items;
                    };

                    let item = Item {
                        name: name.to_string(),
                        equipment: builder.equipment,
                        colour_way: colour_ways[builder.chances_len].to_string(),
                        manufacturer: manufacturer.to_string(),
                        rarity: rarity[builder.chances_len].to_string()
                    };

                    builder.num_of_items = builder.num_of_items - 1;
                //     k = k + 1;
                // };

                if (builder.chances_len == 0) {
                    builder.chances_len = builder.chances.length();
                    builder.names.pop_back(); // increment i
                };
            //     j = j + 1;
            // };

            // i = i + 1;
        // };

        table::borrow_mut(&mut genesis_shop.items, builder.equipment).push_back(item);
    }

    // when names has been emptied it means the whole shop has been filled
    public fun destroy_builder(builder: Builder) {
        let Builder { id, names, .. } = builder;
        id.delete();
        assert!(names.is_empty(), EBuilderNotEmpty);
    }


    // === Public-Package Functions ===

    public(package) fun equipment(self: &Item): String {
        self.equipment
    }

    public(package) fun name(self: &Item): String {
        self.name
    }

    public(package) fun colour_way(self: &Item): String {
        self.colour_way
    }

    public(package) fun manufacturer(self: &Item): String {
        self.manufacturer
    }

    public(package) fun rarity(self: &Item): String {
        self.rarity
    }

    public(package) fun borrow_item_mut(self: &mut GenesisShop, name: String): &mut TableVec<Item> {
        table::borrow_mut(&mut self.items, name)
    }

    public(package) fun is_set(self: &GenesisShop): bool {
        self.items.length() == 18 // 19 equipments - backpiece
    }

    public(package) fun unpack(item: Item): (String, String, String, String, String) {
        let Item { name, equipment, colour_way, manufacturer, rarity } = item;
        (name, equipment, colour_way, manufacturer, rarity)
    }

    // === Private Functions ===

    fun new_builder(
        equipment: String,
        names: vector<vector<u8>>,
        colour_ways: vector<vector<vector<u8>>>,
        manufacturers: vector<vector<u8>>,
        rarities:vector<vector<vector<u8>>>,
        chances: vector<vector<u64>>,
        ctx: &mut TxContext
    ): Builder {
        Builder { 
            id: object::new(ctx), 
            equipment, 
            names, 
            colour_ways, 
            manufacturers, 
            rarities, 
            chances, 
            chances_len: chances.length(),
            num_of_items: 0
        }
    }

    // fun build(
    //     is_cosmetic: bool,
    //     names: vector<vector<u8>>,
    //     kinds: vector<String>,
    //     colour_ways: vector<vector<u8>>,
    //     manufacturers: vector<vector<u8>>,
    //     rarities:vector<vector<vector<u8>>>,
    //     chances: vector<vector<u64>>,
    //     ctx: &mut TxContext
    // ): TableVec<Item> {
    //     let mut i = 0;        
    //     let mut remaining = GENESIS_AMOUNT;
    //     let mut items = table_vec::empty(ctx);
    //     let names_len = names.length();
        
    //     while (names_len > i) {

    //         let name = names[i];
    //         let manufacturer = manufacturers[i];
    //         let rarity = rarities[i];
    //         let chances = chances[i];
    //         let chances_len = chances.length();

    //         let mut j = 0;

    //         while (chances_len > j) {
                
    //             let num_of_items = mul_div(chances[j], GENESIS_AMOUNT, PRECISION);
    //             let num_of_items = min(num_of_items, remaining);
    //             remaining = remaining - num_of_items;

    //             let mut k = 0;

    //             while (num_of_items > k) {
    //                 items.push_back(Item {
    //                     is_cosmetic,
    //                     name: name.to_string(),
    //                     kinds,
    //                     colour_way: colour_ways[j].to_string(),
    //                     manufacturer: manufacturer.to_string(),
    //                     rarity: rarity[j].to_string()
    //                 });

    //                 k = k + 1;
    //             };

    //             j = j + 1;
    //         };

    //         i = i + 1;
    //     };

    //     items
    // }

    // fun build_secondary(
    //     names: vector<vector<u8>>,
    //     kinds: vector<String>,
    //     colour_ways: vector<vector<vector<u8>>>,
    //     manufacturers: vector<vector<u8>>,
    //     rarities:vector<vector<vector<u8>>>,
    //     chances: vector<vector<u64>>,
    //     ctx: &mut TxContext
    // ): TableVec<Item> {
    //     let mut i = 0;        
    //     let mut remaining = GENESIS_AMOUNT;
    //     let mut items = table_vec::empty(ctx);
    //     let names_len = names.length();
        
    //     while (names_len > i) {

    //         let name = names[i];
    //         let manufacturer = manufacturers[i];
    //         let rarity = rarities[i];
    //         let chances = chances[i];
    //         let colour_ways = colour_ways[i];
    //         let chances_len = chances.length();

    //         let mut j = 0;

    //         while (chances_len > j) {
                
    //             let num_of_items = mul_div(chances[j], GENESIS_AMOUNT, PRECISION);
    //             let num_of_items = min(num_of_items, remaining);
    //             remaining = remaining - num_of_items;

    //             let mut k = 0;

    //             while (num_of_items > k) {
    //                 items.push_back(Item {
    //                     is_cosmetic: false,
    //                     name: name.to_string(),
    //                     kinds,
    //                     colour_way: colour_ways[j].to_string(),
    //                     manufacturer: manufacturer.to_string(),
    //                     rarity: rarity[j].to_string()
    //                 });

    //                 k = k + 1;
    //             };

    //             j = j + 1;
    //         };

    //         i = i + 1;
    //     };

    //     items
    // }

    // fun build_tertiary(
    //     names: vector<vector<u8>>,
    //     kinds: vector<String>,
    //     colour_ways: vector<vector<u8>>,
    //     manufacturers: vector<vector<u8>>,
    //     rarities: vector<vector<u8>>,
    //     chances: vector<u64>,
    //     ctx: &mut TxContext
    // ): TableVec<Item> {
    //     let mut i = 0;        
    //     let mut remaining = GENESIS_AMOUNT;
    //     let mut items = table_vec::empty(ctx);
    //     let names_len = names.length();
        
    //     while (names_len > i) {

    //         let name = names[i];
    //         let manufacturer = manufacturers[i];
    //         let rarity = rarities[i];
    //         let chance = chances[i];
    //         let colour_ways = colour_ways[i];

    //         let num_of_items = mul_div(chance, GENESIS_AMOUNT, PRECISION);
    //         let num_of_items = min(num_of_items, remaining);
    //         remaining = remaining - num_of_items;

    //         let mut k = 0;

    //         while (num_of_items > k) {
    //             items.push_back(Item {
    //                 is_cosmetic: false,
    //                 name: name.to_string(),
    //                 kinds,
    //                 colour_way: colour_ways.to_string(),
    //                 manufacturer: manufacturer.to_string(),
    //                 rarity: rarity.to_string()
    //             });

    //             k = k + 1;
    //         };

    //         i = i + 1;
    //     };

    //     items
    // }

    fun mul_div(x: u64, y: u64, z: u64): u64 {
        ((x as u256) * (y as u256) / (z as u256) as u64)
    }

    fun min(x: u64, y: u64): u64 {
        if (x > y) y else x
    }

    // === Test Functions ===    

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx);
    }

    #[test_only]
    public fun borrow_mut(self: &mut GenesisShop): &mut Table<String, TableVec<Item>> {
        &mut self.items
    }
}