module act::cosmetic {
    // === Imports ===

    use std::string::String;
    use sui::{
        kiosk::{Kiosk, KioskOwnerCap},
        transfer_policy::TransferPolicy, 
        vec_map::{Self, VecMap},
    };
    use act::{
        item,
        attributes,
    };

    // === Structs ===

    public struct COSMETIC has drop {}

    public struct Equip has drop {}

    public struct Cosmetic has key, store {
        id: UID,
        hash: vector<u8>, 
        name: String,
        image_url: String,
        model_url: String,
        texture_url: String,
        `type`: String, 
        formatted_type: String,
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        wear_rating: u64,
        misc: VecMap<String, String>,
    }

    // === Public-Mutative Functions ===

    #[allow(lint(share_owned))]
    fun init(otw: COSMETIC, ctx: &mut TxContext) {
        item::init_state<COSMETIC, Equip, Cosmetic>(
            otw, 
            b"{name} {formatted_type}".to_string(),
            b"A cosmetic built in the laser forges of ACT, an Anima Nexus world.".to_string(), 
            ctx
        );
    }

    // === Public-Package Functions ===

    public(package) fun type_(self: &Cosmetic): String {
        self.`type`
    }

    public(package) fun formatted_type(self: &Cosmetic): String {
        self.formatted_type
    }

    public(package) fun hash(self: &Cosmetic): vector<u8> {
        self.hash
    }

    public(package) fun name(self: &Cosmetic): String {
        self.name
    }

    public(package) fun image_url(self: &Cosmetic): String {
        self.image_url
    }

    public(package) fun model_url(self: &Cosmetic): String {
        self.model_url
    }

    public(package) fun texture_url(self: &Cosmetic): String {
        self.texture_url
    }

    public(package) fun edition(self: &Cosmetic): String {
        self.edition
    }

    public(package) fun wear_rating(self: &Cosmetic): u64 {
        self.wear_rating
    }

    public(package) fun colour_way(self: &Cosmetic): String {
        self.colour_way
    }

    public(package) fun rarity(self: &Cosmetic): String {
        self.rarity
    }

    public(package) fun manufacturer(self: &Cosmetic): String {
        self.manufacturer
    }

    public(package) fun new(
        hash: vector<u8>,
        name: String,
        image_url: String,
        model_url: String,
        texture_url: String,
        `type`: String, 
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        wear_rating: u64, // [0,1] scaled to 1B
        ctx: &mut TxContext
    ): Cosmetic {
        Cosmetic {
            id: object::new(ctx),
            hash,
            name,
            image_url,
            model_url,
            texture_url,
            `type`,
            formatted_type: attributes::make_formatted_type(`type`),
            colour_way,
            edition,
            manufacturer,
            rarity,
            wear_rating,
            misc: vec_map::empty(),
        }   
    }

    public(package) fun equip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        cosmetic_id: ID, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,         
        policy: &TransferPolicy<Cosmetic>, // equipping policy
        ctx: &mut TxContext,
    ): (String, String, vector<u8>) {
        let cosmetic = kiosk.borrow<Cosmetic>(cap, cosmetic_id);
        let name = cosmetic.name;
        let type_ = cosmetic.`type`;
        let hash = cosmetic.hash;
        item::equip(uid_mut, key, cosmetic_id, kiosk, cap, policy, Equip {}, ctx);
        (name, type_, hash)
    }

    public(package) fun unequip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,     
        policy: &TransferPolicy<Cosmetic>, // trading policy    
    ): String {
        let cosmetic_id = item::unequip(uid_mut, key, kiosk, cap, policy);
        kiosk.borrow<Cosmetic>(cap, cosmetic_id).name
    }

    // === Private Functions ===

    // === Test Functions ===

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(COSMETIC {}, ctx);
    }
}
