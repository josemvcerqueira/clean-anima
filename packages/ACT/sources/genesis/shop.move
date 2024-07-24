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

    // === Constants ===

    const GENESIS_AMOUNT: u64 = 6_000;
    const PRECISION: u64 = 10000; 

    // === Structs ===

    public struct GenesisShop has key {
        id: UID,
        items: Table<String, TableVec<Item>>
    }

    public struct Item has store, copy, drop {
        name: String,
        kinds: vector<String>,
        is_cosmetic: bool,
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
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::helm_names(), 
            vector[attributes::helm()],
            assets::cosmetic_colour_ways(),
            assets::helm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::helm_chances(), 
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::helm(), items);
    }

    public fun add_upper_torso(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::upper_torso_names(), 
            vector[attributes::upper_torso()],
            assets::cosmetic_colour_ways(),
            assets::upper_torso_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::upper_torso_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::upper_torso(), items);
    }

    public fun add_chestpiece(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::chestpiece_names(), 
            vector[attributes::chestpiece()],
            assets::cosmetic_colour_ways(),
            assets::chestpiece_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::chestpiece_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::chestpiece(), items);
    }

    // backpiece has no nft atm

    public fun add_left_arm(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,        
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::arm_names(), 
            vector[attributes::left_arm()],
            assets::cosmetic_colour_ways(),
            assets::arm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::arm_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::left_arm(), items);
    }

    public fun add_right_arm(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,        
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::arm_names(), 
            vector[attributes::right_arm()],
            assets::cosmetic_colour_ways(),
            assets::arm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::arm_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::right_arm(), items);
    }

    public fun add_left_bracer(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::bracer_names(), 
            vector[attributes::left_bracer()],
            assets::cosmetic_colour_ways(),
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::left_bracer(), items);
    }

    public fun add_right_bracer(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::bracer_names(), 
            vector[attributes::right_bracer()],
            assets::cosmetic_colour_ways(),
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::right_bracer(), items);
    }

    public fun add_left_glove(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::glove_names(), 
            vector[attributes::left_glove()],
            assets::cosmetic_colour_ways(),
            assets::glove_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::glove_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::left_glove(), items);
    }

    public fun add_right_glove(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::glove_names(), 
            vector[attributes::right_glove()],
            assets::cosmetic_colour_ways(),
            assets::glove_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::glove_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::right_glove(), items);
    }

    public fun add_left_pauldron(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::pauldrons_names(), 
            vector[attributes::left_pauldron()],
            assets::cosmetic_colour_ways(),
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::left_pauldron(), items);
    }

    public fun add_right_pauldron(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::pauldrons_names(), 
            vector[attributes::right_pauldron()],
            assets::cosmetic_colour_ways(),
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::right_pauldron(), items);
    }

    public fun add_legs(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::legs_names(), 
            vector[attributes::legs()],
            assets::cosmetic_colour_ways(),
            assets::legs_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::legs_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::legs(), items);
    }

    public fun add_belt(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::belt_names(), 
            vector[attributes::belt()],
            assets::cosmetic_colour_ways(),
            assets::belt_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::belt_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::belt(), items);
    }

    public fun add_shins(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::shins_names(), 
            vector[attributes::shins()],
            assets::cosmetic_colour_ways(),
            assets::shins_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::shins_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::shins(), items);
    }

    public fun add_boots(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            assets::boots_names(), 
            vector[attributes::boots()],
            assets::cosmetic_colour_ways(),
            assets::boots_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::boots_chances(),
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::boots(), items);
    }

    public fun add_primary(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            false,
            assets::primary_names(), 
            vector[attributes::primary()],
            assets::cosmetic_colour_ways(), // same
            assets::primary_manufacturers(), 
            assets::primary_rarities(),
            assets::primary_chances(), 
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::primary(), items);
    }

    public fun add_secondary(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build_secondary(
            assets::secondary_names(), 
            vector[attributes::secondary()],
            assets::secondary_colour_ways(),
            assets::secondary_manufacturers(), 
            assets::secondary_rarities(),
            assets::secondary_chances(), 
            GENESIS_AMOUNT, 
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::secondary(), items);
    }

    public fun add_tertiary(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        admin::assert_genesis_minter_role(access_control, admin);
        let items = build_tertiary(
            assets::tertiary_names(), 
            vector[attributes::tertiary()],
            assets::tertiary_colour_ways(),
            assets::tertiary_manufacturers(), 
            assets::tertiary_rarities(),
            assets::tertiary_chances(), 
            GENESIS_AMOUNT, 
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::tertiary(), items);
    }

    // === Public-Package Functions ===

    public(package) fun kinds(self: &Item): vector<String> {
        self.kinds
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

    public(package) fun unpack(item: Item): (String, vector<String>, String, String, String, bool) {
        let Item { name, kinds, colour_way, manufacturer, rarity, is_cosmetic } = item;
        (name, kinds, colour_way, manufacturer, rarity, is_cosmetic)
    }

    // === Private Functions ===

    fun build(
        is_cosmetic: bool,
        names: vector<vector<u8>>,
        kinds: vector<String>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities:vector<vector<vector<u8>>>,
        chances: vector<vector<u64>>,
        ctx: &mut TxContext
    ): TableVec<Item> {
        let mut i = 0;        
        let mut remaining = GENESIS_AMOUNT;
        let mut items = table_vec::empty(ctx);
        let names_len = names.length();
        
        while (names_len > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chances = chances[i];
            let chances_len = chances.length();

            let mut j = 0;

            while (chances_len > j) {
                
                let num_of_items = mul_div(chances[j], GENESIS_AMOUNT, PRECISION);
                let num_of_items = min(num_of_items, remaining);
                remaining = remaining - num_of_items;

                let mut k = 0;

                while (num_of_items > k) {
                    items.push_back(Item {
                        is_cosmetic,
                        name: name.to_string(),
                        kinds,
                        colour_way: colour_ways[j].to_string(),
                        manufacturer: manufacturer.to_string(),
                        rarity: rarity[j].to_string()
                    });

                    k = k + 1;
                };

                j = j + 1;
            };

            i = i + 1;
        };

        items
    }

    fun build_secondary(
        names: vector<vector<u8>>,
        kinds: vector<String>,
        colour_ways: vector<vector<vector<u8>>>,
        manufacturers: vector<vector<u8>>,
        rarities:vector<vector<vector<u8>>>,
        chances: vector<vector<u64>>,
        precision: u64,
        ctx: &mut TxContext
    ): TableVec<Item> {
        let mut i = 0;        
        let mut remaining = precision;
        let mut items = table_vec::empty(ctx);
        let names_len = names.length();
        
        while (names_len > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chances = chances[i];
            let colour_ways = colour_ways[i];
            let chances_len = chances.length();

            let mut j = 0;

            while (chances_len > j) {
                
                let num_of_items = mul_div(chances[j], precision, PRECISION);
                let num_of_items = min(num_of_items, remaining);
                remaining = remaining - num_of_items;

                let mut k = 0;

                while (num_of_items > k) {
                    items.push_back(Item {
                        is_cosmetic: false,
                        name: name.to_string(),
                        kinds,
                        colour_way: colour_ways[j].to_string(),
                        manufacturer: manufacturer.to_string(),
                        rarity: rarity[j].to_string()
                    });

                    k = k + 1;
                };

                j = j + 1;
            };

            i = i + 1;
        };

        items
    }

    fun build_tertiary(
        names: vector<vector<u8>>,
        kinds: vector<String>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
        chances: vector<u64>,
        precision: u64,
        ctx: &mut TxContext
    ): TableVec<Item> {
        let mut i = 0;        
        let mut remaining = precision;
        let mut items = table_vec::empty(ctx);
        let names_len = names.length();
        
        while (names_len > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chance = chances[i];
            let colour_ways = colour_ways[i];

            let num_of_items = mul_div(chance, precision, PRECISION);
            let num_of_items = min(num_of_items, remaining);
            remaining = remaining - num_of_items;

            let mut k = 0;

            while (num_of_items > k) {
                items.push_back(Item {
                    is_cosmetic: false,
                    name: name.to_string(),
                    kinds,
                    colour_way: colour_ways.to_string(),
                    manufacturer: manufacturer.to_string(),
                    rarity: rarity.to_string()
                });

                k = k + 1;
            };

            i = i + 1;
        };

        items
    }

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