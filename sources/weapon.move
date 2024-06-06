
//primary
//secondary
//tertiary
module act::act_weapon {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::{
        package, 
        display, 
        coin,
        sui::SUI,
        transfer_policy::{Self, TransferPolicy}, 
        dynamic_object_field as dof,
        kiosk::{Kiosk, KioskOwnerCap},
    };
    use kiosk::{royalty_rule, kiosk_lock_rule, witness_rule};

    // === Errors ===

    const EWeaponTypeAlreadyEquipped: u64 = 0;
    const EWeaponTypeNotEquipped: u64 = 1;

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

    public(package) fun equip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        weapon_id: ID, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,         
        policy: &TransferPolicy<Weapon>, // equipping policy
        ctx: &mut TxContext,
    ) {
        assert!(!dof::exists_(uid_mut, key), EWeaponTypeAlreadyEquipped);

        kiosk.list<Weapon>(cap, weapon_id, 0);
        let coin = coin::zero<SUI>(ctx);
        let (weapon, mut request) = kiosk.purchase<Weapon>(weapon_id, coin);

        witness_rule::prove(Equip {}, policy, &mut request);
        policy.confirm_request(request);

        dof::add(uid_mut, key, weapon)  
    }

    public(package) fun unequip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,     
        policy: &TransferPolicy<Weapon>, // trading policy    
    ) {
        assert!(dof::exists_(uid_mut, key), EWeaponTypeNotEquipped);
        let weapon = dof::remove<Key, Weapon>(uid_mut, key);
        kiosk.lock(cap, policy, weapon);
    }

    // === Private Functions ===

    // === Test Functions ===
}