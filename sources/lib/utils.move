module act::act_utils {
    // === Imports ===

    use std::string::{utf8, String};

    use sui::{vec_map::VecMap};

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

    public fun set_up_attributes(attributes: &mut VecMap<String, String>) {
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
    }

    // === Public-View Functions ===

    public fun to_cosmetic_string_type(type_: u8): String {
        assert!(ACCESSORY >= type_, EInvalidCosmeticType);
        if (type_ == HELM) return utf8(b"helm");
        if (type_ == CHESTPIECE) return utf8(b"chestpiece");
        if (type_ == BACKPIECE) return utf8(b"backpiece");
        if (type_ == UPPER_TORSO) return utf8(b"upper_torso");
        if (type_ == LEFT_PAULDRON) return utf8(b"left_pauldron");
        if (type_ == RIGHT_PAULDRON) return utf8(b"right_pauldron");
        if (type_ == RIGHT_ARM) return utf8(b"right_arm");
        if (type_ == LEFT_ARM) return utf8(b"left_arm");
        if (type_ == RIGHT_GLOVE) return utf8(b"right_glove");
        if (type_ == LEFT_GLOVE) return utf8(b"left_glove");
        if (type_ == RIGHT_BRACER) return utf8(b"right_bracer");
        if (type_ == LEFT_BRACER) return utf8(b"left_bracer");
        if (type_ == LEGS) return utf8(b"legs");
        if (type_ == SHINS) return utf8(b"shins");
        if (type_ == BOOTS) return utf8(b"boots");
        if (type_ == ACCESSORY) return utf8(b"accessory");

        abort EInvalidCosmeticType
    }

    public fun to_cosmetic_u8_type(type_: String): u8 {
        if (type_ == utf8(b"helm")) return HELM;
        if (type_ == utf8(b"chestpiece")) return CHESTPIECE;
        if (type_ == utf8(b"backpiece")) return BACKPIECE;
        if (type_ == utf8(b"upper_torso")) return UPPER_TORSO;
        if (type_ == utf8(b"left_pauldron")) return LEFT_PAULDRON;
        if (type_ == utf8(b"right_pauldron")) return RIGHT_PAULDRON;
        if (type_ == utf8(b"right_arm")) return RIGHT_ARM;
        if (type_ == utf8(b"left_arm")) return LEFT_ARM;
        if (type_ == utf8(b"right_glove")) return RIGHT_GLOVE;
        if (type_ == utf8(b"left_glove")) return LEFT_GLOVE;
        if (type_ == utf8(b"right_bracer")) return RIGHT_BRACER;
        if (type_ == utf8(b"left_bracer")) return LEFT_BRACER;
        if (type_ == utf8(b"legs")) return LEGS;
        if (type_ == utf8(b"shins")) return SHINS;
        if (type_ == utf8(b"boots")) return BOOTS;
        if (type_ == utf8(b"accessory")) return ACCESSORY;

        abort EInvalidCosmeticType
    }

    public fun to_weapon_string_slot(slot: u8): String {
        assert!(TERTIARY_SLOT >= slot, EInvalidWeaponSlot);
        if (slot == PRIMARY_SLOT) return utf8(b"primary_slot");
        if (slot == SECONDARY_SLOT) return utf8(b"secondary_slot");
        if (slot == TERTIARY_SLOT) return utf8(b"tertiary_slot");

        abort EInvalidWeaponSlot
    }

    public fun to_weapon_u8_slot(slot: String): u8 {
        if (slot == utf8(b"primary_slot")) return PRIMARY_SLOT;
        if (slot == utf8(b"secondary_slot")) return SECONDARY_SLOT;
        if (slot == utf8(b"tertiary_slot")) return TERTIARY_SLOT;

        abort EInvalidWeaponSlot
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}