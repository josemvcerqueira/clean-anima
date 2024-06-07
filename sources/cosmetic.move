module act::act_cosmetic {
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
    use act::{
        act_admin,
        act_upgrade::{Self, Upgrade},
        access_control::{Admin, AccessControl},
    };
    
    // === Errors ===

    const ECosmeticTypeAlreadyEquipped: u64 = 0;
    const ECosmeticTypeNotEquipped: u64 = 1;

    // === Constants ===

    // === Structs ===

    public struct ACT_COSMETIC has drop {}

    public struct Equip has drop {}

    public struct Cosmetic has key, store {
        id: UID,
        name: String,
        image_url: String,
        image_hash: String,
        model_url: String,
        `type`: String, 
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        hash: String,
        wear_rating: u64, // [0,1] scaled to 1B
        upgrades: vector<Upgrade>
        // TODO: see how to manage the secondary image
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


    public fun upgrade(
        self: &mut Cosmetic, 
        access_control: &AccessControl, 
        admin: &Admin, 
        name: String, 
        image: String        
    ) {
        act_admin::assert_upgrades_role(access_control, admin);
        self.upgrades.push_back(act_upgrade::new(name, image));        
    }

    // === Public-View Functions ===

    public fun type_(self: &Cosmetic): String {
        self.`type`
    }

    public fun name(self: &Cosmetic): String {
        self.name
    }

    public fun image_url(self: &Cosmetic): String {
        self.image_url
    }

    public fun image_hash(self: &Cosmetic): String {
        self.image_hash
    }

    public fun model_url(self: &Cosmetic): String {
        self.model_url
    }

    public fun edition(self: &Cosmetic): String {
        self.edition
    }

    public fun wear_rating(self: &Cosmetic): u64 {
        self.wear_rating
    }

    public fun colour_way(self: &Cosmetic): String {
        self.colour_way
    }

    public fun rarity(self: &Cosmetic): String {
        self.rarity
    }

    public fun manufacturer(self: &Cosmetic): String {
        self.manufacturer
    }

    public fun hash(self: &Cosmetic): String {
        self.hash
    }

    public fun upgrades(self: &Cosmetic): &vector<Upgrade> {
        &self.upgrades
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun equip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        cosmetic_id: ID, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,         
        policy: &TransferPolicy<Cosmetic>, // equipping policy
        ctx: &mut TxContext,
    ): String {
        assert!(!dof::exists_(uid_mut, key), ECosmeticTypeAlreadyEquipped);

        kiosk.list<Cosmetic>(cap, cosmetic_id, 0);
        let coin = coin::zero<SUI>(ctx);
        let (cosmetic, mut request) = kiosk.purchase<Cosmetic>(cosmetic_id, coin);

        let name = cosmetic.name();

        witness_rule::prove(Equip {}, policy, &mut request);
        policy.confirm_request(request);

        dof::add(uid_mut, key, cosmetic);

        name  
    }

    public(package) fun unequip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,     
        policy: &TransferPolicy<Cosmetic>, // trading policy    
    ): String {
        assert!(dof::exists_(uid_mut, key), ECosmeticTypeNotEquipped);
        let cosmetic = dof::remove<Key, Cosmetic>(uid_mut, key);

        let name = cosmetic.name();

        kiosk.lock(cap, policy, cosmetic);
    
        name
    }

    // === Private Functions ===

    // === Test Functions ===
}
