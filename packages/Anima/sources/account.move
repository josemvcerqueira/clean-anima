/*
* @title Anima Account
*
* @description
* The Account is non-transferable / not decomposable. 
*
*/
module anima::account {
    // === Imports ===

    use std::string::String;
    use sui::{
        clock::Clock,
        table::{Self, Table},
        table_vec::{Self, TableVec},
    };
    use animalib::{
        access_control::{Admin, AccessControl},
        admin,
    };

    // === Errors ===

    const EAlreadyMintedAnAccount: u64 = 0;

    // === Constants ===

    // === Structs ===

    // @dev Shared object to ensure we have one account per user
    public struct System has key {
        id: UID,
        // ctx.sender() => Account.id.uid_to_inner()
        accounts: Table<address, address>,
        accolades: Table<address, TableVec<Accolade>>,
        reputation: Table<address, TableVec<Reputation>>
    }

    // "achievements" added to an account
    public struct Accolade has store, drop {
        `type`: String,
        description: String,
        url: String
    }

    // "moderation" transferred to accounts
    public struct Reputation has store, drop {
        `type`: String,
        value: u64,
        positive: bool,
        description: String,
        url: String,
        issuer: address,
    }

    // @dev key only ability to prevent transfers
    public struct Account has key {
        id: UID,
        alias: String,
        username: String, 
        creation_date: u64,
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(ctx: &mut TxContext) {
        transfer::share_object(System {
            id: object::new(ctx),
            accounts: table::new(ctx),
            accolades: table::new(ctx),
            reputation: table::new(ctx)
        });
    }

    public fun new(
        system: &mut System, 
        alias: String,
        username: String,
        clock: &Clock,
        ctx: &mut TxContext
    ): Account {
        // One Account per user
        system.assert_no_avatar(ctx.sender());
        
        let account = Account {
            id: object::new(ctx),
            alias,
            username,
            creation_date: clock.timestamp_ms(),
        };

        system.accounts.add(ctx.sender(), account.id.to_address());

        account
    }

    public fun keep(self: Account, ctx: &TxContext) {
        transfer::transfer(self, ctx.sender());
    }

    public fun update_alias(self: &mut Account, alias: String) {
        self.alias = alias;
    }

    public fun update_username(self: &mut Account, username: String) {
        self.username = username;
    }

    // === Public-View Functions ===

    public fun alias(self: &Account): String {
        self.alias
    }

    public fun username(self: &Account): String {
        self.username
    }

    public fun creation_date(self: &Account): u64 {
        self.creation_date
    }

    public fun assert_no_avatar(self: &System, addr: address) {
        assert!(!self.accounts.contains(addr), EAlreadyMintedAnAccount);
    }

    // === Admin Functions ===

    // can be sent by any player 
    public fun give_reputation(
        system: &mut System,
        account: &Account,
        recipient: address,
        `type`: String,
        value: u64,
        positive: bool,
        description: String,
        url: String,
        ctx: &mut TxContext
    ) {
        let reputation = Reputation {
            `type`,
            value,
            positive, 
            description,
            url,
            issuer: account.id.to_address(),
        };
        
        if (!system.reputation.contains(recipient))
            system.reputation.add(recipient, table_vec::empty(ctx));
        
        system.reputation.borrow_mut(recipient).push_back(reputation);
    }

    public fun remove_reputation(
        system: &mut System,
        access_control: &AccessControl, 
        admin: &Admin, 
        account: address, 
        index: u64,
    ) {
        admin::assert_reputation_role(access_control, admin);
        system.reputation.borrow_mut(account).swap_remove(index);
    }

    public fun add_accolade(
        system: &mut System, 
        access_control: &AccessControl, 
        admin: &Admin, 
        recipient: address,
        `type`: String,
        description: String,
        url: String,
        ctx: &mut TxContext        
    ) {
        admin::assert_accolades_role(access_control, admin);
        let accolade = Accolade {
            `type`,
            description,
            url
        };

        if (!system.accolades.contains(recipient))
            system.accolades.add(recipient, table_vec::empty(ctx));

        system.accolades.borrow_mut(recipient).push_back(accolade);
    }

    public fun remove_accolade(
        system: &mut System,
        access_control: &AccessControl, 
        admin: &Admin, 
        account: address, 
        index: u64,
    ) {
        admin::assert_accolades_role(access_control, admin);
        system.accolades.borrow_mut(account).swap_remove(index);
    }

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions === 

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx);
    }

    #[test_only]
    public fun reputation(self: &System): &Table<address, TableVec<Reputation>> {
        &self.reputation
    }

    #[test_only]
    public fun accounts(self: &System): &Table<address, address> {
        &self.accounts
    }

    #[test_only]
    public fun accolades(self: &System): &Table<address, TableVec<Accolade>> {
        &self.accolades
    }
    
    #[test_only]
    public use fun accolade_type as Accolade.type_;
    #[test_only]
    public fun accolade_type(self: &Accolade): String {
        self.`type`
    }

    #[test_only]
    public use fun accolade_description as Accolade.description;
    #[test_only]
    public fun accolade_description(self: &Accolade): String {
        self.description
    }

    #[test_only]
    public use fun accolade_url as Accolade.url;
    #[test_only]
    public fun accolade_url(self: &Accolade): String {
        self.url
    }

    #[test_only]
    public use fun reputation_type as Reputation.type_;
    #[test_only]
    public fun reputation_type(self: &Reputation): String {
        self.`type`
    }

    #[test_only]
    public fun value(self: &Reputation): u64 {
        self.value
    }

    #[test_only]
    public fun positive(self: &Reputation): bool {
        self.positive
    }

    #[test_only]
    public fun issuer(self: &Reputation): address {
        self.issuer
    }

    #[test_only]
    public use fun reputation_description as Reputation.description;
    #[test_only]
    public fun reputation_description(self: &Reputation): String {
        self.description
    }

    #[test_only]
    public use fun reputation_url as Reputation.url;
    #[test_only]
    public fun reputation_url(self: &Reputation): String {
        self.url
    }
}