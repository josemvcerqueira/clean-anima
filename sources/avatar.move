/*
* @title Anima Avatar
*
* @description
* The Avatar is non-transferable / not decomposable. The account and avatar are one unit/
*
* Questions?!
* 1 - Who can add accolades/reputation? I assume it is via an AdminCap. Can they both be removed/add or just add?!
* 2 - What is the upgrades array in the Avatar object ?!
* 3 - What are the admin rights?! 
* 4 - Is the wear rating generated on-chain or off-chain?!
* 5 - Custom rule of personal_kiosk_rule or equip. Tradeport can ad d acustom rule but takes THEM TIME
* - issue two transfer policies?
*/
module act::act_avatar {
    // === Imports ===

    use std::string::{utf8, String};
    use sui::{
        package, 
        display,
        clock::Clock,
        table::{Self, Table},
        vec_map::VecMap,
        transfer_policy::TransferPolicy,
        dynamic_object_field as dof,
        kiosk::{Kiosk, KioskOwnerCap},
    };
    use act::{
        act_utils,
        act_admin,
        act_upgrade::{Self, Upgrade},
        act_weapon::{Self, Weapon}, 
        access_control::{Admin, AccessControl},
        act_cosmetic::{Self, Cosmetic}
    };

    // === Errors ===

    const EAlreadyMintedAnAvatar: u64 = 0;
    const EWeaponSlotAlreadyEquipped: u64 = 1;
    const ECosmeticSlotAlreadyEquipped: u64 = 2;
    const ECosmeticIsNotEquipped: u64 = 3;
    const EWeaponIsNotEquipped: u64 = 4;

    // === Constants ===

    // === Structs ===

    // one-time witness
    public struct ACT_AVATAR has drop {}

    // @dev Shared object to ensure we have one account per avatar
    public struct AvatarRegistry has key {
        id: UID,
        // ctx.sender() => Avatar.id.uid_to_inner()
        accounts: Table<address, ID>
    }
    
    public struct CosmeticKey(String) has copy, store, drop; 

    public struct WeaponKey(String) has copy, store, drop;

    public struct Accolade has store {
        `type`: String,
        description: String,
        link: String
    }

    public struct Reputation has store, drop {
        `type`: String,
        value: u64,
        positive: bool,
        description: String,
        link: String
    }

