module act::act_cosmetic {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::{package, display, transfer_policy};
    use kiosk::{royalty_rule, kiosk_lock_rule, witness_rule};

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

    public struct ACT_COSMETIC has drop {}

    public struct Equip has drop {}

    public struct Cosmetic has key, store {
        id: UID,
        name: String,
        image_url: String,
        image_hash: String,
        `type`: u8, 
        uuid: u64, // is is necessary if we have id: UID?
        global_rank: u64,
        edition: String,
        wear_rating: u64, // [0,1] scaled to 1B
        colour_way: String,
        rarity: String,
        manufacturer: String,
        hash: String,
        // see how to manage the secondary image
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    #[allow(lint(share_owned))]
    fun init(otw: ACT_COSMETIC, ctx: &mut TxContext) {
        // create Display
        let keys = vector[
            utf8(b"name"),
            utf8(b"description"),
            utf8(b"image_url"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];
        let values = vector[
            utf8(b"ACT Cosmetic: {name}"),
            utf8(b"ACT is a fast-paced, high-skill multiplayer FPS"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"https://animalabs.io"), // to change with ACT game page
            utf8(b"Anima Labs"),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<Cosmetic>(
            &publisher, keys, values, ctx
        );
        display.update_version();
        transfer::public_transfer(display, ctx.sender());

        // create TransferPolicy for trading
        let (mut policy, cap) = transfer_policy::new<Cosmetic>(&publisher, ctx);
        royalty_rule::add(&mut policy, &cap, 100, 0); // % royalty?
        kiosk_lock_rule::add(&mut policy, &cap);
        transfer::public_share_object(policy);
        transfer::public_transfer(cap, ctx.sender());

        // create TransferPolicy for equipping 
        let (mut policy, cap) = transfer_policy::new<Cosmetic>(&publisher, ctx);
        witness_rule::add<Cosmetic, Equip>(&mut policy, &cap);
        transfer::public_share_object(policy);
        transfer::public_transfer(cap, ctx.sender());

        transfer::public_transfer(publisher, ctx.sender());
    }

    // === Public-View Functions ===

    public fun `type`(self: &Cosmetic): u8 {
        self.`type`
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}
