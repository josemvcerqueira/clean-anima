// ex utils
module act::attributes {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::vec_map::{Self, VecMap};

    // === Errors ===

    const EInvalidAttribute: u64 = 0;

    // === Constants ===

    const HELM: vector<u8> = b"Helm";
    const CHESTPIECE: vector<u8> = b"Chestpiece";
    const BACKPIECE: vector<u8> = b"Backpiece";
    const UPPER_TORSO: vector<u8> = b"Upper Torso";
    const LEFT_PAULDRON: vector<u8> = b"Left Pauldron";
    const RIGHT_PAULDRON: vector<u8> = b"Right Pauldron";
    const RIGHT_ARM: vector<u8> = b"Right Arm";
    const LEFT_ARM: vector<u8> = b"Left Arm";
    const RIGHT_GLOVE: vector<u8> = b"Right Glove";
    const LEFT_GLOVE: vector<u8> = b"Left Glove";
    const RIGHT_BRACER: vector<u8> = b"Right Bracer";
    const LEFT_BRACER: vector<u8> = b"Left Bracer";
    const LEGS: vector<u8> = b"Legs";
    const SHINS: vector<u8> = b"Shins";
    const BOOTS: vector<u8> = b"Boots";
    const ACCESSORY: vector<u8> = b"Accessory";

    const PRIMARY: vector<u8> = b"Primary";
    const SECONDARY: vector<u8> = b"Secondary";
    const TERTIARY: vector<u8> = b"Tertiary";

    const COSMETIC_TYPES: vector<vector<u8>> = vector[
        HELM,
        CHESTPIECE,
        BACKPIECE,
        UPPER_TORSO,
        LEFT_PAULDRON,
        RIGHT_PAULDRON,
        RIGHT_ARM,
        LEFT_ARM,
        RIGHT_GLOVE,
        LEFT_GLOVE,
        RIGHT_BRACER,
        LEFT_BRACER,
        LEGS,
        SHINS,
        BOOTS,
        ACCESSORY
    ];

    // === Structs ===

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun new(): VecMap<String, String> {
        let mut attributes = vec_map::empty();
        // Default cosmetics
        let mut i = 0;
        let cosmetic_types = COSMETIC_TYPES; 
        let len = cosmetic_types.length();
        while (len > i) {
            attributes.insert(utf8(cosmetic_types[i]), utf8(b""));
            i = i + 1;
        };

        // Default weapons
        attributes.insert(utf8(PRIMARY), utf8(b""));
        attributes.insert(utf8(SECONDARY), utf8(b""));
        attributes.insert(utf8(TERTIARY), utf8(b""));

        attributes
    }

    public fun assert_is_valid_cosmetic(str: String) {
        assert!(COSMETIC_TYPES.contains(str.bytes()), EInvalidAttribute);
    }

    public fun assert_is_valid_weapon(str: String) {
        assert!(
            str == utf8(PRIMARY) ||
            str == utf8(SECONDARY) ||
            str == utf8(TERTIARY),
            EInvalidAttribute
        );
    }

    // === Public-View Functions ===

    public fun cosmetic_types(): vector<vector<u8>> {
        COSMETIC_TYPES
    }

    public fun weapon_types(): vector<vector<u8>> {
        vector[PRIMARY, SECONDARY, TERTIARY]
    }

    public fun types(): vector<vector<u8>> {
        vector[
            HELM,
            CHESTPIECE,
            BACKPIECE,
            UPPER_TORSO,
            b"Pauldron",
            b"Arm",
            b"Glove",
            b"Bracer",
            LEGS,
            SHINS,
            BOOTS,
            ACCESSORY,
            PRIMARY,
            SECONDARY,
            TERTIARY
        ]        
    }

    public fun helm(): vector<u8> { HELM }
    public fun chestpiece(): vector<u8> { CHESTPIECE }
    public fun backpiece(): vector<u8> { BACKPIECE }
    public fun upper_torso(): vector<u8> { UPPER_TORSO }
    public fun right_pauldron(): vector<u8> { RIGHT_PAULDRON }
    public fun left_pauldron(): vector<u8> { LEFT_PAULDRON }
    public fun right_arm(): vector<u8> { RIGHT_ARM }
    public fun left_arm(): vector<u8> { LEFT_ARM }
    public fun right_glove(): vector<u8> { RIGHT_GLOVE }
    public fun left_glove(): vector<u8> { LEFT_GLOVE }
    public fun right_bracer(): vector<u8> { RIGHT_BRACER }
    public fun left_bracer(): vector<u8> { LEFT_BRACER }
    public fun pauldron(): vector<u8> { b"Pauldron" } // need to be left and right
    public fun arm(): vector<u8> { b"Arm" } // need to be left and right
    public fun glove(): vector<u8> { b"Glove" } // need to be left and right
    public fun bracer(): vector<u8> { b"Bracer" } // need to be left and right
    public fun legs(): vector<u8> { LEGS }
    public fun shins(): vector<u8> { SHINS }
    public fun boots(): vector<u8> { BOOTS }
    public fun accessory(): vector<u8> { ACCESSORY }

    public fun primary(): vector<u8> { PRIMARY }
    public fun secondary(): vector<u8> { SECONDARY }
    public fun tertiary(): vector<u8> { TERTIARY }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}