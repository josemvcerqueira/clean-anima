module act::act_utils {
    // === Imports ===

    use std::string::{utf8, String};

    use sui::vec_map::{Self, VecMap};

    // === Errors ===

    const EInvalidWeaponSlot: u64 = 0;
    const EInvalidCosmeticType: u64 = 0;

    // === Constants ===

    // Cosmetics
    const HELM: u8 = 0;
    const CHESTPIECE: u8 = 1;
    const BACKPIECE: u8 = 2;
    const UPPER_TORSO: u8 = 3;
    const LEFT_PAULDRON: u8 = 4;
    const RIGHT_PAULDRON: u8 = 5;
    const RIGHT_ARM: u8 = 6;
    const LEFT_ARM: u8 = 7;
    const RIGHT_GLOVE: u8 = 8;
    const LEFT_GLOVE: u8 = 9;
    const RIGHT_BRACER: u8 = 10;
    const LEFT_BRACER: u8 = 11;
    const LEGS: u8 = 12;
    const SHINS: u8 = 13;
    const BOOTS: u8 = 14;
    const ACCESSORY: u8 = 15;

    // Weapon
    const PRIMARY_SLOT: u8 = 0;
    const SECONDARY_SLOT: u8 = 1;
    const TERTIARY_SLOT: u8 = 2;

    // === Structs ===

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun init_attributes(): VecMap<String, String> {
        let mut attributes = vec_map::empty();
        // Default cosmetics
        attributes.insert(utf8(b"helm"), utf8(b""));
        attributes.insert(utf8(b"chestpiece"), utf8(b""));
        attributes.insert(utf8(b"backpiece"), utf8(b""));
        attributes.insert(utf8(b"upper_torso"), utf8(b""));
        attributes.insert(utf8(b"left_pauldron"), utf8(b""));
        attributes.insert(utf8(b"right_pauldron"), utf8(b""));
        attributes.insert(utf8(b"right_arm"), utf8(b""));
        attributes.insert(utf8(b"left_arm"), utf8(b""));
        attributes.insert(utf8(b"right_glove"), utf8(b""));
        attributes.insert(utf8(b"left_glove"), utf8(b""));
        attributes.insert(utf8(b"right_bracer"), utf8(b""));
        attributes.insert(utf8(b"left_bracer"), utf8(b""));
        attributes.insert(utf8(b"legs"), utf8(b""));
        attributes.insert(utf8(b"shins"), utf8(b""));
        attributes.insert(utf8(b"boots"), utf8(b""));
        attributes.insert(utf8(b"accessory"), utf8(b""));
        // Default weapons
        attributes.insert(utf8(b"primary_slot"), utf8(b""));
        attributes.insert(utf8(b"secondary_slot"), utf8(b""));
        attributes.insert(utf8(b"tertiary_slot"), utf8(b""));

        attributes
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}