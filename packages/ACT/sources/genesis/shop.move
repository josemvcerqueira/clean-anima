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
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };
    use act::{
        attributes,
        assets,
        uris,
    };

    const EBuilderNotEmpty: u64 = 1;

    // === Constants ===

    const GENESIS_AMOUNT: u64 = 3000;
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
        rarity: String,
        image_url: String,
        model_url: String,
        texture_url: String,
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
        genesis_shop.items.add( attributes::helm(), table_vec::empty(ctx));

        new_builder(
            attributes::helm(),
            assets::helm_names(), 
            assets::cosmetic_colour_ways(),
            assets::helm_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::helm_chances(), 
            GENESIS_AMOUNT,
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
        genesis_shop.items.add( attributes::upper_torso(), table_vec::empty(ctx));

        new_builder(
            attributes::upper_torso(),
            assets::upper_torso_names(), 
            vector[b"Obsidian"],
            assets::upper_torso_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::upper_torso_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::chestpiece(), table_vec::empty(ctx));

        new_builder(
            attributes::chestpiece(),
            assets::chestpiece_names(), 
            assets::cosmetic_colour_ways(),
            assets::chestpiece_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::chestpiece_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add( attributes::left_arm(), table_vec::empty(ctx));

        new_builder(
            attributes::left_arm(),
            assets::arm_names(), 
            vector[b"Obsidian"],
            assets::arm_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::arm_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add( attributes::right_arm(), table_vec::empty(ctx));

        new_builder(
            attributes::right_arm(),
            assets::arm_names(), 
            vector[b"Obsidian"],
            assets::arm_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::arm_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::left_bracer(), table_vec::empty(ctx));

        new_builder(
            attributes::left_bracer(),
            assets::bracer_names(), 
            assets::cosmetic_colour_ways(),
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::right_bracer(), table_vec::empty(ctx));

        new_builder(
            attributes::right_bracer(),
            assets::bracer_names(), 
            assets::cosmetic_colour_ways(),
            assets::bracer_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::bracer_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::left_glove(), table_vec::empty(ctx));

        new_builder(
            attributes::left_glove(),
            assets::glove_names(), 
            vector[b"Obsidian"],
            assets::glove_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::glove_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::right_glove(), table_vec::empty(ctx));

        new_builder(
            attributes::right_glove(),
            assets::glove_names(), 
            vector[b"Obsidian"],
            assets::glove_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::glove_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::left_pauldron(), table_vec::empty(ctx));

        new_builder(
            attributes::left_pauldron(),
            assets::pauldrons_names(), 
            assets::cosmetic_colour_ways(),
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::right_pauldron(), table_vec::empty(ctx));

        new_builder(
            attributes::right_pauldron(),
            assets::pauldrons_names(), 
            assets::cosmetic_colour_ways(),
            assets::pauldrons_manufacturers(), 
            assets::cosmetic_rarities(),
            assets::pauldrons_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::legs(), table_vec::empty(ctx));

        new_builder(
            attributes::legs(),
            assets::legs_names(), 
            assets::legs_colour_ways(),
            assets::legs_manufacturers(), 
            assets::leg_rarities(),
            assets::legs_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add( attributes::belt(), table_vec::empty(ctx));

        new_builder(
            attributes::belt(),
            assets::belt_names(), 
            vector[b"Obsidian"],
            assets::belt_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::belt_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::shins(), table_vec::empty(ctx));

        new_builder(
            attributes::shins(),
            assets::shins_names(), 
            vector[b"Obsidian"],
            assets::shins_manufacturers(), 
            vector[b"Ultra Rare"],
            assets::shins_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::boots(), table_vec::empty(ctx));

        new_builder(
            attributes::boots(),
            assets::boots_names(), 
            assets::boots_colour_ways(),
            assets::boots_manufacturers(), 
            assets::boots_rarities(),
            assets::boots_chances(),
            GENESIS_AMOUNT,
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
        genesis_shop.items.add( attributes::primary(), table_vec::empty(ctx));

        new_builder(
            attributes::primary(),
            assets::primary_names(), 
            assets::primary_colour_ways(), // same
            assets::primary_manufacturers(), 
            assets::primary_rarities(),
            assets::primary_chances(), 
            GENESIS_AMOUNT,
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
        genesis_shop.items.add(attributes::secondary(), table_vec::empty(ctx));

        new_builder(
            attributes::secondary(),
            assets::secondary_names(), 
            assets::secondary_colour_ways(),
            assets::secondary_manufacturers(), 
            assets::secondary_rarities(),
            assets::secondary_chances(), 
            GENESIS_AMOUNT,
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
        genesis_shop.items.add( attributes::tertiary(), table_vec::empty(ctx));
        
        new_builder(
            attributes::tertiary(),
            assets::tertiary_names(), 
            assets::tertiary_colour_ways(),
            assets::tertiary_manufacturers(), 
            assets::tertiary_rarities(),
            assets::tertiary_chances(), 
            GENESIS_AMOUNT,
            ctx
        )
    }

    public fun keep(builder: Builder, ctx: &mut TxContext) {
        transfer::transfer(builder, ctx.sender());
    }

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

        if (quantity != 0) *quantity = *quantity - 1;

        let mut rarity = b"";
        let mut colour = b"";
        if (builder.equipment == attributes::tertiary()) {
            let last_idx = builder.rarities.length() - 1;
            rarity = builder.rarities[last_idx];
            colour = builder.colour_ways[last_idx];
        } else {
            rarity = builder.rarities[len];
            colour = builder.colour_ways[len];
        };

        let (image_url, model_url, texture_url) = if (builder.equipment == attributes::primary() || builder.equipment == attributes::secondary() || builder.equipment == attributes::tertiary()) {
            uris::get_weapon(name)
        } else if (builder.equipment == attributes::helm()) {
            uris::get_helm(name, colour)
        } else if (builder.equipment == attributes::chestpiece()) {
            uris::get_chestpiece(name, colour)
        } else if (builder.equipment == attributes::left_pauldron()) {
            uris::get_left_pauldron(name, colour)
        } else if (builder.equipment == attributes::right_pauldron()) {
            uris::get_right_pauldron(name, colour)
        } else if (builder.equipment == attributes::left_bracer()) {
            uris::get_left_bracer(name, colour)
        } else if (builder.equipment == attributes::right_bracer()) {
            uris::get_right_bracer(name, colour)
        } else { uris::get_other(name, builder.equipment.into_bytes(), colour) };

        let item = Item {
            name: name.to_string(),
            equipment: builder.equipment,
            colour_way: colour.to_string(),
            manufacturer: manufacturer.to_string(),
            rarity: rarity.to_string(),
            image_url: image_url.to_string(),
            model_url: model_url.to_string(),
            texture_url: texture_url.to_string()
        };

        genesis_shop.items.borrow_mut(builder.equipment).push_back(item);

        if (*quantity == 0) {
            quantities.pop_back();

            if (quantities.length() == 0) {
                builder.quantities.pop_back();
                builder.manufacturers.pop_back();
                builder.names.pop_back();
                
                if (builder.equipment == attributes::tertiary()) {
                    builder.rarities.pop_back();
                    builder.colour_ways.pop_back();
                }
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

    public(package) fun unpack(item: Item): (String, String, String, String, String, String, String, String) {
        let Item { name, equipment, colour_way, manufacturer, rarity, image_url, model_url, texture_url } = item;
        (name, equipment, colour_way, manufacturer, rarity, image_url, model_url, texture_url)
    }

    // === Private Functions ===

    fun new_builder(
        equipment: String,
        names: vector<vector<u8>>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
        chances: vector<vector<u64>>,
        total_amount: u64,
        ctx: &mut TxContext
    ): Builder {
        Builder { 
            id: object::new(ctx), 
            equipment, 
            names, 
            colour_ways, 
            manufacturers, 
            rarities, 
            quantities: chances.map!(|x| x.map!(|chance| mul_div(chance, total_amount, PRECISION))), 
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

    #[test_only]
    fun mul_div_up(x: u64, y: u64, z: u64): u64 {
        let r = mul_div(x, y, z);
        r + if ((x * y) % z > 0) 1 else 0
    }

    #[test_only]
    public fun new_builder_for_testing(
        self: &mut GenesisShop,
        equipment: String,
        names: vector<vector<u8>>,
        colour_ways: vector<vector<u8>>,
        manufacturers: vector<vector<u8>>,
        rarities: vector<vector<u8>>,
        chances: vector<vector<u64>>,
        total_amount: u64,
        ctx: &mut TxContext
    ): Builder  {
        self.items.add(equipment, table_vec::empty(ctx));
        Builder { 
            id: object::new(ctx), 
            equipment, 
            names, 
            colour_ways, 
            manufacturers, 
            rarities, 
            quantities: chances.map!(|x| x.map!(|chance| mul_div_up(chance, total_amount, PRECISION))), 
        }
    }
}