module act::item {
    // === Imports ===

    use std::string::String;
    use sui::{
        package, 
        display, 
        coin,
        sui::SUI,
        types::is_one_time_witness,
        transfer_policy::{Self, TransferPolicy}, 
        dynamic_object_field as dof,
        kiosk::{Kiosk, KioskOwnerCap},
    };
    use kiosk::{
        witness_rule, 
        royalty_rule, 
        personal_kiosk,
        kiosk_lock_rule, 
        personal_kiosk_rule
    };
    
    // === Errors ===

    const ENotAOneTimeWitness: u64 = 0;
    const EItemTypeAlreadyEquipped: u64 = 1;
    const EItemTypeNotEquipped: u64 = 2;
    const EMustBeAPersonalKiosk: u64 = 3;

    // === Public-Mutative Functions ===

    #[allow(lint(share_owned, self_transfer))]
    public(package) fun init_state<OTW: drop, Rule: drop, Item: key + store>(
        otw: OTW, 
        name: String, 
        description: String,
        ctx: &mut TxContext
    ) {
        assert!(is_one_time_witness(&otw), ENotAOneTimeWitness);

        // create Display
        let keys = vector[
            b"name".to_string(),
            b"description".to_string(),
            b"image_url".to_string(),
            b"project_url".to_string(),
            b"creator".to_string(),
        ];
        let values = vector[
            name,
            description,
            b"ipfs://{image_url}".to_string(),
            b"https://animalabs.io".to_string(), // TODO: change with ACT game page
            b"Anima Labs".to_string(),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<Item>(
            &publisher, keys, values, ctx
        );
        display.update_version();
        transfer::public_transfer(display, ctx.sender());

        // create TransferPolicy for trading
        let (mut policy, cap) = transfer_policy::new<Item>(&publisher, ctx);
        royalty_rule::add(&mut policy, &cap, 100, 0); // % royalty?
        kiosk_lock_rule::add(&mut policy, &cap);
        personal_kiosk_rule::add(&mut policy, &cap);
        transfer::public_share_object(policy);
        transfer::public_transfer(cap, ctx.sender());

        // create TransferPolicy for equipping 
        let (mut policy, cap) = transfer_policy::new<Item>(&publisher, ctx);
        witness_rule::add<Item, Rule>(&mut policy, &cap);
        transfer::public_share_object(policy);
        transfer::public_transfer(cap, ctx.sender());

        transfer::public_transfer(publisher, ctx.sender());
    }

    // === Admin Functions ===

    // === Public-Package Functions ===

    public(package) fun equip<Key: store + copy + drop, Rule: drop, Item: key + store>(
        uid_mut: &mut UID, 
        key: Key, 
        item_id: ID, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,         
        policy: &TransferPolicy<Item>, // equipping policy
        rule: Rule,
        ctx: &mut TxContext,
    ) {
        assert!(!dof::exists_(uid_mut, key), EItemTypeAlreadyEquipped);

        kiosk.list<Item>(cap, item_id, 0);
        let coin = coin::zero<SUI>(ctx);
        let (item, mut request) = kiosk.purchase<Item>(item_id, coin);

        witness_rule::prove(rule, policy, &mut request);
        policy.confirm_request(request);

        dof::add(uid_mut, key, item); 
    }

    public(package) fun unequip<Key: store + copy + drop, Item: key + store>(
        uid_mut: &mut UID, 
        key: Key, 
        kiosk: &mut Kiosk, 
        cap: &KioskOwnerCap,     
        policy: &TransferPolicy<Item>, // trading policy    
    ): ID {
        assert!(dof::exists_(uid_mut, key), EItemTypeNotEquipped);
        let item = dof::remove<Key, Item>(uid_mut, key);

        let item_id = object::id(&item);

        assert!(personal_kiosk::is_personal(kiosk), EMustBeAPersonalKiosk);

        kiosk.lock(cap, policy, item);
        item_id
    }

    // === Private Functions ===
}

