import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export interface NewArgs { registry: TransactionObjectInput; alias: string | TransactionArgument; username: string | TransactionArgument; clock: TransactionObjectInput }

export function new_( tx: Transaction, args: NewArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::new`, arguments: [ obj(tx, args.registry), pure(tx, args.alias, `${String.$typeName}`), pure(tx, args.username, `${String.$typeName}`), obj(tx, args.clock) ], }) }

export function keep( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::keep`, arguments: [ obj(tx, self) ], }) }

export function init( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::init`, arguments: [ ], }) }

export interface AssertNoAvatarArgs { self: TransactionObjectInput; addr: string | TransactionArgument }

export function assertNoAvatar( tx: Transaction, args: AssertNoAvatarArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::assert_no_avatar`, arguments: [ obj(tx, args.self), pure(tx, args.addr, `address`) ], }) }

export interface AddAccoladeArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; type: string | TransactionArgument; description: string | TransactionArgument; url: string | TransactionArgument }

export function addAccolade( tx: Transaction, args: AddAccoladeArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::add_accolade`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.type, `${String.$typeName}`), pure(tx, args.description, `${String.$typeName}`), pure(tx, args.url, `${String.$typeName}`) ], }) }

export function alias( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::alias`, arguments: [ obj(tx, self) ], }) }

export function creationDate( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::creation_date`, arguments: [ obj(tx, self) ], }) }

export interface GiveReputationArgs { account: TransactionObjectInput; recipient: string | TransactionArgument; type: string | TransactionArgument; value: bigint | TransactionArgument; positive: boolean | TransactionArgument; description: string | TransactionArgument; url: string | TransactionArgument }

export function giveReputation( tx: Transaction, args: GiveReputationArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::give_reputation`, arguments: [ obj(tx, args.account), pure(tx, args.recipient, `address`), pure(tx, args.type, `${String.$typeName}`), pure(tx, args.value, `u64`), pure(tx, args.positive, `bool`), pure(tx, args.description, `${String.$typeName}`), pure(tx, args.url, `${String.$typeName}`) ], }) }

export function username( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::username`, arguments: [ obj(tx, self) ], }) }

export interface RemoveAccoladeArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; idx: bigint | TransactionArgument }

export function removeAccolade( tx: Transaction, args: RemoveAccoladeArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::remove_accolade`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.idx, `u64`) ], }) }

export interface RemoveReputationArgs { self: TransactionObjectInput; reputation: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput }

export function removeReputation( tx: Transaction, args: RemoveReputationArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::remove_reputation`, arguments: [ obj(tx, args.self), obj(tx, args.reputation), obj(tx, args.accessControl), obj(tx, args.admin) ], }) }

export interface UpdateAliasArgs { self: TransactionObjectInput; alias: string | TransactionArgument }

export function updateAlias( tx: Transaction, args: UpdateAliasArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::update_alias`, arguments: [ obj(tx, args.self), pure(tx, args.alias, `${String.$typeName}`) ], }) }

export interface UpdateUsernameArgs { self: TransactionObjectInput; username: string | TransactionArgument }

export function updateUsername( tx: Transaction, args: UpdateUsernameArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::account::update_username`, arguments: [ obj(tx, args.self), pure(tx, args.username, `${String.$typeName}`) ], }) }
