/*
* @title Act Shop
*
* @description Creates Shops for Act Items.
*
* @dev Please call these functions only once.
*/
module act::act_shop {
    // === Imports ===

    use sui::table_vec::TableVec;
    use act::{act_factory::{Self, Item}, attributes};

    // === Errors ===

    // === Constants ===

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
    const SECONDARY_COLOUR_WAY: vector<vector<u8>> = vector[
        b"Vesper",
        b"Hikari",
        b"Volt",
        b"Blood Ivory",
        b"Red Damascus",
        b"Forest",
        b"Dusk",
        b"JK's"
    ];
    const TERTIARY_COLOUR_WAY: vector<vector<u8>> = vector[
        b"K1TSUN3",
        b"Volt",
        b"Viceroy",
        b"Future",
    ];

    // Names
    const BIODOME: vector<u8> = b"Biodome";
    const VENOM: vector<u8> = b"Venom";
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
    const HELM_PRECISION: u64 = 10_000;
    const HELM_NAMES: vector<vector<u8>> = vector[
        BIODOME,
        VENOM,
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

    // Chestpiece
    const CHESTPIECE_PRECISION: u64 = 1_000;
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

    // Upper torso
    const UPPER_TORSO_PRECISION: u64 = 1_000;
    const UPPER_TORSO_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const UPPER_TORSO_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const UPPER_TORSO_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Pauldron
    const PAULDRON_PRECISION: u64 = 1_000;
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

    // Arm
    const ARM_PRECISION: u64 = 1_000;
    const ARM_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const ARM_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const ARM_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Glove
    const GLOVE_PRECISION: u64 = 1_000;
    const GLOVE_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const GLOVE_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const GLOVE_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // BRACER
    const BRACER_PRECISION: u64 = 1_000;
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

    // Legs
    const LEGS_PRECISION: u64 = 1_000;
    const LEGS_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const LEGS_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const LEGS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Shins
    const SHINS_PRECISION: u64 = 1_000;
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
    const BOOTS_PRECISION: u64 = 1_000;
    const BOOTS_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const BOOTS_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const BOOTS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];    

