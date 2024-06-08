module act::act_colour_way {
    // === Imports ===

    // === Errors ===

    // === Constants ===

    const COLOUR_WAY: vector<vector<u8>> = vector[
        b"Vesper",
        b"Hikari",
        b"Volt",
        b"Blood Ivory",
        b"Red Damascus",
        b"Forest",
        b"Dusk",
        b"Viceroy"
    ];

    // === Structs ===

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    public fun get(): vector<vector<u8>> {
        COLOUR_WAY
    }

    // === Public-View Functions ===

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===    
}