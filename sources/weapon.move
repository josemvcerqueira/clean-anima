
//primary
//secondary
//tertiary
module act::act_weapon {
    // === Imports ===

    // === Errors ===

    // === Constants ===

    const PRIMARY_SLOT: u8 = 0;
    const SECONDARY_SLOT: u8 = 1;
    const TERTIARY_SLOT: u8 = 2;

    // === Structs ===

    public struct Weapon has key, store {
        id: UID,
        slot: u8
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    // === Public-View Functions ===

    public fun slot(self: &Weapon): u8 {
        self.slot
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}