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
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
        // never modified because used for each name 
        quantities: vector<vector<u64>>
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
            assets::cosmetic_colour_ways(),
            assets::helm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::helm_chances(), 
            ctx
        )
    }

    // public fun add_upper_torso(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin, 
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::upper_torso(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::upper_torso(),
    //         assets::upper_torso_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::upper_torso_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::upper_torso_chances(),
    //         ctx
    //     )
    // }

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
            assets::cosmetic_colour_ways(),
            assets::chestpiece_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::chestpiece_chances(),
            ctx
        )
    }

    // // backpiece has no nft atm

    // public fun add_left_arm(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,        
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::left_arm(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::left_arm(),
    //         assets::arm_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::arm_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::arm_chances(),
    //         ctx
    //     )
    // }

    // public fun add_right_arm(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,        
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::right_arm(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::right_arm(),
    //         assets::arm_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::arm_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::arm_chances(),
    //         ctx
    //     )
    // }

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
            assets::cosmetic_colour_ways(),
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
            assets::cosmetic_colour_ways(),
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            ctx
        )
    }

    // public fun add_left_glove(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::left_glove(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::left_glove(),
    //         assets::glove_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::glove_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::glove_chances(),
    //         ctx
    //     )
    // }

    // public fun add_right_glove(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::right_glove(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::right_glove(),
    //         assets::glove_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::glove_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::glove_chances(),
    //         ctx
    //     )
    // }

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
            assets::cosmetic_colour_ways(),
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
            assets::cosmetic_colour_ways(),
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            ctx
        )
    }

    // public fun add_legs(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::legs(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::legs(),
    //         assets::legs_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::legs_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::legs_chances(),
    //         ctx
    //     )
    // }

    // public fun add_belt(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::belt(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::belt(),
    //         assets::belt_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::belt_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::belt_chances(),
    //         ctx
    //     )
    // }

    // public fun add_shins(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::shins(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::shins(),
    //         assets::shins_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::shins_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::shins_chances(),
    //         ctx
    //     )
    // }

    // public fun add_boots(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::boots(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::boots(),
    //         assets::boots_names(), 
    //         vector[assets::cosmetic_colour_ways()],
    //         assets::boots_manufacturers(), 
    //         assets::cosmetic_rarities(),
    //         assets::boots_chances(),
    //         ctx
    //     )
    // }

    // public fun add_primary(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::primary(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::primary(),
    //         assets::primary_names(), 
    //         vector[assets::cosmetic_colour_ways()], // same
    //         assets::primary_manufacturers(), 
    //         assets::primary_rarities(),
    //         assets::primary_chances(), 
    //         ctx
    //     )
    // }

    // public fun add_secondary(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::secondary(), table_vec::empty(ctx));

    //     new_builder(
    //         attributes::secondary(),
    //         assets::secondary_names(), 
    //         assets::secondary_colour_ways(),
    //         assets::secondary_manufacturers(), 
    //         assets::secondary_rarities(),
    //         assets::secondary_chances(), 
    //         ctx
    //     )
    // }

    // public fun add_tertiary(
    //     genesis_shop: &mut GenesisShop,
    //     access_control: &AccessControl, 
    //     admin: &Admin,  
    //     ctx: &mut TxContext
    // ): Builder {
    //     admin::assert_genesis_minter_role(access_control, admin);
    //     table::add(&mut genesis_shop.items, attributes::tertiary(), table_vec::empty(ctx));
        
    //     new_builder(
    //         attributes::tertiary(),
    //         assets::tertiary_names(), 
    //         vector[assets::tertiary_colour_ways()],
    //         assets::tertiary_manufacturers(), 
    //         vector[assets::tertiary_rarities()],
    //         vector[assets::tertiary_chances()], 
    //         ctx
    //     )
    // }

    public fun keep(builder: Builder, ctx: &mut TxContext) {
        transfer::transfer(builder, ctx.sender());
    }

    // public struct Builder has key {
    //     id: UID,
    //     equipment: String,
    //     // each of those are popped when chances_len reach 0
    //     names: vector<vector<u8>>,
    //     colour_ways: vector<vector<vector<u8>>>,
    //     manufacturers: vector<vector<u8>>,
    //     rarities:vector<vector<vector<u8>>>,
    //     // never modified because used for each name 
    //     quantities: vector<vector<u64>>
    // }

    public fun new_item(
        genesis_shop: &mut GenesisShop,
        builder: &mut Builder,
    ) {

        let quantities_len = builder.quantities.length();

        if (quantities_len == 0) return;

        let quantities = &mut builder.quantities[quantities_len -1];
        let name = builder.names[quantities_len -1];
        let manufacturer = builder.manufacturers[quantities_len -1];

        let len = quantities.length() -1;

        let quantity = &mut quantities[len];
        *quantity = *quantity - 1;

        let rarity = builder.rarities[len];
        let colour = builder.colour_ways[len];

        let item = Item {
            name: name.to_string(),
            equipment: builder.equipment,
            colour_way: colour.to_string(),
            manufacturer: manufacturer.to_string(),
            rarity: rarity.to_string()
        };

        genesis_shop.items.borrow_mut(builder.equipment).push_back(item);

        if (*quantity == 0) {
            quantities.pop_back();

            if (quantities.length() == 0) {
                 builder.quantities.pop_back();
                 builder.manufacturers.pop_back();
                 builder.names.pop_back();
            }
        };

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
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
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
            quantities: chances.map!(|x| x.map!(|chance| mul_div(chance, GENESIS_AMOUNT, PRECISION))), 
        }
    }

    fun mul_div(x: u64, y: u64, z: u64): u64 {
        ((x as u256) * (y as u256) / (z as u256) as u64)
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