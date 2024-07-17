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
    use anima::{
        admin,
        access_control::{Admin, AccessControl},
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
    ) {
        // One Account per user
        registry.assert_no_avatar(ctx.sender());
        
        let avatar = Account {
            id: object::new(ctx),
            alias,
            username,
            creation_date: clock.timestamp_ms(),
            accolades: table_vec::empty(ctx),
        };

        registry.accounts.add(ctx.sender(), avatar.id.uid_to_inner());

        transfer::transfer(avatar, ctx.sender());
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
}