    // @dev key only ability to prevent transfers
    // We need to see how we will handle the Kiosk with Weapons and Cosmetics ?! 
    // Should the hold a Kiosk Owner Cap and when an item is on the Avatar Kiosk is considered equipped ?!
    // What rules should weapon and cosmetics have ?!
    public struct Avatar has key {
        id: UID,
        alias: String,
        username: String, 
        image_url: String,
        image_hash: String,
        avatar_url: String,
        `type`: String,
        creation_date: u64,
        reputation: vector<Reputation>,
        accolades: vector<Accolade>,
        upgrades: vector<Upgrade>,
        attributes: VecMap<String, String>
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(otw: ACT_AVATAR, ctx: &mut TxContext) {
        let avatar_registry = AvatarRegistry {
            id: object::new(ctx),
            accounts: table::new(ctx)
        };

        transfer::share_object(avatar_registry);

        let keys = vector[
            utf8(b"name"),
            utf8(b"description"),
            utf8(b"image_url"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];
        let values = vector[
            utf8(b"ACT Avatar: {alias}"),
            utf8(b"ACT is a fast-paced, high-skill multiplayer FPS"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"https://animalabs.io"), // to change with ACT game page
            utf8(b"Anima Labs"),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<Avatar>(
            &publisher, keys, values, ctx
        );
        display.update_version();

        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }

    public fun new(
        registry: &mut AvatarRegistry, 
        alias: String,
        username: String,
        image_url: String,
        image_hash: String,
        avatar_url: String,
        `type`: String,
        clock: &Clock,
        ctx: &mut TxContext
    ) {
        // One Avatar per user
        assert!(!registry.accounts.contains(ctx.sender()), EAlreadyMintedAnAvatar);

        let avatar = Avatar {
            id: object::new(ctx),
            alias,
            username,
            image_url,
            image_hash,
            avatar_url,
            `type`,
            creation_date: clock.timestamp_ms(),
            reputation: vector[],
            accolades: vector[],
            upgrades: vector[],
            attributes: act_utils::init_attributes(),
        };

        transfer::transfer(avatar, ctx.sender());
    }

    // used during the mint in a ptb
    public fun equip_minted_weapon(self: &mut Avatar, weapon: Weapon) {
        assert!(!dof::exists_(&self.id, WeaponKey(weapon.slot())), EWeaponSlotAlreadyEquipped);

        let cosmetic_val = self.attributes.get_mut(&weapon.slot());
        *cosmetic_val = weapon.name();

        dof::add(&mut self.id, WeaponKey(weapon.slot()), weapon)  
    }

    // used during the mint in a ptb
    public fun equip_minted_cosmetic(self: &mut Avatar, cosmetic: Cosmetic) {
        assert!(!dof::exists_(&self.id, CosmeticKey(cosmetic.type_())), ECosmeticSlotAlreadyEquipped);

        let cosmetic_val = self.attributes.get_mut(&cosmetic.type_());
        *cosmetic_val = cosmetic.name();

        dof::add(&mut self.id, CosmeticKey(cosmetic.type_()), cosmetic)  
    }

    public fun equip_weapon(
        self: &mut Avatar, 
        weapon_id: ID,
        weapon_slot: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // equipping policy
        ctx: &mut TxContext
    ) {
        let weapon_val = self.attributes.get_mut(&weapon_slot);

        *weapon_val = act_weapon::equip(
            &mut self.id, 
            WeaponKey(weapon_slot), 
            weapon_id, 
            kiosk,
            cap,
            policy,
            ctx
        );
    }

    public fun equip_cosmetic(
        self: &mut Avatar, 
        cosmetic_id: ID,
        cosmetic_type: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Cosmetic>, // equipping policy
        ctx: &mut TxContext
    ) {
        let cosmetic_val = self.attributes.get_mut(&cosmetic_type);

        *cosmetic_val = act_cosmetic::equip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            cosmetic_id, 
            kiosk,
            cap,
            policy,
            ctx
        );
    }

    public fun unequip_weapon(
        self: &mut Avatar, 
        weapon_slot: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Weapon>, // trading policy
    ) {
        let weapon_val = self.attributes.get_mut(&weapon_slot);
        *weapon_val = utf8(b"");

        act_weapon::unequip(
            &mut self.id, 
            WeaponKey(weapon_slot), 
            kiosk,
            cap,
            policy,
        );
    }

    public fun unequip_cosmetic(
        self: &mut Avatar, 
        cosmetic_type: String,
        kiosk: &mut Kiosk,
        cap: &KioskOwnerCap,
        policy: &TransferPolicy<Cosmetic>, // trading policy
    ) {
        let cosmetic_val = self.attributes.get_mut(&cosmetic_type);
        *cosmetic_val = utf8(b"");

        act_cosmetic::unequip(
            &mut self.id, 
            CosmeticKey(cosmetic_type), 
            kiosk,
            cap,
            policy,
        );
    }

    // === Public-View Functions ===

    public fun alias(self: &Avatar): String {
        self.alias
    }

    public fun username(self: &Avatar): String {
        self.username
    }

    public fun image_url(self: &Avatar): String {
        self.image_url
    }

    public fun image_hash(self: &Avatar): String {
        self.image_hash
    }

    public fun avatar_url(self: &Avatar): String {
        self.avatar_url
    }    

    public fun type_(self: &Avatar): String {
        self.`type`
    }

    public fun creation_date(self: &Avatar): u64 {
        self.creation_date
    }

    public fun reputation(self: &Avatar): &vector<Reputation> {
        &self.reputation
    }

    public fun accolades(self: &Avatar): &vector<Accolade> {
        &self.accolades
    }

    public fun upgrades(self: &Avatar): &vector<Upgrade> {
        &self.upgrades
    }

    public fun attributes(self: &Avatar): &VecMap<String, String>{
        &self.attributes
    }

    // === Admin Functions ===

    public fun upgrade(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        name: String, 
        image: String
    ) {
        act_admin::assert_upgrades_role(access_control, admin);
        self.upgrades.push_back(act_upgrade::new(name, image));
    }

    public fun upgrade_equipped_cosmetic(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        `type`: String,
        name: String, 
        image: String        
    ) {
        act_admin::assert_upgrades_role(access_control, admin);
        assert!(dof::exists_(&self.id, CosmeticKey(`type`)), ECosmeticIsNotEquipped);
        let cosmetic = dof::borrow_mut<CosmeticKey, Cosmetic>(&mut self.id, CosmeticKey(`type`)); 
        cosmetic.upgrade(access_control, admin, name, image);   
    }

    public fun upgrade_equipped_weapon(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        slot: String,
        name: String, 
        image: String        
    ) {
        act_admin::assert_upgrades_role(access_control, admin);
        assert!(dof::exists_(&self.id, WeaponKey(slot)), EWeaponIsNotEquipped);
        let weapon = dof::borrow_mut<WeaponKey, Weapon>(&mut self.id, WeaponKey(slot)); 
        weapon.upgrade(access_control, admin, name, image);   
    }

    public fun add_reputation(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        `type`: String,
        value: u64,
        positive: bool,
        description: String,
        link: String
    ) {
        act_admin::assert_reputation_role(access_control, admin);
        let reputation = Reputation {
            `type`,
            value,
            positive, 
            description,
            link
        };
        self.reputation.push_back(reputation);
    }

    public fun remove_reputation(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        idx: u64
    ) {
        act_admin::assert_reputation_role(access_control, admin);
        self.reputation.remove(idx);
    }

    public fun add_accolade(
        self: &mut Avatar, 
        access_control: &AccessControl, 
        admin: &Admin, 
        `type`: String,
        description: String,
        link: String        
    ) {
        act_admin::assert_accolades_role(access_control, admin);
        let accolade = Accolade {
            `type`,
            description,
            link
        };
        self.accolades.push_back(accolade);
    }

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions === 
}