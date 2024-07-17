/*
* @title Act Shop
*
* @description Creates the Genesis Shop. 
* 1 - Create each items shop using the AdminCap
* 2 - Store all items in the Genesis Shop
*
* @dev Please call these functions only once.
*/
module act::act_genesis_shop {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::{
        table_vec::{Self, TableVec},
        table::{Self, Table},
    };
    use act::{
        act_admin,
        attributes,
        access_control::{Admin, AccessControl},
        act_utils::min
    };

    // === Errors ===

    // === Constants ===

    const GENISIS_AMOUNT: u64 = 6_0000;
    const COSMETIC_SET_SIZE: u64 = 8;

    // Rarities
    const COSMETICS_RARITIES: vector<vector<u8>> = vector[
        b"Ultra Rare",
        b"Mythic",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
    ];
    const PRIMARY_RARITIES: vector<vector<u8>> = vector[
        b"Ultra Rare",
        b"Mythic",
        b"Ultra Rare",
        b"Mythic",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Mythic",
    ];
    const SECONDARY_RARITIES: vector<vector<vector<u8>>> = vector[
        vector[
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Mythic",
        ],
        vector[
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
            b"Ultra Rare",
        ],
    ];
    const TERTIARY_RARITIES: vector<vector<u8>> = vector[
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Mythic",
    ];

    // Coloour ways
    const COSMETICS_COLOUR_WAY: vector<vector<u8>> = vector[
        b"Vesper",
        b"Hikari",
        b"Volt",
        b"Blood Ivory",
        b"Red Damascus",
        b"Forest",
        b"Dusk",
        b"Viceroy"
    ];
    const SECONDARY_COLOUR_WAY: vector<vector<vector<u8>>> = vector[
        vector[
            b"Vesper",
            b"Hikari",
            b"Volt",
            b"Blood Ivory",
            b"Red Damascus",
            b"Forest",
            b"Dusk",
            b"JK's"
        ],
        vector[
            b"Vesper",
            b"Hikari",
            b"Volt",
            b"Blood Ivory",
            b"Red Damascus",
            b"Forest",
            b"Dusk",
            b"Viceroy"
        ]
    ];
    const TERTIARY_COLOUR_WAY: vector<vector<u8>> = vector[
        b"K1TSUN3",
        b"Volt",
        b"Viceroy",
        b"Future",
    ];

    // Names
    const BIODOME: vector<u8> = b"Biodome";
    const SK_VIPER: vector<u8> = b"SK-Viper";
    const FANG_MK_IV: vector<u8> = b"Fang MK IV";
    const SCOUT: vector<u8> = b"Scout";
    const SPECTRE_09: vector<u8> = b"Spectre-09";
    const HELIOS: vector<u8> = b"Helios";
    const JUGGERNAUT: vector<u8> = b"Juggernaut";
    const BAHA_2000: vector<u8> = b"Baha-2000";
    const NEO_SHOGUNATE: vector<u8> = b"Neo-Shogunate";

    const TALON: vector<u8> = b"Talon";
    const RENEGADE: vector<u8> = b"Renegade";
    const RAPTOR: vector<u8> = b"Raptor";
    const TWELVE_GAUGE: vector<u8> = b"12 Guage";
    const ENFORCER: vector<u8> = b"Enforcer";
    const WHISPER_9MM: vector<u8> = b"Whisper 9mm";
    const WAKIZASHI: vector<u8> = b"Wakizashi";
    const KARAMBIT: vector<u8> = b"Karambit";
    const SCALPER: vector<u8> = b"Scalper";
    const NEO_KATANA: vector<u8> = b"Neo-Katana";

