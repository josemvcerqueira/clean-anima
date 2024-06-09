
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
    use act::{
        act_admin,
        act_upgrade::{Self, Upgrade},
        access_control::{Admin, AccessControl},
    };

    // === Errors ===

    const EWeaponTypeAlreadyEquipped: u64 = 0;
    const EWeaponTypeNotEquipped: u64 = 1;

    // === Constants ===

    // === Structs ===

    public struct ACT_WEAPON has drop {}

    public struct Equip has drop {}

    public struct Weapon has key, store {
        id: UID,
        name: String,
        image_url: String,
        image_hash: String,
        model_url: String,
        slot: String,
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        hash: String,
        wear_rating: u64,
        kill_count: u64,  
        upgrades: vector<Upgrade>
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

    public fun upgrade(
        self: &mut Weapon, 
        access_control: &AccessControl, 
        admin: &Admin, 
        name: String, 
        image: String        
    ) {
        act_admin::assert_upgrades_role(access_control, admin);
        self.upgrades.push_back(act_upgrade::new(name, image));        
    }

    // === Public-View Functions ===

    public fun slot(self: &Weapon): String {
        self.slot
    }

    public fun name(self: &Weapon): String {
        self.name
    }

    public fun image_url(self: &Weapon): String {
        self.image_url
    }

    public fun image_hash(self: &Weapon): String {
        self.image_hash
    }

    public fun model_url(self: &Weapon): String {
        self.model_url
    }

    public fun kill_count(self: &Weapon): u64 {
        self.kill_count
    }

    public fun edition(self: &Weapon): String {
        self.edition
    }

    public fun wear_rating(self: &Weapon): u64 {
        self.wear_rating
    }

    public fun colour_way(self: &Weapon): String {
        self.colour_way
    }

    public fun rarity(self: &Weapon): String {
        self.rarity
    }

    public fun manufacturer(self: &Weapon): String {
        self.manufacturer
    }

    public fun hash(self: &Weapon): String {
        self.hash
    }

    public fun upgrades(self: &Weapon): &vector<Upgrade> {
        &self.upgrades
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun new(
        name: String,
        image_url: String,
        image_hash: String,
        model_url: String,
        slot: String,
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        hash: String,
        wear_rating: u64,
        ctx: &mut TxContext,
    ): Weapon {
        Weapon {
            id: object::new(ctx),
            name,
            image_url,
            image_hash,
            model_url,
            slot,
            colour_way,
            edition,
            manufacturer,
            rarity,
            hash,
            wear_rating,
            kill_count: 0,
            upgrades: vector::empty(),
        }
    }

    public(package) fun equip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        weapon_id: ID, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,         
        policy: &TransferPolicy<Weapon>, // equipping policy
        ctx: &mut TxContext,
    ): String {
        assert!(!dof::exists_(uid_mut, key), EWeaponTypeAlreadyEquipped);

        kiosk.list<Weapon>(cap, weapon_id, 0);
        let coin = coin::zero<SUI>(ctx);
        let (weapon, mut request) = kiosk.purchase<Weapon>(weapon_id, coin);

        witness_rule::prove(Equip {}, policy, &mut request);
        policy.confirm_request(request);

        let name = weapon.name();

        dof::add(uid_mut, key, weapon);  

        name
    }

    public(package) fun unequip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,     
        policy: &TransferPolicy<Weapon>, // trading policy    
    ): String {
        assert!(dof::exists_(uid_mut, key), EWeaponTypeNotEquipped);
        let weapon = dof::remove<Key, Weapon>(uid_mut, key);

        let name = weapon.name();

        kiosk.lock(cap, policy, weapon);

        name
    }

    // === Private Functions ===

    // === Test Functions ===
}