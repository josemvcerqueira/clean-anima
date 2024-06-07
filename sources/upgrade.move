module act::act_upgrade {
    // === Imports ===

    use std::string::String;

    // === Errors ===

    // === Constants ===

    // === Structs ===

    public struct Upgrade has store {
        name: String,
        image: String
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    // === Public-View Functions ===

    public fun name(self: &Upgrade): String {
        self.name
    }

    public fun image(self: &Upgrade): String {
        self.image
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun new(name: String, image: String): Upgrade {
        Upgrade {   
            name,
            image
        }
    }

    // === Private Functions ===

    // === Test Functions ===
}