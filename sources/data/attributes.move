// ex utils
module act::attributes {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::vec_map::{Self, VecMap};

    // === Errors ===

    const EInvalidAttribute: u64 = 0;

    // === Constants ===

    const HELM: vector<u8> = b"Helm";
    const UPPER_TORSO: vector<u8> = b"Upper Torso";
    const CHESTPIECE: vector<u8> = b"Chestpiece";
    const BACKPIECE: vector<u8> = b"Backpiece";
    const LEFT_ARM: vector<u8> = b"Left Arm";
    const RIGHT_ARM: vector<u8> = b"Right Arm";
    const LEFT_BRACER: vector<u8> = b"Left Bracer";
    const RIGHT_BRACER: vector<u8> = b"Right Bracer";
    const LEFT_GLOVE: vector<u8> = b"Left Glove";
    const RIGHT_GLOVE: vector<u8> = b"Right Glove";
    const LEFT_PAULDRON: vector<u8> = b"Left Pauldron";
    const RIGHT_PAULDRON: vector<u8> = b"Right Pauldron";
    const LEGS: vector<u8> = b"Legs";
    const ACCESSORY: vector<u8> = b"Accessory";
    const SHINS: vector<u8> = b"Shins";
    const BOOTS: vector<u8> = b"Boots";

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
        let cosmetic_types = cosmetic_types(); 
        let len = cosmetic_types.length();
        while (len > i) {
            attributes.insert(cosmetic_types[i], utf8(b""));
            i = i + 1;
        };
        // Default weapons
        attributes.insert(primary(), utf8(b""));
        attributes.insert(secondary(), utf8(b""));
        attributes.insert(tertiary(), utf8(b""));

        attributes
    }

    public fun assert_is_valid_cosmetic(str: &String) {
        assert!(cosmetic_types().contains(str), EInvalidAttribute);
    }

    public fun assert_is_valid_weapon(str: &String) {
        assert!(weapon_types().contains(str), EInvalidAttribute);
    }

    // === Public-View Functions ===

    public fun cosmetic_types(): vector<String> {
        vector[
            utf8(HELM),
            utf8(UPPER_TORSO),
            utf8(CHESTPIECE),
            utf8(BACKPIECE),
            utf8(LEFT_ARM),
            utf8(RIGHT_ARM),
            utf8(LEFT_BRACER),
            utf8(RIGHT_BRACER),
            utf8(LEFT_GLOVE),
            utf8(RIGHT_GLOVE),
            utf8(LEFT_PAULDRON),
            utf8(RIGHT_PAULDRON),
            utf8(LEGS),
            utf8(ACCESSORY),
            utf8(SHINS),
            utf8(BOOTS),
        ]
    }

    public fun weapon_types(): vector<String> {
        vector[
            utf8(PRIMARY),
            utf8(SECONDARY),
            utf8(TERTIARY),
        ]
    }

    public fun types(): vector<String> {
        vector[
            utf8(HELM),
            utf8(UPPER_TORSO),
            utf8(CHESTPIECE),
            utf8(BACKPIECE),
            utf8(LEFT_ARM),
            utf8(RIGHT_ARM),
            utf8(LEFT_BRACER),
            utf8(RIGHT_BRACER),
            utf8(LEFT_GLOVE),
            utf8(RIGHT_GLOVE),
            utf8(LEFT_PAULDRON),
            utf8(RIGHT_PAULDRON),
            utf8(LEGS),
            utf8(ACCESSORY),
            utf8(SHINS),
            utf8(BOOTS),
            utf8(PRIMARY),
            utf8(SECONDARY),
            utf8(TERTIARY),
        ]        
    }

    public fun helm(): String { utf8(HELM) }
    public fun chestpiece(): String { utf8(CHESTPIECE) }
    public fun backpiece(): String { utf8(BACKPIECE) }
    public fun upper_torso(): String { utf8(UPPER_TORSO) }
    public fun right_pauldron(): String { utf8(RIGHT_PAULDRON) }
    public fun left_pauldron(): String { utf8(LEFT_PAULDRON) }
    public fun right_arm(): String { utf8(RIGHT_ARM) }
    public fun left_arm(): String { utf8(LEFT_ARM) }
    public fun right_glove(): String { utf8(RIGHT_GLOVE) }
    public fun left_glove(): String { utf8(LEFT_GLOVE) }
    public fun right_bracer(): String { utf8(RIGHT_BRACER) }
    public fun left_bracer(): String { utf8(LEFT_BRACER) }
    public fun legs(): String { utf8(LEGS) }
    public fun shins(): String { utf8(SHINS) }
    public fun boots(): String { utf8(BOOTS) }
    public fun accessory(): String { utf8(ACCESSORY) }

    public fun primary(): String { utf8(PRIMARY) }
    public fun secondary(): String { utf8(SECONDARY) }
    public fun tertiary(): String { utf8(TERTIARY) }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}