    // Manufacturers
    const ASTRAL: vector<u8> = b"Astral Exploration Technologies";
    const OBSIDIAN: vector<u8> = b"Obsidian Dynamics";
    const EXO: vector<u8> = b"ExoTech Solutions";
    const STRATO: vector<u8> = b"StratoTech Industries";
    const PHALANX: vector<u8> = b"Phalanx Defence Corp";
    const ZENITH: vector<u8> = b"Zenith Aerospace";
    const OMEGA: vector<u8> = b"Omega Tactical Systems";
    const ROOTS: vector<u8> = b"Roots Robotics";

    const FENRIR: vector<u8> = b"Fenrir Arms";
    const VOLOSLAV: vector<u8> = b"Voloslav Industrial";
    const AEGIS: vector<u8> = b"Aegis Tactical";
    const VALENTI: vector<u8> = b"Valenti";
    const LIBERTY: vector<u8> = b"Liberty Arms Corporation";
    const PRECISIONE: vector<u8> = b"Precisione Milano";
    const RYUJIN: vector<u8> = b"Ryujin Industrial";
    const KAGE: vector<u8> = b"Kage Blade Foundry";
    const ECLIPSE: vector<u8> = b"Eclipse Steel Forging LTD";
    const HYPERBLADE: vector<u8> = b"\xe3\x83\x8f\xe3\x82\xa4\xe3\x83\x91\xe3\x83\xbc\xe3\x83\x96\xe3\x83\xac\xe3\x83\xbc\xe3\x83\x89 CORPORATION";

    // Helms
    const HELM_NAMES: vector<vector<u8>> = vector[
        BIODOME,
        SK_VIPER,
        FANG_MK_IV,
        SCOUT,
        SPECTRE_09,
        HELIOS,
        JUGGERNAUT,
        BAHA_2000
    ];
    const HELM_BASE_CHANCES: vector<u64> = vector[200, 100, 150, 125, 150, 200, 200, 125];
    const HELM_CHANCES: vector<vector<u64>> = vector[
        HELM_BASE_CHANCES, 
        HELM_BASE_CHANCES, 
        HELM_BASE_CHANCES, 
        HELM_BASE_CHANCES, 
        HELM_BASE_CHANCES, 
        HELM_BASE_CHANCES, 
        HELM_BASE_CHANCES, 
        HELM_BASE_CHANCES
    ];
    const HELM_MANUFACTURERS: vector<vector<u8>> = vector[
        ASTRAL,
        OBSIDIAN,
        EXO,
        STRATO,
        PHALANX,
        ZENITH,
        OMEGA,
        ROOTS
    ];

