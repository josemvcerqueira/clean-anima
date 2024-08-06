module act::cosmetic {
    // === Imports ===

    use std::string::String;
    use sui::{
        kiosk::{Kiosk, KioskOwnerCap},
        transfer_policy::TransferPolicy, 
        vec_map::{Self, VecMap},
        transfer::{public_receive, Receiving}
    };
    use act::{
        item,
        upgrade::{Upgrade, LockedUpgrade},
    };

    // === Constants ===

    // === Structs ===

    public struct COSMETIC has drop {}

    public struct Equip has drop {}

    public struct Cosmetic has key, store {
        id: UID,
        hash: vector<u8>, // unique id of cosmetic type
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
        upgrades: vector<Upgrade>,
        misc: VecMap<String, String>,
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    #[allow(lint(share_owned))]
    fun init(otw: COSMETIC, ctx: &mut TxContext) {
        item::init_state<COSMETIC, Equip, Cosmetic>(otw, b"ACT Cosmetic: {name}".to_string(), ctx);
    }


    public fun upgrade(
        self: &mut Cosmetic, 
        receiving: Receiving<LockedUpgrade>
    ) {
        assert!(2 > self.upgrades.length());
        let locked_upgrade = public_receive(&mut self.id, receiving);
        let upgrade = locked_upgrade.destroy();

        self.image_url = upgrade.image_url();
        self.model_url = upgrade.model_url();
        self.texture_url = upgrade.texture_url();

        self.upgrades.push_back(upgrade);    
    }

    // === Public-View Functions ===

    public fun type_(self: &Cosmetic): String {
        self.`type`
    }

    public fun hash(self: &Cosmetic): vector<u8> {
        self.hash
    }

    public fun name(self: &Cosmetic): String {
        self.name
    }

    public fun image_url(self: &Cosmetic): String {
        self.image_url
    }

    public fun model_url(self: &Cosmetic): String {
        self.model_url
    }

    public fun texture_url(self: &Cosmetic): String {
        self.texture_url
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

    public fun upgrades(self: &Cosmetic): &vector<Upgrade> {
        &self.upgrades
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

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
            colour_way,
            edition,
            manufacturer,
            rarity,
            wear_rating,
            upgrades: vector[],
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
