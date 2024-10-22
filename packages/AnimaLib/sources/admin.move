module animalib::admin {
    // === Imports ===

    use animalib::access_control::{Self, Admin, AccessControl};

    // === Errors ===

    const EInvalidRole: u64 = 0;

    // === Constants ===

    const ACCOLADES_ROLE: vector<u8> = b"ACCOLADES_ROLE";
    const REPUTATION_ROLE: vector<u8> = b"REPUTATION_ROLE";
    const UPGRADES_ROLE: vector<u8> = b"UPGRADES_ROLE";
    const GENESIS_MINTER_ROLE: vector<u8> = b"GENESIS_MINTER_ROLE";
    const PROFILE_PICTURES_ROLE: vector<u8> = b"PROFILE_PICTURES_ROLE";
    const AVATAR_SETTINGS_ROLE: vector<u8> = b"AVATAR_SETTINGS_ROLE";

    // === Public-Mutative Functions ===

    #[allow(lint(share_owned))]
    fun init(ctx: &mut TxContext) {
        let (mut access_control, super_admin) = access_control::new(ctx);

        let admin = access_control.new_admin(ctx);

        super_admin.add(&mut access_control, ACCOLADES_ROLE);
        super_admin.add(&mut access_control, REPUTATION_ROLE);
        super_admin.add(&mut access_control, UPGRADES_ROLE);
        super_admin.add(&mut access_control, GENESIS_MINTER_ROLE);
        super_admin.add(&mut access_control, PROFILE_PICTURES_ROLE);
        super_admin.add(&mut access_control, AVATAR_SETTINGS_ROLE);

        super_admin.grant(&mut access_control, ACCOLADES_ROLE, admin.addy());
        super_admin.grant(&mut access_control, REPUTATION_ROLE, admin.addy());
        super_admin.grant(&mut access_control, UPGRADES_ROLE, admin.addy());
        super_admin.grant(&mut access_control, GENESIS_MINTER_ROLE, admin.addy());
        super_admin.grant(&mut access_control, PROFILE_PICTURES_ROLE, admin.addy());
        super_admin.grant(&mut access_control, AVATAR_SETTINGS_ROLE, admin.addy());

        transfer::public_share_object(access_control);
        transfer::public_transfer(super_admin, ctx.sender());
        transfer::public_transfer(admin, ctx.sender());
    }

    // === Public-View Functions ===   

    public fun assert_accolades_role(access_control: &AccessControl, admin: &Admin) {
        assert!(admin.has_role(access_control, ACCOLADES_ROLE), EInvalidRole);
    }   

    public fun assert_reputation_role(access_control: &AccessControl, admin: &Admin) {
        assert!(admin.has_role(access_control, REPUTATION_ROLE), EInvalidRole);
    }

    public fun assert_upgrades_role(access_control: &AccessControl, admin: &Admin) {
        assert!(admin.has_role(access_control, UPGRADES_ROLE), EInvalidRole);
    }

    public fun assert_genesis_minter_role(access_control: &AccessControl, admin: &Admin) {
        assert!(admin.has_role(access_control, GENESIS_MINTER_ROLE), EInvalidRole);
    }

    public fun assert_profile_pictures_role(access_control: &AccessControl, admin: &Admin) {
        assert!(admin.has_role(access_control, PROFILE_PICTURES_ROLE), EInvalidRole);
    }

    public fun assert_avatar_settings_role(access_control: &AccessControl, admin: &Admin) {
        assert!(admin.has_role(access_control, AVATAR_SETTINGS_ROLE), EInvalidRole);
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx);
    }
}