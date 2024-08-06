module act::upgrade {
    // === Imports ===

    use std::string::String;

    // === Errors ===

    // === Constants ===

    // === Structs ===

    public struct LockedUpgrade has key, store {
        id: UID,
        name: String,
        image_url: String,
        model_url: String,
        texture_url: String,
    }

    public struct Upgrade has store {
        name: String,
        image_url: String,
        model_url: String,
        texture_url: String,
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    // === Public-View Functions ===

    public use fun locked_upgrade_name as LockedUpgrade.name;
    public(package) fun locked_upgrade_name(self: &LockedUpgrade): String {
        self.name
    }
    
    public use fun locked_upgrade_image_url as LockedUpgrade.image_url;
    public(package)  fun locked_upgrade_image_url(self: &LockedUpgrade): String {
        self.image_url
    }

    public use fun locked_upgrade_model_url as LockedUpgrade.model_url;
    public(package) fun locked_upgrade_model_url(self: &LockedUpgrade): String {
        self.model_url
    }

    public use fun locked_upgrade_texture_url as LockedUpgrade.texture_url;
    public(package) fun locked_upgrade_texture_url(self: &LockedUpgrade): String {
        self.texture_url
    }

    public use fun upgrade_name as Upgrade.name;
    public(package) fun upgrade_name(self: &Upgrade): String {
        self.name
    }

    public use fun upgrade_image_url as Upgrade.image_url;
    public(package)  fun upgrade_image_url(self: &Upgrade): String {
        self.image_url
    }

    public use fun upgrade_model_url as Upgrade.model_url;
    public(package) fun upgrade_model_url(self: &Upgrade): String {
        self.model_url
    }

    public use fun upgrade_texture_url as Upgrade.texture_url;
    public(package) fun upgrade_texture_url(self: &Upgrade): String {
        self.texture_url
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun new(
        name: String,
        image_url: String,
        model_url: String,
        texture_url: String,
        ctx: &mut TxContext
    ): LockedUpgrade {
        LockedUpgrade {
            id: object::new(ctx),
            name,
            image_url,
            model_url,
            texture_url,
        }
    }

    public(package) fun destroy(locked_upgrade: LockedUpgrade): Upgrade {
        let LockedUpgrade { id, name, image_url, model_url, texture_url } = locked_upgrade;
        id.delete();
        Upgrade {
            name,
            image_url,
            model_url,
            texture_url
        }
    }

    // === Private Functions ===

    // === Test Functions ===
}