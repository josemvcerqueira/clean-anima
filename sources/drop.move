/// Sale stores all data relative to the mint, including all Avatar with equipments data
/// Equipment data is stored in attributes in Drop, which corresponds to Avatar.attributes
/// start_times and drops_left and passes are vector corresponding to the different phases
/// passes are the whitelist object that will be airdropped to the users and destroyed upon mint

module act::act_drop {
    use std::{
        string::String,
        type_name::TypeName,
    };
    use sui::{
        table_vec::{Self, TableVec},
        vec_map::{Self, VecMap},
    };

    // === Errors ===

    const ETooMany: u64 = 0;

    // === Structs ===

    public struct Sale has key {
        id: UID,
        active: bool,
        start_times: vector<u64>,
        prices: vector<u64>,
        passes: vector<TypeName>,
        drops_left: u64,
        drops: TableVec<Drop>,
    }

    // need to generate all info here before the sale
    public struct Drop has store {
        image_url: String, // avatar info
        image_hash: String, // avatar info
        model_url: String, // avatar info
        attributes: VecMap<String, String> // each type/slot must be associated with (name, colour_way)
    }

    // === Public mutative Functions ===

    fun init(ctx: &mut TxContext) {
        transfer::share_object(Sale {
            id: object::new(ctx),
            active: false,
            start_times: vector::empty(),
            prices: vector::empty(),
            passes: vector::empty(),
            drops_left: 6000,
            drops: table_vec::empty(ctx),
        });
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

    // loop over it in ptb
    // for each drop we need to generate 1 random cosmetic of each 16 type (name, colour_way)
    // and 1 random weapon of each 3 slots (name, colour_way)
    public fun push_drop(
        sale: &mut Sale, 
        image_url: String, 
        image_hash: String, 
        model_url: String,
    ) {
        assert!(sale.drops.length() + 1 <= sale.drops_left, ETooMany);
    }

    // there should be 2 mint functions: with_avatar and without
    // upon mint the avatar is created if applicable and all equipments as well
    // then they need to be equipped with avatar::equip_minted_*
}

