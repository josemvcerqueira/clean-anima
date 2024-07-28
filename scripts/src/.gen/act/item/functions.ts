import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {ID} from "../../_dependencies/source/0x2/object/structs";
import {GenericArg, generic, obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export interface EquipArgs { uidMut: TransactionObjectInput; key: GenericArg; itemId: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput; rule: GenericArg }

export function equip( tx: Transaction, typeArgs: [string, string, string], args: EquipArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::item::equip`, typeArguments: typeArgs, arguments: [ obj(tx, args.uidMut), generic(tx, `${typeArgs[0]}`, args.key), pure(tx, args.itemId, `${ID.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy), generic(tx, `${typeArgs[1]}`, args.rule) ], }) }

export interface InitStateArgs { otw: GenericArg; name: string | TransactionArgument }

export function initState( tx: Transaction, typeArgs: [string, string, string], args: InitStateArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::item::init_state`, typeArguments: typeArgs, arguments: [ generic(tx, `${typeArgs[0]}`, args.otw), pure(tx, args.name, `${String.$typeName}`) ], }) }

export interface UnequipArgs { uidMut: TransactionObjectInput; key: GenericArg; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function unequip( tx: Transaction, typeArgs: [string, string], args: UnequipArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::item::unequip`, typeArguments: typeArgs, arguments: [ obj(tx, args.uidMut), generic(tx, `${typeArgs[0]}`, args.key), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }
