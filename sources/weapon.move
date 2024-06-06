
//primary
//secondary
//tertiary
module act::act_weapon {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::{package, display, transfer_policy};
    use kiosk::{royalty_rule, kiosk_lock_rule, witness_rule};

    // === Errors ===

    // === Constants ===

    const PRIMARY_SLOT: u8 = 0;
    const SECONDARY_SLOT: u8 = 1;
    const TERTIARY_SLOT: u8 = 2;

    // === Structs ===

    public struct ACT_WEAPON has drop {}

    public struct Equip has drop {}

    public struct Weapon has key, store {
        id: UID,
        name: String,
        image_url: String,
        image_hash: String,
        slot: u8,
        kill_count: u64,  
        accuracy: String, 
        uuid: u64,
        global_rank: u64,
        edition: String,
        wear_rating: u64,
        colour_way: String,
        rarity: String,
        manufacturer: String,
        hash: String,
        upgrades: vector<String>,
        // see how to manage the secondary image
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    #[allow(lint(share_owned))]
    fun init(otw: ACT_WEAPON, ctx: &mut TxContext) {

        let keys = vector[
            utf8(b"name"),
            utf8(b"description"),
            utf8(b"image_url"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];
        let values = vector[
            utf8(b"ACT Weapon: {name}"),
            utf8(b"ACT is a fast-paced, high-skill multiplayer FPS"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"https://animalabs.io"), // to change with ACT game page
            utf8(b"Anima Labs"),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<Weapon>(
            &publisher, keys, values, ctx
        );
        display.update_version();
        transfer::public_transfer(display, ctx.sender());

        // create TransferPolicy for trading
        let (mut policy, cap) = transfer_policy::new<Weapon>(&publisher, ctx);
        royalty_rule::add(&mut policy, &cap, 100, 0); // % royalty?
        kiosk_lock_rule::add(&mut policy, &cap);
        transfer::public_share_object(policy);
        transfer::public_transfer(cap, ctx.sender());

        // create TransferPolicy for equipping 
        let (mut policy, cap) = transfer_policy::new<Weapon>(&publisher, ctx);
        witness_rule::add<Weapon, Equip>(&mut policy, &cap);
        transfer::public_share_object(policy);
        transfer::public_transfer(cap, ctx.sender());

        transfer::public_transfer(publisher, ctx.sender());
    }

    // === Public-View Functions ===

    public fun slot(self: &Weapon): u8 {
        self.slot
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions ===
}