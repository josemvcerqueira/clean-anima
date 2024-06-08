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
    const SET_SIZE: u64 = 8;

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

        while (SET_SIZE > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chances = chances[i];

            let mut j = 0;

            while (SET_SIZE > j) {

                let num_of_helmets = min(chances[j], remaining);
                remaining = remaining - num_of_helmets;

                let mut k = 0;

                while (num_of_helmets > k) {
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

        while (SET_SIZE > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chances = chances[i];
            
            let mut j = 0;

            while (SET_SIZE > j) {

                let num_of_helmets = min(chances[j], remaining);
                remaining = remaining - num_of_helmets;

                let mut k = 0;

                while (num_of_helmets > k) {
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

        while (SET_SIZE > i) {

            let name = names[i];
            let manufacturer = manufacturers[i];
            let rarity = rarities[i];
            let chances = chances[i];

            let mut j = 0;

            while (SET_SIZE > j) {

                let num_of_helmets = min(chances[j], remaining);
                remaining = remaining - num_of_helmets;

                let mut k = 0;

                while (num_of_helmets > k) {
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

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===    
}