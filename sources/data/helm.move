/*
* @title Act Avatar Helm
*
* @descriptino It shares the HelmShop which contains all possible helms. 
* To randomly generate one, please find the length of the TableVec then randomize the number between |0 - length| and call `borrow`.
*/
module act::act_avatar_helm {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::table_vec::{Self, TableVec};
    use act::{
        act_colour_way,
        act_utils::min
    };

    // === Errors ===

    // === Constants ===

    const TOTAL: u64 = 6000;
    const PRECISION: u64 = 10_000;
    const NAMES: vector<vector<u8>> = vector[
        b"Biodome",
        b"Venom",
        b"Fang MK IV",
        b"Scout",
        b"Spectre-09",
        b"Helios",
        b"Juggernaut",
        b"Baha-2000"
    ];
    const CHANCES: vector<u64> = vector[200, 100, 150, 125, 150, 200, 200, 125];

    // === Structs ===

    public struct HelmShop has key {
        id: UID,
        inner: TableVec<Helm>
    }

    public struct Helm has store {
        name: String,
        colour_way: String
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(ctx: &mut TxContext) {
        let shop = HelmShop {
            id: object::new(ctx),
            inner: get(ctx)
        };

        transfer::share_object(shop);
    }

    // === Public-View Functions ===

    public fun borrow(self: &HelmShop, i: u64): &Helm {
        self.borrow(i)
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    fun get(ctx: &mut TxContext): TableVec<Helm> {
        let mut i = 0;
        let names = NAMES;
        let chances = CHANCES;
        let colour_ways = act_colour_way::get();
        
        let chances_len = chances.length();
        let names_len = names.length();
        let mut remaining = TOTAL;
        
        let mut helms = table_vec::empty(ctx);

        while (names_len > i) {

            let name = names[i];

            let mut j = 0;

            while (chances_len > j) {

                let num_of_helmets = min(chances[j] * TOTAL / PRECISION, remaining);
                remaining = remaining - num_of_helmets;

                let mut k = 0;

                while (num_of_helmets > k) {
                    helms.push_back(Helm {
                        name: utf8(name),
                        colour_way: utf8(colour_ways[j])
                    });

                    k = k + 1;
                };

                j = j + 1;
            };

            i = i + 1;
        };

        helms
    }

    // === Test Functions ===    
}