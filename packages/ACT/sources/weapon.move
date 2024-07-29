
//primary
//secondary
//tertiary
module act::weapon {
    // === Imports ===

    use std::string::String;
    use sui::{
        transfer_policy::TransferPolicy, 
        kiosk::{Kiosk, KioskOwnerCap},
        vec_map::{Self, VecMap},
    };
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };
    use act::{
        item,
        upgrade::{Self, Upgrade},
    };

    // === Constants ===

    // === Structs ===

    public struct WEAPON has drop {}

    public struct Equip has drop {}

    public struct Weapon has key, store {
        id: UID,
        hash: vector<u8>, // unique id of weapon type
        name: String,
        image_url: String,
        model_url: String,
        texture_url: String,
        slot: String,
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        wear_rating: u64,
        kill_count: u64,  
        upgrades: vector<Upgrade>,
        misc: VecMap<String, String>,
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    #[allow(lint(share_owned))]
    fun init(otw: WEAPON, ctx: &mut TxContext) {
        item::init_state<WEAPON, Equip, Weapon>(otw, b"ACT Weapon: {name}".to_string(), ctx);
    }

    public fun upgrade(
        self: &mut Weapon, 
        access_control: &AccessControl, 
        admin: &Admin, 
        url: String,
    ) {
        admin::assert_upgrades_role(access_control, admin);
        self.upgrades.push_back(upgrade::new(url));        
    }

    // === Public-View Functions ===

    public fun slot(self: &Weapon): String {
        self.slot
    }

    public fun hash(self: &Weapon): vector<u8> {
        self.hash
    }

    public fun name(self: &Weapon): String {
        self.name
    }

    public fun image_url(self: &Weapon): String {
        self.image_url
    }

    public fun model_url(self: &Weapon): String {
        self.model_url
    }

    public fun texture_url(self: &Weapon): String {
        self.texture_url
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

    public fun upgrades(self: &Weapon): &vector<Upgrade> {
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
        slot: String,
        colour_way: String,
        edition: String,
        manufacturer: String,
        rarity: String,
        wear_rating: u64,
        ctx: &mut TxContext,
    ): Weapon {
        Weapon {
            id: object::new(ctx),
            hash,
            name,
            image_url,
            model_url,
            texture_url,
            slot,
            colour_way,
            edition,
            manufacturer,
            rarity,
            wear_rating,
            kill_count: 0,
            upgrades: vector::empty(),
            misc: vec_map::empty(),
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
        let name = kiosk.borrow<Weapon>(cap, weapon_id).name;
        item::equip(uid_mut, key, weapon_id, kiosk, cap, policy, Equip {}, ctx);
        name
    }

    public(package) fun unequip<Key: store + copy + drop>(
        uid_mut: &mut UID, 
        key: Key, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,     
        policy: &TransferPolicy<Weapon>, // trading policy    
    ): String {
        let weapon_id = item::unequip(uid_mut, key, kiosk, cap, policy);
        kiosk.borrow<Weapon>(cap, weapon_id).name
    }

    // === Private Functions ===

    // === Test Functions ===

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(WEAPON {}, ctx);
    }
}