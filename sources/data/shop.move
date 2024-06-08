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
    use act::act_factory::{Self, Item};
  

    // === Errors ===

    // === Constants ===

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

    // Manufacturers
    const ASTRAL: vector<u8> = b"Astral Exploration Technologies";
    const OBSIDIAN: vector<u8> = b"Obsidian Dynamics";
    const EXO: vector<u8> = b"ExoTech Solutions";
    const STRATO: vector<u8> = b"StratoTech Industries";
    const PHALANX: vector<u8> = b"Phalanx Defence Corp";
    const ZENITH: vector<u8> = b"Zenith Aerospace";
    const OMEGA: vector<u8> = b"Omega Tactical Systems";
    const ROOTS: vector<u8> = b"Roots Robotics";



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
        vector[60, 10, 35, 20 , 25, 60, 60, 20]
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

    public struct Shop<phantom Item, Data: store> has key {
        id: UID,
        inner: Data
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun new_helm_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_large_set(
            HELM_NAMES, 
            HELM_MANUFACTURERS, 
            HELM_CHANCES, 
            HELM_PRECISION, 
            ctx
        );

        transfer::share_object(
            Shop<Helm, TableVec<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_chestpiece_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            CHESTPIECE_NAMES, 
            CHESTPIECE_MANUFACTURERS, 
            CHESTPIECE_CHANCES,
            CHESTPIECE_PRECISION
        );

        transfer::share_object(
            Shop<Chestpiece, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_upper_torso_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            UPPER_TORSO_NAMES, 
            UPPER_TORSO_MANUFACTURERS, 
            UPPER_TORSO_CHANCES,
            UPPER_TORSO_PRECISION
        );

        transfer::share_object(
            Shop<UpperTorso, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_pauldron_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            PAULDRON_NAMES, 
            PAULDRON_MANUFACTURERS, 
            PAULDRON_CHANCES,
            PAULDRON_PRECISION
        );

        transfer::share_object(
            Shop<Pauldron, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_arm_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            ARM_NAMES, 
            ARM_MANUFACTURERS, 
            ARM_CHANCES,
            ARM_PRECISION
        );

        transfer::share_object(
            Shop<Arm, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_glove_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            GLOVE_NAMES, 
            GLOVE_MANUFACTURERS, 
            GLOVE_CHANCES,
            GLOVE_PRECISION
        );

        transfer::share_object(
            Shop<Glove, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_bracer_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            BRACER_NAMES, 
            BRACER_MANUFACTURERS, 
            BRACER_CHANCES,
            BRACER_PRECISION
        );

        transfer::share_object(
            Shop<Bracer, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_legs_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            LEGS_NAMES, 
            LEGS_MANUFACTURERS, 
            LEGS_CHANCES,
            LEGS_PRECISION
        );

        transfer::share_object(
            Shop<Legs, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_shins_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            SHINS_NAMES, 
            SHINS_MANUFACTURERS, 
            SHINS_CHANCES,
            SHINS_PRECISION
        );

        transfer::share_object(
            Shop<Shins, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_boots_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            BOOTS_NAMES, 
            BOOTS_MANUFACTURERS, 
            BOOTS_CHANCES,
            BOOTS_PRECISION
        );

        transfer::share_object(
            Shop<Boots, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    public fun new_accessory_shop(ctx: &mut TxContext) {
        let inner = act_factory::build_set(
            ACCESSORY_NAMES, 
            ACCESSORY_MANUFACTURERS, 
            ACCESSORY_CHANCES,
            ACCESSORY_PRECISION
        );

        transfer::share_object(
            Shop<Accessory, vector<Item>> {
                id: object::new(ctx),
                inner
            }
        );
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===    
}