    // Upper torso
    const UPPER_TORSO_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const UPPER_TORSO_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const UPPER_TORSO_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Chestpiece
    const CHESTPIECE_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
        HELIOS,
        NEO_SHOGUNATE
    ];
    const CHESTPIECE_CHANCES: vector<vector<u64>> = vector[
        vector[80, 20, 40, 30, 40, 80, 80, 30],
        vector[60, 10, 35, 20, 35, 60, 60, 20],
        vector[60, 10, 35, 20, 35, 60, 60, 20]
    ];
    const CHESTPIECE_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
        ZENITH,
        OBSIDIAN
    ];

    // Arm
    const ARM_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const ARM_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const ARM_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // BRACER
    const BRACER_CHANCES: vector<vector<u64>> = vector[
        vector[80, 20, 40, 30, 40, 80, 80, 30],
        vector[60, 10, 35, 20, 35, 60, 60, 20],
        vector[60, 10, 35, 20, 35, 60, 60, 20]
    ];
    const BRACER_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
        HELIOS,
        NEO_SHOGUNATE
    ];
    const BRACER_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
        ZENITH,
        OBSIDIAN
    ];

    // Glove
    const GLOVE_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const GLOVE_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const GLOVE_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];
    
    // Pauldron
    const PAULDRON_CHANCES: vector<vector<u64>> = vector[
        vector[80, 20, 40, 30, 40, 80, 80, 30],
        vector[60, 10, 35, 20, 35, 60, 60, 20],
        vector[60, 10, 35, 20 , 35, 60, 60, 20]
    ];
    const PAULDRON_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
        HELIOS,
        NEO_SHOGUNATE
    ];
    const PAULDRON_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
        ZENITH,
        OBSIDIAN
    ];

    // Legs
    const LEGS_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const LEGS_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const LEGS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Accessory
    const ACCESSORY_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const ACCESSORY_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const ACCESSORY_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];  

    // Shins
    const SHINS_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const SHINS_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const SHINS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Boots
    const BOOTS_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const BOOTS_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const BOOTS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];    


    // Primary Weapon
    const PRIMARY_CHANCES: vector<vector<u64>> = vector[
        vector[364, 260, 364, 260, 364, 364, 364, 260],
        vector[308, 220, 308, 220, 308, 308, 308, 220],
        vector[364, 260, 364, 260, 364, 364, 364, 260],
        vector[364, 260, 364, 260, 364, 364, 364, 260],
    ];
    const PRIMARY_NAMES: vector<vector<u8>> = vector[
        TALON,
        RENEGADE,
        RAPTOR,
        TWELVE_GAUGE,
    ];
    const PRIMARY_MANUFACTURERS: vector<vector<u8>> = vector[
        FENRIR,
        VOLOSLAV,
        AEGIS,
        VALENTI,
    ];  

    // Secondary Weapon
    const SECONDARY_CHANCES: vector<vector<u64>> = vector[
        vector[5, 5, 5, 4, 5, 5, 5, 2],
        vector[8, 8, 8, 8, 8, 8, 8, 8],
    ];
    const SECONDARY_NAMES: vector<vector<u8>> = vector[
        ENFORCER,
        WHISPER_9MM,
    ];
    const SECONDARY_MANUFACTURERS: vector<vector<u8>> = vector[
        LIBERTY,
        PRECISIONE
    ];  

    // Tertiary Weapon
    const TERTIARY_CHANCES: vector<u64> = vector[25, 25, 40, 10];
    const TERTIARY_NAMES: vector<vector<u8>> = vector[
        WAKIZASHI,
        KARAMBIT,
        SCALPER,
        NEO_KATANA,
    ];
    const TERTIARY_MANUFACTURERS: vector<vector<u8>> = vector[
        RYUJIN,
        KAGE,
        ECLIPSE,
        HYPERBLADE
    ];  

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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            HELM_NAMES, 
            vector[attributes::helm()],
            COSMETICS_COLOUR_WAY,
            HELM_MANUFACTURERS, 
            make_cosmetic_rarities(),
            HELM_CHANCES, 
            GENISIS_AMOUNT, 
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            UPPER_TORSO_NAMES, 
            vector[attributes::upper_torso()],
            COSMETICS_COLOUR_WAY,
            UPPER_TORSO_MANUFACTURERS, 
            make_cosmetic_rarities(),
            UPPER_TORSO_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            CHESTPIECE_NAMES, 
            vector[attributes::chestpiece()],
            COSMETICS_COLOUR_WAY,
            CHESTPIECE_MANUFACTURERS, 
            make_cosmetic_rarities(),
            CHESTPIECE_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::chestpiece(), items);
    }

    public fun add_left_arm(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,        
        ctx: &mut TxContext
    ) {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            ARM_NAMES, 
            vector[attributes::left_arm()],
            COSMETICS_COLOUR_WAY,
            ARM_MANUFACTURERS, 
            make_cosmetic_rarities(),
            ARM_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            ARM_NAMES, 
            vector[attributes::right_arm()],
            COSMETICS_COLOUR_WAY,
            ARM_MANUFACTURERS, 
            make_cosmetic_rarities(),
            ARM_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            BRACER_NAMES, 
            vector[attributes::left_bracer()],
            COSMETICS_COLOUR_WAY,
            BRACER_MANUFACTURERS, 
            make_cosmetic_rarities(),
            BRACER_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            BRACER_NAMES, 
            vector[attributes::right_bracer()],
            COSMETICS_COLOUR_WAY,
            BRACER_MANUFACTURERS, 
            make_cosmetic_rarities(),
            BRACER_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            GLOVE_NAMES, 
            vector[attributes::left_glove()],
            COSMETICS_COLOUR_WAY,
            GLOVE_MANUFACTURERS, 
            make_cosmetic_rarities(),
            GLOVE_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            GLOVE_NAMES, 
            vector[attributes::right_glove()],
            COSMETICS_COLOUR_WAY,
            GLOVE_MANUFACTURERS, 
            make_cosmetic_rarities(),
            GLOVE_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            PAULDRON_NAMES, 
            vector[attributes::left_pauldron()],
            COSMETICS_COLOUR_WAY,
            PAULDRON_MANUFACTURERS, 
            make_cosmetic_rarities(),
            PAULDRON_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            PAULDRON_NAMES, 
            vector[attributes::right_pauldron()],
            COSMETICS_COLOUR_WAY,
            PAULDRON_MANUFACTURERS, 
            make_cosmetic_rarities(),
            PAULDRON_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            LEGS_NAMES, 
            vector[attributes::legs()],
            COSMETICS_COLOUR_WAY,
            LEGS_MANUFACTURERS, 
            make_cosmetic_rarities(),
            LEGS_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::legs(), items);
    }

    public fun add_accessory(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            ACCESSORY_NAMES, 
            vector[attributes::accessory()],
            COSMETICS_COLOUR_WAY,
            ACCESSORY_MANUFACTURERS, 
            make_cosmetic_rarities(),
            ACCESSORY_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::accessory(), items);
    }

    public fun add_shins(
        genesis_shop: &mut GenesisShop,
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ) {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            SHINS_NAMES, 
            vector[attributes::shins()],
            COSMETICS_COLOUR_WAY,
            SHINS_MANUFACTURERS, 
            make_cosmetic_rarities(),
            SHINS_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            true,
            BOOTS_NAMES, 
            vector[attributes::boots()],
            COSMETICS_COLOUR_WAY,
            BOOTS_MANUFACTURERS, 
            make_cosmetic_rarities(),
            BOOTS_CHANCES,
            GENISIS_AMOUNT,
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build(
            false,
            PRIMARY_NAMES, 
            vector[attributes::primary()],
            COSMETICS_COLOUR_WAY, // same
            PRIMARY_MANUFACTURERS, 
            make_primary_rarities(),
            PRIMARY_CHANCES, 
            GENISIS_AMOUNT, 
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build_secondary(
            SECONDARY_NAMES, 
            vector[attributes::secondary()],
            SECONDARY_COLOUR_WAY,
            SECONDARY_MANUFACTURERS, 
            SECONDARY_RARITIES,
            SECONDARY_CHANCES, 
            GENISIS_AMOUNT, 
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
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = build_tertiary(
            TERTIARY_NAMES, 
            vector[attributes::tertiary()],
            TERTIARY_COLOUR_WAY,
            TERTIARY_MANUFACTURERS, 
            TERTIARY_RARITIES,
            TERTIARY_CHANCES, 
            GENISIS_AMOUNT, 
            ctx
        );

        table::add(&mut genesis_shop.items, attributes::tertiary(), items);
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

    // === Public-Package Functions ===\

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

    fun make_cosmetic_rarities(): vector<vector<vector<u8>>> {
        let mut rarities = vector[];
        let mut i = 0;

        while (COSMETIC_SET_SIZE > i) {
            rarities.push_back(COSMETICS_RARITIES);
            i = i + 1;
        };

        rarities
    }

    fun make_primary_rarities(): vector<vector<vector<u8>>> {
        let mut rarities = vector[];
        let mut i = 0;
        let len = PRIMARY_NAMES.length();

        while (len > i) {
            rarities.push_back(PRIMARY_RARITIES);
            i = i + 1;
        };

        rarities
    }

    // === Test Functions ===    
}