module anima::anima_cosmetic {
    // === Imports ===

    // === Errors ===

    // === Constants ===

    const HELM: u8 = 0;
    const CHESTPIECE: u8 = 1;
    const BACKPIECE: u8 = 2;
    const UPPER_TORSO: u8 = 3;
    const LEFT_PAULDRON: u8 = 4;
    const RIGHT_PAULDRON: u8 = 5;
    const RIGHT_ARN: u8 = 6;
    const LEFT_ARM: u8 = 7;
    const RIGHT_GLOVE: u8 = 8;
    const LEFT_GLOVE: u8 = 9;
    const RIGHT_BRACER: u8 = 10;
    const LEFT_BRACER: u8 = 11;
    const LEGS: u8 = 12;
    const SHINS: u8 = 13;
    const BOOTS: u8 = 14;
    const ACCESSORY: u8 = 15;

    // === Structs ===

    public struct Cosmetic has key, store {
        id: UID,
        /// type is a reserved word
        kind: u8
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    // === Public-View Functions ===

    public fun kind(self: &Cosmetic): u8 {
     self.kind
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}
