module act::avatar_attributes {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::vec_map::{Self, VecMap};

    // === Errors ===

    const EInvalidAttribute: u64 = 0;

    // === Constants ===

    // === Structs ===

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun new(): VecMap<String, String> {
        let mut attributes = vec_map::empty();
        // Default cosmetics
        attributes.insert(utf8(b"Helm"), utf8(b""));
        attributes.insert(utf8(b"Chestpiece"), utf8(b""));
        attributes.insert(utf8(b"Backpiece"), utf8(b""));
        attributes.insert(utf8(b"Upper Torso"), utf8(b""));
        attributes.insert(utf8(b"Left Pauldron"), utf8(b""));
        attributes.insert(utf8(b"Right Pauldron"), utf8(b""));
        attributes.insert(utf8(b"Right Arm"), utf8(b""));
        attributes.insert(utf8(b"Left Arm"), utf8(b""));
        attributes.insert(utf8(b"Right Glove"), utf8(b""));
        attributes.insert(utf8(b"Left Glove"), utf8(b""));
        attributes.insert(utf8(b"Right Bracer"), utf8(b""));
        attributes.insert(utf8(b"Left Bracer"), utf8(b""));
        attributes.insert(utf8(b"Legs"), utf8(b""));
        attributes.insert(utf8(b"Shins"), utf8(b""));
        attributes.insert(utf8(b"Boots"), utf8(b""));
        attributes.insert(utf8(b"Accessory"), utf8(b""));
        // Default weapons
        attributes.insert(utf8(b"Primary"), utf8(b""));
        attributes.insert(utf8(b"Secondary"), utf8(b""));
        attributes.insert(utf8(b"Tertiary Slot"), utf8(b""));

        attributes
    }

    public fun assert_is_equipment(str: String) {
        assert!(
            str == utf8(b"Helm") ||
            str == utf8(b"Chestpiece") ||
            str == utf8(b"Backpiece") ||
            str == utf8(b"Upper Torso") ||
            str == utf8(b"Left Pauldron") ||
            str == utf8(b"Right Pauldron") ||
            str == utf8(b"Right Arm") ||
            str == utf8(b"Left Arm") ||
            str == utf8(b"Right Glove") ||
            str == utf8(b"Left Glove") ||
            str == utf8(b"Right Bracer") ||
            str == utf8(b"Left Bracer") ||
            str == utf8(b"Legs") ||
            str == utf8(b"Shins") ||
            str == utf8(b"Boots") ||
            str == utf8(b"Accessory") ||
            str == utf8(b"Primary") ||
            str == utf8(b"Secondary") ||
            str == utf8(b"Tertiary Slot"),
            EInvalidAttribute
        );
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}