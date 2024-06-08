// ex utils
module act::avatar_attributes {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::vec_map::{Self, VecMap};

    // === Errors ===

    const EInvalidAttribute: u64 = 0;

    // === Constants ===

    /// Cosmetic Types
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

    /// Weapon slots
    const PRIMARY: vector<u8> = b"Primary";
    const SECONDARY: vector<u8> = b"Secondary";
    const TERTIARY: vector<u8> = b"Tertiary";

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

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}