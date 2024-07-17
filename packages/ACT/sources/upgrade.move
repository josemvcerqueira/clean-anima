module act::upgrade {
    // === Imports ===

    use std::string::String;

    // === Errors ===

    // === Constants ===

    // === Structs ===

    public struct Upgrade has store {
        url: String
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    // === Public-View Functions ===

    public fun url(self: &Upgrade): String {
        self.url
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun new(url: String): Upgrade {
        Upgrade { url }
    }

    // === Private Functions ===

    // === Test Functions ===
}