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
        table_vec::TableVec,
        dynamic_field as df
    };
    use act::{
        act_admin,
        attributes,
        act_factory::{Self, Item as FactoryItem}, 
        access_control::{Admin, AccessControl}
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

    // Accesssory
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

    public struct Shop<phantom Kind> has key, store {
        id: UID,
        name: String,
        set:  bool,
        items: TableVec<FactoryItem>
    }

    public struct Item has store {
        set: bool,
        items: TableVec<FactoryItem>
    }

    public struct GenesisShop has key {
        id: UID
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun new_helm_shop(
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ): Shop<Helm> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            HELM_NAMES, 
            vector[utf8(attributes::helm())],
            COSMETICS_COLOUR_WAY,
            HELM_MANUFACTURERS, 
            make_cosmetic_rarities(),
            HELM_CHANCES, 
            GENISIS_AMOUNT, 
            ctx
        );

        Shop<Helm> {
            id: object::new(ctx),
            name: utf8(attributes::helm()),
            set: false,
            items
        }
    }

    public fun new_chestpiece_shop(
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ): Shop<Chestpiece> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            CHESTPIECE_NAMES, 
            vector[utf8(attributes::chestpiece())],
            COSMETICS_COLOUR_WAY,
            CHESTPIECE_MANUFACTURERS, 
            make_cosmetic_rarities(),
            CHESTPIECE_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Chestpiece> {
            id: object::new(ctx),
            name: utf8(attributes::chestpiece()),
            set: false,
            items
        }
    }

    public fun new_upper_torso_shop(
        access_control: &AccessControl, 
        admin: &Admin, 
        ctx: &mut TxContext
    ): Shop<UpperTorso> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            UPPER_TORSO_NAMES, 
            vector[utf8(attributes::upper_torso())],
            COSMETICS_COLOUR_WAY,
            UPPER_TORSO_MANUFACTURERS, 
            make_cosmetic_rarities(),
            UPPER_TORSO_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<UpperTorso> {
            id: object::new(ctx),
            name: utf8(attributes::upper_torso()),
            set: false,
            items
        }
    }

    public fun new_pauldron_shop(
        access_control: &AccessControl, 
        admin: &Admin,
        ctx: &mut TxContext
    ): Shop<Pauldron> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            PAULDRON_NAMES, 
            vector[utf8(attributes::right_pauldron()), utf8(attributes::left_pauldron())],
            COSMETICS_COLOUR_WAY,
            PAULDRON_MANUFACTURERS, 
            make_cosmetic_rarities(),
            PAULDRON_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Pauldron> {
            id: object::new(ctx),
            name: utf8(attributes::pauldron()),
            set: true,
            items
        }
    }

    public fun new_arm_shop(
        access_control: &AccessControl, 
        admin: &Admin,        
        ctx: &mut TxContext
    ): Shop<Arm> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            ARM_NAMES, 
            vector[utf8(attributes::right_pauldron()), utf8(attributes::left_pauldron())],
            COSMETICS_COLOUR_WAY,
            ARM_MANUFACTURERS, 
            make_cosmetic_rarities(),
            ARM_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Arm> {
            id: object::new(ctx),
            name: utf8(attributes::arm()),
            set: true,
            items
        }
    }

    public fun new_glove_shop(
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Shop<Glove> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            GLOVE_NAMES, 
            vector[utf8(attributes::right_glove()), utf8(attributes::left_glove())],
            COSMETICS_COLOUR_WAY,
            GLOVE_MANUFACTURERS, 
            make_cosmetic_rarities(),
            GLOVE_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Glove> {
            id: object::new(ctx),
            name: utf8(attributes::glove()),
            set: true,
            items
        }
    }

    public fun new_bracer_shop(
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Shop<Bracer> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            BRACER_NAMES, 
            vector[utf8(attributes::right_bracer()), utf8(attributes::left_bracer())],
            COSMETICS_COLOUR_WAY,
            BRACER_MANUFACTURERS, 
            make_cosmetic_rarities(),
            BRACER_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Bracer> {
            id: object::new(ctx),
            name: utf8(attributes::bracer()),
            set: true,
            items
        }
    }

    public fun new_legs_shop(
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Shop<Legs> {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            LEGS_NAMES, 
            vector[utf8(attributes::legs())],
            COSMETICS_COLOUR_WAY,
            LEGS_MANUFACTURERS, 
            make_cosmetic_rarities(),
            LEGS_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Legs> {
            id: object::new(ctx),
            name: utf8(attributes::legs()),
            set: false,
            items
        }
    }

    public fun new_shins_shop(
        access_control: &AccessControl, 
        admin: &Admin,  
        ctx: &mut TxContext
    ): Shop<Shins>  {
        act_admin::assert_genesis_minter_role(access_control, admin);
        let items = act_factory::build(
            true,
            SHINS_NAMES, 
            vector[utf8(attributes::shins())],
            COSMETICS_COLOUR_WAY,
            SHINS_MANUFACTURERS, 
            make_cosmetic_rarities(),
            SHINS_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Shins> {
            id: object::new(ctx),
            name: utf8(attributes::shins()),
            set: false,
            items
        }
    }

    public fun new_boots_shop(ctx: &mut TxContext): Shop<Boots> {
        let items = act_factory::build(
            true,
            BOOTS_NAMES, 
            vector[utf8(attributes::boots())],
            COSMETICS_COLOUR_WAY,
            BOOTS_MANUFACTURERS, 
            make_cosmetic_rarities(),
            BOOTS_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Boots> {
            id: object::new(ctx),
            name: utf8(attributes::boots()),
            set: false,
            items
        }
    }

    public fun new_accessory_shop(ctx: &mut TxContext): Shop<Accessory>  {
        let items = act_factory::build(
            true,
            ACCESSORY_NAMES, 
            vector[utf8(attributes::accessory())],
            COSMETICS_COLOUR_WAY,
            ACCESSORY_MANUFACTURERS, 
            make_cosmetic_rarities(),
            ACCESSORY_CHANCES,
            GENISIS_AMOUNT,
            ctx
        );

        Shop<Accessory> {
            id: object::new(ctx),
            name: utf8(attributes::accessory()),
            set: false,
            items
        }
    }

    public fun new_primary_shop(ctx: &mut TxContext): Shop<Primary> {
        let items = act_factory::build(
            false,
            PRIMARY_NAMES, 
            vector[utf8(attributes::primary())],
            COSMETICS_COLOUR_WAY, // same
            PRIMARY_MANUFACTURERS, 
            make_primary_rarities(),
            PRIMARY_CHANCES, 
            GENISIS_AMOUNT, 
            ctx
        );

        Shop<Primary> {
            id: object::new(ctx),
            name: utf8(attributes::primary()),
            set: false,
            items
        }
    }

    public fun new_secondary_shop(ctx: &mut TxContext): Shop<Secondary> {
        let items = act_factory::build_secondary(
            SECONDARY_NAMES, 
            vector[utf8(attributes::secondary())],
            SECONDARY_COLOUR_WAY,
            SECONDARY_MANUFACTURERS, 
            SECONDARY_RARITIES,
            SECONDARY_CHANCES, 
            GENISIS_AMOUNT, 
            ctx
        );

        Shop<Secondary> {
            id: object::new(ctx),
            name: utf8(attributes::secondary()),
            set: false,
            items
        }
    }

    public fun new_tertiary_shop(ctx: &mut TxContext): Shop<Tertiary> {
        let items = act_factory::build_tertiary(
            TERTIARY_NAMES, 
            vector[utf8(attributes::tertiary())],
            TERTIARY_COLOUR_WAY,
            TERTIARY_MANUFACTURERS, 
            TERTIARY_RARITIES,
            TERTIARY_CHANCES, 
            GENISIS_AMOUNT, 
            ctx
        );

        Shop<Tertiary> {
            id: object::new(ctx),
            name: utf8(attributes::secondary()),
            set: false,
            items
        }
    }

    public fun new_genesis_shop(
        helm_shop: Shop<Helm>,
        chestpiece_shop: Shop<Chestpiece>,
        upper_torso_shop: Shop<UpperTorso>,
        pauldron_shop: Shop<Pauldron>,
        arm_shop: Shop<Arm>,
        glove_shop: Shop<Glove>,
        bracer_shop: Shop<Bracer>,
        legs_shop: Shop<Legs>,
        shins_shop: Shop<Shins>,
        boots_shop: Shop<Boots>,
        accessory_shop: Shop<Accessory>,
        primary_shop: Shop<Primary>,
        secondary_shop: Shop<Secondary>,
        tertiary_shop: Shop<Tertiary>,
        ctx: &mut TxContext
    ) {
        let mut shop = GenesisShop {
            id: object::new(ctx)
        };

        shop.add(helm_shop);
        shop.add(chestpiece_shop);
        shop.add(upper_torso_shop);
        shop.add(pauldron_shop);
        shop.add(arm_shop);
        shop.add(glove_shop);
        shop.add(bracer_shop);
        shop.add(legs_shop);
        shop.add(shins_shop);
        shop.add(boots_shop);
        shop.add(accessory_shop);
        shop.add(primary_shop);
        shop.add(secondary_shop);
        shop.add(tertiary_shop);

        transfer::share_object(shop);
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===\

    public(package) fun borrow_mut(self: &mut GenesisShop, name: String): &mut Item {
        df::borrow_mut(&mut self.id, name)
    }

    public(package) fun items(item: &mut Item): &mut TableVec<FactoryItem> {
        &mut item.items
    }

    public(package) fun set(item: &Item): bool {
        item.set
    }

    // === Private Functions ===

    fun add<Kind>(self: &mut GenesisShop, shop: Shop<Kind>) {
        let Shop { id, name, items, set } = shop;
        id.delete();
        df::add(&mut self.id, name, Item { items, set });
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