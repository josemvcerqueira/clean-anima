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
        transfer::Receiving,
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
    public struct Registry has key {
        id: UID,
        // ctx.sender() => Account.id.uid_to_inner()
        accounts: Table<address, ID>
    }

    // "achievements" added to an account
    public struct Accolade has store {
        `type`: String,
        description: String,
        url: String
    }

    // "moderation" transferred to accounts
    public struct Reputation has key {
        id: UID,
        `type`: String,
        value: u64,
        positive: bool,
        description: String,
        url: String,
        issuer: ID,
    }

    // @dev key only ability to prevent transfers
    public struct Account has key {
        id: UID,
        alias: String,
        username: String, 
        creation_date: u64,
        accolades: TableVec<Accolade>,
    }

    // === Method Aliases ===

    // === Public-Mutative Functions ===

    fun init(ctx: &mut TxContext) {
        transfer::share_object(Registry {
            id: object::new(ctx),
            accounts: table::new(ctx)
        });
    }

    public fun new(
        registry: &mut Registry, 
        alias: String,
        username: String,
        clock: &Clock,
        ctx: &mut TxContext
    ): Account {
        // One Account per user
        registry.assert_no_avatar(ctx.sender());
        
        let account = Account {
            id: object::new(ctx),
            alias,
            username,
            creation_date: clock.timestamp_ms(),
            accolades: table_vec::empty(ctx),
        };

        registry.accounts.add(ctx.sender(), account.id.uid_to_inner());

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

    public fun assert_no_avatar(self: &Registry, addr: address) {
        assert!(!self.accounts.contains(addr), EAlreadyMintedAnAccount);
    }

    // === Admin Functions ===

    // can be sent by any player 
    public fun give_reputation(
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
            id: object::new(ctx),
            `type`,
            value,
            positive, 
            description,
            url,
            issuer: account.id.uid_to_inner(),
        };
        transfer::transfer(reputation, recipient);
    }

    public fun remove_reputation(
        self: &mut Account, 
        reputation: Receiving<Reputation>,
        access_control: &AccessControl, 
        admin: &Admin, 
    ) {
        admin::assert_reputation_role(access_control, admin);
        let reputation = transfer::receive(&mut self.id, reputation);
        let Reputation { id, .. } = reputation;
        id.delete();
    }

    public fun add_accolade(
        self: &mut Account, 
        access_control: &AccessControl, 
        admin: &Admin, 
        `type`: String,
        description: String,
        url: String        
    ) {
        admin::assert_accolades_role(access_control, admin);
        let accolade = Accolade {
            `type`,
            description,
            url
        };
        self.accolades.push_back(accolade);
    }

    public fun remove_accolade(
        self: &mut Account, 
        access_control: &AccessControl, 
        admin: &Admin, 
        idx: u64
    ) {
        admin::assert_accolades_role(access_control, admin);
        let accolade = self.accolades.swap_remove(idx);
        let Accolade { .. } = accolade;
    }

    // === Public-Package Functions ===

    // === Private Functions ===

    // === Test Functions === 

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(ctx);
    }

    #[test_only]
    public fun accounts(self: &Registry): &Table<address, ID> {
        &self.accounts
    }

    #[test_only]
    public fun accolades(self: &Account): &TableVec<Accolade> {
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
    public fun issuer(self: &Reputation): ID {
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