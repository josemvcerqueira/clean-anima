import {PUBLISHED_AT} from "..";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export interface ContainsArgs { self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function contains( tx: Transaction, args: ContainsArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::contains`, arguments: [ obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export function destroyEmpty( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::destroy_empty`, arguments: [ obj(tx, self) ], }) }

export interface RemoveArgs { admin: TransactionObjectInput; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function remove( tx: Transaction, args: RemoveArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::remove`, arguments: [ obj(tx, args.admin), obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export function new_( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::new`, arguments: [ ], }) }

export interface AddArgs { admin: TransactionObjectInput; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function add( tx: Transaction, args: AddArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::add`, arguments: [ obj(tx, args.admin), obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export interface DestroyArgs { admin: TransactionObjectInput; self: TransactionObjectInput }

export function destroy( tx: Transaction, args: DestroyArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::destroy`, arguments: [ obj(tx, args.admin), obj(tx, args.self) ], }) }

export function accessControl( tx: Transaction, admin: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::access_control`, arguments: [ obj(tx, admin) ], }) }

export function addy( tx: Transaction, admin: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::addy`, arguments: [ obj(tx, admin) ], }) }

export interface AdminHasRoleArgs { admin: TransactionObjectInput; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function adminHasRole( tx: Transaction, args: AdminHasRoleArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::admin_has_role`, arguments: [ obj(tx, args.admin), obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export interface AssertSuperAdminArgs { admin: TransactionObjectInput; self: TransactionObjectInput }

export function assertSuperAdmin( tx: Transaction, args: AssertSuperAdminArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::assert_super_admin`, arguments: [ obj(tx, args.admin), obj(tx, args.self) ], }) }

export function destroyAccount( tx: Transaction, admin: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::destroy_account`, arguments: [ obj(tx, admin) ], }) }

export interface GrantArgs { admin: TransactionObjectInput; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument; newAdmin: string | TransactionArgument }

export function grant( tx: Transaction, args: GrantArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::grant`, arguments: [ obj(tx, args.admin), obj(tx, args.self), pure(tx, args.role, `vector<u8>`), pure(tx, args.newAdmin, `address`) ], }) }

export function newAdmin( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::new_admin`, arguments: [ obj(tx, self) ], }) }

export interface HasRoleArgs { admin: TransactionObjectInput; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function hasRole( tx: Transaction, args: HasRoleArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::has_role`, arguments: [ obj(tx, args.admin), obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export interface HasRole_Args { adminAddress: string | TransactionArgument; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function hasRole_( tx: Transaction, args: HasRole_Args ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::has_role_`, arguments: [ pure(tx, args.adminAddress, `address`), obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export interface NewRoleImplArgs { self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function newRoleImpl( tx: Transaction, args: NewRoleImplArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::new_role_impl`, arguments: [ obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export interface NewRoleSingletonImplArgs { self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument; recipient: string | TransactionArgument }

export function newRoleSingletonImpl( tx: Transaction, args: NewRoleSingletonImplArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::new_role_singleton_impl`, arguments: [ obj(tx, args.self), pure(tx, args.role, `vector<u8>`), pure(tx, args.recipient, `address`) ], }) }

export interface RenounceArgs { admin: TransactionObjectInput; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument }

export function renounce( tx: Transaction, args: RenounceArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::renounce`, arguments: [ obj(tx, args.admin), obj(tx, args.self), pure(tx, args.role, `vector<u8>`) ], }) }

export interface RevokeArgs { admin: TransactionObjectInput; self: TransactionObjectInput; role: Array<number | TransactionArgument> | TransactionArgument; oldAdmin: string | TransactionArgument }

export function revoke( tx: Transaction, args: RevokeArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::revoke`, arguments: [ obj(tx, args.admin), obj(tx, args.self), pure(tx, args.role, `vector<u8>`), pure(tx, args.oldAdmin, `address`) ], }) }

export function superAdminRole( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::access_control::super_admin_role`, arguments: [ ], }) }
