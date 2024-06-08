/*
* @title Act Factory
*
* @description It creates TableVec/vector with the correct number of items based on their percentages.
*/
module act::act_factory {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::table_vec::{Self, TableVec};
    use act::{
        act_utils::min
    };

    // === Errors ===

    const ESetIsTooLarge: u64 = 0;

    // === Constants ===

    const MAX_VEC_SIZE: u64 = 1000;

    // === Structs ===

    public struct Item has store {
        name: String,
        colour_way: String,
        manufacturer: String,
        rarity: String
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun build_set(
        names: vector<vector<u8>>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
        chances: vector<vector<u64>>,
        precision: u64
    ): vector<Item> {
        assert!(MAX_VEC_SIZE >= precision, ESetIsTooLarge);

        let mut i = 0;        
        let mut remaining = precision;
        let mut items = vector[];
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
                        name: utf8(name),
                        colour_way: utf8(colour_ways[j]),
                        manufacturer: utf8(manufacturer),
                        rarity: utf8(rarity)
                    });

                    k = k + 1;
                };

                j = j + 1;
            };

            i = i + 1;
        };

        items
    }

    public fun build_large_set(
        names: vector<vector<u8>>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
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
                        name: utf8(name),
                        colour_way: utf8(colour_ways[j]),
                        manufacturer: utf8(manufacturer),
                        rarity: utf8(rarity)
                    });

                    k = k + 1;
                };

                j = j + 1;
            };

            i = i + 1;
        };

        items
    }

    // this is the only equipment where rarity distribution differs between the items
    public fun build_secondary(
        names: vector<vector<u8>>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<vector<u8>>>,
        chances: vector<vector<u64>>,
        precision: u64
    ): vector<Item> {
        assert!(MAX_VEC_SIZE >= precision, ESetIsTooLarge);

        let mut i = 0;        
        let mut remaining = precision;
        let mut items = vector[];
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
                        name: utf8(name),
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

    // === Public-View Functions ===

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

    // === Private Functions ===

    // === Test Functions ===    
}