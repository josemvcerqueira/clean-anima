module act::assets {

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

    const LEGS_RARITIES: vector<vector<u8>> = vector[
        b"Mythic",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
    ]; 

    const BOOTS_RARITIES: vector<vector<u8>> = vector[
        b"Ultra Rare",
        b"Mythic",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
        b"Ultra Rare",
    ]; 

    const PRIMARY_RARITIES: vector<vector<u8>> = vector[
        b"Common",
        b"Common",
        b"Common",
        b"Common",
    ];
    const SECONDARY_RARITIES: vector<vector<u8>> = vector[
        b"Common",
        b"Common",
    ];
    const TERTIARY_RARITIES: vector<vector<u8>> = vector[
        b"Ultra Rare",
        b"Ultra Rare",
        b"Mythic",
    ];

    // Colour ways
    const COSMETICS_COLOUR_WAYS: vector<vector<u8>> = vector[
        b"Vesper",
        b"Hikari",
        b"Volt",
        b"Blood Ivory",
        b"Red Damascus",
        b"Digital Winter",
        b"Dusk",
        b"Viceroy"
    ];

    const LEGS_COLOUR_WAYS: vector<vector<u8>> = vector[
        b"Hikari",
        b"Volt",
        b"Blood Ivory",
        b"Dusk",
        b"Digital Winter",
    ];

    const BOOTS_COLOUR_WAYS: vector<vector<u8>> = vector[
        b"Vesper",
        b"Hikari",
        b"Volt",
        b"Blood Ivory",
        b"Red Damascus",
        b"Dusk",
    ];

    const PRIMARY_COLOUR_WAYS: vector<vector<u8>> = vector[
        b"Gunmetal",
        b"Gunmetal",
        b"Gunmetal",
        b"Gunmetal",
    ];
    const SECONDARY_COLOUR_WAYS: vector<vector<u8>> = vector[
        b"Gunmetal",
        b"Gunmetal",
    ];
    const TERTIARY_COLOUR_WAYS: vector<vector<u8>> = vector[
        b"K1TSUN3",
        b"Viceroy",
        b"Future",
    ];

    // Names
    const SK_VIPER: vector<u8> = b"SK-Viper";
    const FANG_MK_IV: vector<u8> = b"Fang MK IV";
    const SPECTRE_09: vector<u8> = b"Spectre-09";
    const HELIOS: vector<u8> = b"Helios";
    const BAHA_2000: vector<u8> = b"Baha-2000";
    const NEO_SHOGUNATE: vector<u8> = b"Neo-Shogunate";

    const TALON: vector<u8> = b"Talon";
    const RENEGADE: vector<u8> = b"Renegade";
    const RAPTOR: vector<u8> = b"Raptor";
    const VALENTI_12: vector<u8> = b"Valenti 12";
    const ENFORCER: vector<u8> = b"Enforcer";
    const WHISPER_9MM: vector<u8> = b"Whisper 9mm";
    const WAKIZASHI: vector<u8> = b"Wakizashi";
    const SCALPER: vector<u8> = b"Scalper";
    const NEO_KATANA: vector<u8> = b"Neo-Katana";

    // Manufacturers
    const OBSIDIAN: vector<u8> = b"Obsidian Dynamics";
    const EXO: vector<u8> = b"ExoTech Solutions";
    const PHALANX: vector<u8> = b"Phalanx Defence Corp";
    const ZENITH: vector<u8> = b"Zenith Aerospace";
    const ROOTS: vector<u8> = b"Roots Robotics";

    const FENRIR: vector<u8> = b"Fenrir Arms";
    const VOLOSLAV: vector<u8> = b"Voloslav Industrial";
    const AEGIS: vector<u8> = b"Aegis Tactical";
    const VALENTI: vector<u8> = b"Valenti";
    const LIBERTY: vector<u8> = b"Liberty Arms Corporation";
    const PRECISIONE: vector<u8> = b"Precisione Milano";
    const RYUJIN: vector<u8> = b"Ryujin Industrial";
    const ECLIPSE: vector<u8> = b"Eclipse Steel Forging LTD";
    const HYPERBLADE: vector<u8> = b"ハイパーブレード CORPORATION";

    // Helms
    const HELM_NAMES: vector<vector<u8>> = vector[
        SK_VIPER,
        FANG_MK_IV,
        SPECTRE_09,
        HELIOS,
        BAHA_2000
    ];
    const HELM_CHANCES: vector<vector<u64>> = vector[
        vector[277, 75, 277, 277, 277, 277, 277, 277],
        vector[277, 75, 277, 277, 277, 277, 277, 277],
        vector[277, 75, 277, 275, 277, 277, 277, 277],
        vector[277, 75, 277, 275, 277, 275, 277, 275],
        vector[277, 75, 277, 275, 277, 275, 277, 275]
    ];
    const HELM_MANUFACTURERS: vector<vector<u8>> = vector[
        OBSIDIAN,
        EXO,
        PHALANX,
        ZENITH,
        ROOTS
    ];

    // Upper torso
    const UPPER_TORSO_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const UPPER_TORSO_CHANCES: vector<vector<u64>> = vector[
        vector[10000]
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
        vector[802, 202, 403, 301, 403, 802, 802, 301],
        vector[601, 103, 352, 202, 352, 601, 601, 202],
        vector[601, 100, 350, 200, 350, 600, 600, 200]
    ];
    const CHESTPIECE_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
        ZENITH,
        OBSIDIAN
    ];

    // Arm
    const ARM_CHANCES: vector<vector<u64>> = vector[
        vector[10000]
    ];
    const ARM_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const ARM_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // BRACER
    const BRACER_CHANCES: vector<vector<u64>> = vector[
        vector[802, 202, 403, 301, 403, 802, 802, 301],
        vector[601, 103, 352, 202, 352, 601, 601, 202],
        vector[601, 100, 350, 200, 350, 600, 600, 200]
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
        vector[10000]
    ];
    const GLOVE_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV,
    ];
    const GLOVE_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Pauldron
    const PAULDRON_CHANCES: vector<vector<u64>> = vector[
        vector[802, 202, 403, 301, 403, 802, 802, 301],
        vector[601, 103, 352, 202, 352, 601, 601, 202],
        vector[601, 100, 350, 200, 350, 600, 600, 200],
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
        vector[403, 1201, 1201, 1201, 1201],
        vector[1201, 1201, 1201, 1200]
    ];
    
    const LEGS_NAMES: vector<vector<u8>> = vector[
        HELIOS,
        FANG_MK_IV
    ];

    const LEGS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
        EXO
    ];

    // Belt
    const BELT_CHANCES: vector<vector<u64>> = vector[
        vector[10000]
    ];
    const BELT_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const BELT_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];  

    // Shins
    const SHINS_CHANCES: vector<vector<u64>> = vector[
        vector[10000]
    ];
    const SHINS_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const SHINS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];

    // Boots
    const BOOTS_CHANCES: vector<vector<u64>> = vector[
        vector[1903, 500, 1903, 1900, 1900, 1900]
    ];
    const BOOTS_NAMES: vector<vector<u8>> = vector[
        FANG_MK_IV
    ];
    const BOOTS_MANUFACTURERS: vector<vector<u8>> = vector[
        EXO,
    ];    


    // Primary Weapon
    const PRIMARY_CHANCES: vector<vector<u64>> = vector[
        vector[1000],
        vector[3001],
        vector[3001],
        vector[3001],
    ];
    const PRIMARY_NAMES: vector<vector<u8>> = vector[
        TALON,
        RENEGADE,
        RAPTOR,
        VALENTI_12,
    ];
    const PRIMARY_MANUFACTURERS: vector<vector<u8>> = vector[
        FENRIR,
        VOLOSLAV,
        AEGIS,
        VALENTI,
    ];  

    // Secondary Weapon
    const SECONDARY_CHANCES: vector<vector<u64>> = vector[
        vector[7000],
        vector[3001],
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
    const TERTIARY_CHANCES: vector<vector<u64>> = vector[
        vector[4000], 
        vector[4000], 
        vector[2002],
    ];
    const TERTIARY_NAMES: vector<vector<u8>> = vector[
        WAKIZASHI,
        SCALPER,
        NEO_KATANA,
    ];
    const TERTIARY_MANUFACTURERS: vector<vector<u8>> = vector[
        RYUJIN,
        ECLIPSE,
        HYPERBLADE
    ]; 

    // helms

    public(package) fun helm_names(): vector<vector<u8>> {
        HELM_NAMES
    }

    public(package) fun helm_chances(): vector<vector<u64>> {
        HELM_CHANCES
    }

    public(package) fun helm_manufacturers(): vector<vector<u8>> {
        HELM_MANUFACTURERS
    }

    // upper torso

    public(package) fun upper_torso_names(): vector<vector<u8>> {
        UPPER_TORSO_NAMES
    }

    public(package) fun upper_torso_chances(): vector<vector<u64>> {
        UPPER_TORSO_CHANCES
    }

    public(package) fun upper_torso_manufacturers(): vector<vector<u8>> {
        UPPER_TORSO_MANUFACTURERS
    }

    // chestpiece

    public(package) fun chestpiece_names(): vector<vector<u8>> {
        CHESTPIECE_NAMES
    }

    public(package) fun chestpiece_chances(): vector<vector<u64>> {
        CHESTPIECE_CHANCES
    }

    public(package) fun chestpiece_manufacturers(): vector<vector<u8>> {
        CHESTPIECE_MANUFACTURERS
    }

    // arms

    public(package) fun arm_names(): vector<vector<u8>> {
        ARM_NAMES
    }

    public(package) fun arm_chances(): vector<vector<u64>> {
        ARM_CHANCES
    }

    public(package) fun arm_manufacturers(): vector<vector<u8>> {
        ARM_MANUFACTURERS
    }

    // bracers 

    public(package) fun bracer_names(): vector<vector<u8>> {
        BRACER_NAMES
    }

    public(package) fun bracer_chances(): vector<vector<u64>> {
        BRACER_CHANCES
    }

    public(package) fun bracer_manufacturers(): vector<vector<u8>> {
        BRACER_MANUFACTURERS
    }

    // gloves 

    public(package) fun glove_names(): vector<vector<u8>> {
        GLOVE_NAMES
    }

    public(package) fun glove_chances(): vector<vector<u64>> {
        GLOVE_CHANCES
    }

    public(package) fun glove_manufacturers(): vector<vector<u8>> {
        GLOVE_MANUFACTURERS
    }

    // pauldrons 

    public(package) fun pauldrons_names(): vector<vector<u8>> {
        PAULDRON_NAMES
    }

    public(package) fun pauldrons_chances(): vector<vector<u64>> {
        PAULDRON_CHANCES
    }

    public(package) fun pauldrons_manufacturers(): vector<vector<u8>> {
        PAULDRON_MANUFACTURERS
    }

    // legs

    public(package) fun legs_names(): vector<vector<u8>> {
        LEGS_NAMES
    }

    public(package) fun legs_chances(): vector<vector<u64>> {
        LEGS_CHANCES
    }

    public(package) fun legs_manufacturers(): vector<vector<u8>> {
        LEGS_MANUFACTURERS
    }

    // belts

    public(package) fun belt_names(): vector<vector<u8>> {
        BELT_NAMES
    }

    public(package) fun belt_chances(): vector<vector<u64>> {
        BELT_CHANCES
    }

    public(package) fun belt_manufacturers(): vector<vector<u8>> {
        BELT_MANUFACTURERS
    }

    // shins

    public(package) fun shins_names(): vector<vector<u8>> {
        SHINS_NAMES
    }

    public(package) fun shins_chances(): vector<vector<u64>> {
        SHINS_CHANCES
    }

    public(package) fun shins_manufacturers(): vector<vector<u8>> {
        SHINS_MANUFACTURERS
    }

    // primary weapons

    public(package) fun primary_names(): vector<vector<u8>> {
        PRIMARY_NAMES
    }

    public(package) fun primary_chances(): vector<vector<u64>> {
        PRIMARY_CHANCES
    }

    public(package) fun primary_manufacturers(): vector<vector<u8>> {
        PRIMARY_MANUFACTURERS
    }

    // secondary weapons

    public(package) fun secondary_names(): vector<vector<u8>> {
        SECONDARY_NAMES
    }

    public(package) fun secondary_chances(): vector<vector<u64>> {
        SECONDARY_CHANCES
    }

    public(package) fun secondary_manufacturers(): vector<vector<u8>> {
        SECONDARY_MANUFACTURERS
    }

    // tertiary weapons

    public(package) fun tertiary_names(): vector<vector<u8>> {
        TERTIARY_NAMES
    }

    public(package) fun tertiary_chances(): vector<vector<u64>> {
        TERTIARY_CHANCES
    }

    public(package) fun tertiary_manufacturers(): vector<vector<u8>> {
        TERTIARY_MANUFACTURERS
    }

    // boots 

    public(package) fun boots_names(): vector<vector<u8>> {
        BOOTS_NAMES
    }

    public(package) fun boots_chances(): vector<vector<u64>> {
        BOOTS_CHANCES
    }

    public(package) fun boots_manufacturers(): vector<vector<u8>> {
        BOOTS_MANUFACTURERS
    }

    // colour ways

    public(package) fun cosmetic_colour_ways(): vector<vector<u8>> {
        COSMETICS_COLOUR_WAYS
    }

    public(package) fun legs_colour_ways(): vector<vector<u8>> {
        LEGS_COLOUR_WAYS
    }

    public(package) fun boots_colour_ways(): vector<vector<u8>> {
        BOOTS_COLOUR_WAYS
    }

    public(package) fun primary_colour_ways(): vector<vector<u8>> {
        PRIMARY_COLOUR_WAYS
    }

    public(package) fun secondary_colour_ways(): vector<vector<u8>> {
        SECONDARY_COLOUR_WAYS
    }

    public(package) fun tertiary_colour_ways(): vector<vector<u8>> {
        TERTIARY_COLOUR_WAYS
    }

    // rarities

    public(package) fun cosmetic_rarities(): vector<vector<u8>> {
        COSMETICS_RARITIES
    }

    public(package) fun leg_rarities(): vector<vector<u8>> {
        LEGS_RARITIES
    }

    public(package) fun boots_rarities(): vector<vector<u8>> {
        BOOTS_RARITIES
    }

    public(package) fun primary_rarities(): vector<vector<u8>> {
        PRIMARY_RARITIES
    }

    public(package) fun secondary_rarities(): vector<vector<u8>> {
        SECONDARY_RARITIES
    }

    public(package) fun tertiary_rarities(): vector<vector<u8>> {
        TERTIARY_RARITIES
    }
}