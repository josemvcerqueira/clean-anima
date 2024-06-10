/*
* @title Act Factory
*
* @description It creates TableVec/vector with the correct number of items based on their percentages.
*/
module act::act_factory {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::table_vec::{Self, TableVec};
    use act::act_utils::min;

    // === Errors ===

    // === Constants ===

    // === Structs ===

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

    public fun build(
        is_cosmetic: bool,
        names: vector<vector<u8>>,
        kinds: vector<String>,
        colour_ways: vector<vector<u8>>,
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
        let chances_len = chances.length();
        
        while (names_len > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chances = chances[i];

            let mut j = 0;

            while (chances_len > j) {

                let num_of_items = min(chances[j], remaining);
                remaining = remaining - num_of_items;

                let mut k = 0;

                while (num_of_items > k) {
                    items.push_back(Item {
                        is_cosmetic,
                        name: utf8(name),
                        kinds,
                        colour_way: utf8(colour_ways[j]),
                        manufacturer: utf8(manufacturer),
                        rarity: utf8(rarity[j])
                    });

                    k = k + 1;
                };

                j = j + 1;
            };

            i = i + 1;
        };

        items
    }

    public fun build_secondary(
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
        let chances_len = chances.length();
        
        while (names_len > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chances = chances[i];
            let colour_ways = colour_ways[i];

            let mut j = 0;

            while (chances_len > j) {

                let num_of_items = min(chances[j], remaining);
                remaining = remaining - num_of_items;

                let mut k = 0;

                while (num_of_items > k) {
                    items.push_back(Item {
                        is_cosmetic: false,
                        name: utf8(name),
                        kinds,
                        colour_way: utf8(colour_ways[j]),
                        manufacturer: utf8(manufacturer),
                        rarity: utf8(rarity[j])
                    });

                    k = k + 1;
                };

                j = j + 1;
            };

            i = i + 1;
        };

        items
    }

    public fun build_tertiary(
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

            let num_of_items = min(chance, remaining);
            remaining = remaining - num_of_items;

            let mut k = 0;

            while (num_of_items > k) {
                items.push_back(Item {
                    is_cosmetic: false,
                    name: utf8(name),
                    kinds,
                    colour_way: utf8(colour_ways),
                    manufacturer: utf8(manufacturer),
                    rarity: utf8(rarity)
                });

                k = k + 1;
            };

            i = i + 1;
        };

        items
    }

    // === Public-View Functions ===

    public fun kinds(self: &Item): vector<String> {
        self.kinds
    }

    public fun name(self: &Item): String {
        self.name
    }

    public fun colour_way(self: &Item): String {
        self.colour_way
    }

    public fun manufacturer(self: &Item): String {
        self.manufacturer
    }

    public fun rarity(self: &Item): String {
        self.rarity
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun unpack(item: Item): (String, vector<String>, String, String, String, bool) {
        let Item { name, kinds, colour_way, manufacturer, rarity, is_cosmetic } = item;
        (name, kinds, colour_way, manufacturer, rarity, is_cosmetic)
    }

    // === Private Functions ===

    // === Test Functions ===    
}