    // Accesssory
    const ACCESSORY_PRECISION: u64 = 1_000;
    const ACCESSORY_CHANCES: vector<vector<u64>> = vector[
        vector[200, 50, 95, 80, 95, 200, 200, 80]
    ];
    const ACCESSORY_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const ACCESSORY_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];  


    // Primary Weapon
    const PRIMARY_PRECISION: u64 = 10_000;
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
    const SECONDARY_PRECISION: u64 = 100;
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
    const TERTIARY_PRECISION: u64 = 100;
    const TERTIARY_CHANCES: vector<vector<u64>> = vector[
        vector[25],
        vector[25],
        vector[40],
        vector[10],
    ];
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

    public struct Helm has drop {}
    public struct Chestpiece has drop {}
    public struct UpperTorso has drop {}
    public struct Pauldron has drop {}
    public struct Arm has drop {}
    public struct Glove has drop {}
    public struct Bracer has drop {}
    public struct Legs has drop {}
    public struct Shins has drop {}
    public struct Boots has drop {}
    public struct Accessory has drop {}

    public struct Primary has drop {}
    public struct Secondary has drop {}
    public struct Tertiary has drop {}

    public struct Shop<phantom Item, Data: store> has key {
        id: UID,
        items: Data
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun new_helm_shop(ctx: &mut TxContext) {
        let items = act_factory::build_large_set(
            HELM_NAMES, 
            attributes::helm(),
            COSMETICS_COLOUR_WAY,
            HELM_MANUFACTURERS, 
            COSMETICS_RARITIES,
            HELM_CHANCES, 
            HELM_PRECISION, 
        );

        transfer::share_object(
            Shop<Helm, vector<vector<Item>>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_chestpiece_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            CHESTPIECE_NAMES, 
            attributes::chestpiece(),
            COSMETICS_COLOUR_WAY,
            CHESTPIECE_MANUFACTURERS, 
            COSMETICS_RARITIES,
            CHESTPIECE_CHANCES,
            CHESTPIECE_PRECISION
        );

        transfer::share_object(
            Shop<Chestpiece, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_upper_torso_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            UPPER_TORSO_NAMES, 
            attributes::upper_torso(),
            COSMETICS_COLOUR_WAY,
            UPPER_TORSO_MANUFACTURERS, 
            COSMETICS_RARITIES,
            UPPER_TORSO_CHANCES,
            UPPER_TORSO_PRECISION
        );

        transfer::share_object(
            Shop<UpperTorso, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_pauldron_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            PAULDRON_NAMES, 
            attributes::pauldron(),
            COSMETICS_COLOUR_WAY,
            PAULDRON_MANUFACTURERS, 
            COSMETICS_RARITIES,
            PAULDRON_CHANCES,
            PAULDRON_PRECISION
        );

        transfer::share_object(
            Shop<Pauldron, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_arm_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            ARM_NAMES, 
            attributes::arm(),
            COSMETICS_COLOUR_WAY,
            ARM_MANUFACTURERS, 
            COSMETICS_RARITIES,
            ARM_CHANCES,
            ARM_PRECISION
        );

        transfer::share_object(
            Shop<Arm, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_glove_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            GLOVE_NAMES, 
            attributes::glove(),
            COSMETICS_COLOUR_WAY,
            GLOVE_MANUFACTURERS, 
            COSMETICS_RARITIES,
            GLOVE_CHANCES,
            GLOVE_PRECISION
        );

        transfer::share_object(
            Shop<Glove, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_bracer_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            BRACER_NAMES, 
            attributes::bracer(),
            COSMETICS_COLOUR_WAY,
            BRACER_MANUFACTURERS, 
            COSMETICS_RARITIES,
            BRACER_CHANCES,
            BRACER_PRECISION
        );

        transfer::share_object(
            Shop<Bracer, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_legs_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            LEGS_NAMES, 
            attributes::legs(),
            COSMETICS_COLOUR_WAY,
            LEGS_MANUFACTURERS, 
            COSMETICS_RARITIES,
            LEGS_CHANCES,
            LEGS_PRECISION
        );

        transfer::share_object(
            Shop<Legs, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_shins_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            SHINS_NAMES, 
            attributes::shins(),
            COSMETICS_COLOUR_WAY,
            SHINS_MANUFACTURERS, 
            COSMETICS_RARITIES,
            SHINS_CHANCES,
            SHINS_PRECISION
        );

        transfer::share_object(
            Shop<Shins, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_boots_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            BOOTS_NAMES, 
            attributes::boots(),
            COSMETICS_COLOUR_WAY,
            BOOTS_MANUFACTURERS, 
            COSMETICS_RARITIES,
            BOOTS_CHANCES,
            BOOTS_PRECISION
        );

        transfer::share_object(
            Shop<Boots, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_accessory_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            ACCESSORY_NAMES, 
            attributes::accessory(),
            COSMETICS_COLOUR_WAY,
            ACCESSORY_MANUFACTURERS, 
            COSMETICS_RARITIES,
            ACCESSORY_CHANCES,
            ACCESSORY_PRECISION
        );

        transfer::share_object(
            Shop<Accessory, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_primary_shop(ctx: &mut TxContext) {
        let items = act_factory::build_large_set(
            PRIMARY_NAMES, 
            attributes::primary(),
            COSMETICS_COLOUR_WAY, // same
            PRIMARY_MANUFACTURERS, 
            PRIMARY_RARITIES,
            PRIMARY_CHANCES, 
            PRIMARY_PRECISION, 
        );

        transfer::share_object(
            Shop<Primary, vector<vector<Item>>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_secondary_shop(ctx: &mut TxContext) {
        let items = act_factory::build_secondary(
            SECONDARY_NAMES, 
            COSMETICS_COLOUR_WAY,
            SECONDARY_MANUFACTURERS, 
            SECONDARY_RARITIES,
            SECONDARY_CHANCES, 
            SECONDARY_PRECISION, 
        );

        transfer::share_object(
            Shop<Secondary, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    public fun new_tertiary_shop(ctx: &mut TxContext) {
        let items = act_factory::build_set(
            TERTIARY_NAMES, 
            attributes::tertiary(),
            COSMETICS_COLOUR_WAY,
            TERTIARY_MANUFACTURERS, 
            TERTIARY_RARITIES,
            TERTIARY_CHANCES, 
            TERTIARY_PRECISION, 
        );

        transfer::share_object(
            Shop<Tertiary, vector<Item>> {
                id: object::new(ctx),
                items
            }
        );
    }

    // === Public-View Functions ===

    public fun items<Item, Data: store>(self: &Shop<Item, Data>): &Data {
        &self.items
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===    
}