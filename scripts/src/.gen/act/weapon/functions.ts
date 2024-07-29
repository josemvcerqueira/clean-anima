import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {ID} from "../../_dependencies/source/0x2/object/structs";
import {GenericArg, generic, obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export function hash( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::hash`, arguments: [ obj(tx, self) ], }) }

export interface NewArgs { hash: Array<number | TransactionArgument> | TransactionArgument; name: string | TransactionArgument; imageUrl: string | TransactionArgument; modelUrl: string | TransactionArgument; textureUrl: string | TransactionArgument; slot: string | TransactionArgument; colourWay: string | TransactionArgument; edition: string | TransactionArgument; manufacturer: string | TransactionArgument; rarity: string | TransactionArgument; wearRating: bigint | TransactionArgument }

export function new_( tx: Transaction, args: NewArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::new`, arguments: [ pure(tx, args.hash, `vector<u8>`), pure(tx, args.name, `${String.$typeName}`), pure(tx, args.imageUrl, `${String.$typeName}`), pure(tx, args.modelUrl, `${String.$typeName}`), pure(tx, args.textureUrl, `${String.$typeName}`), pure(tx, args.slot, `${String.$typeName}`), pure(tx, args.colourWay, `${String.$typeName}`), pure(tx, args.edition, `${String.$typeName}`), pure(tx, args.manufacturer, `${String.$typeName}`), pure(tx, args.rarity, `${String.$typeName}`), pure(tx, args.wearRating, `u64`) ], }) }

export function name( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::name`, arguments: [ obj(tx, self) ], }) }

export interface UpgradeArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; url: string | TransactionArgument }

export function upgrade( tx: Transaction, args: UpgradeArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::upgrade`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.url, `${String.$typeName}`) ], }) }

export function init( tx: Transaction, otw: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::init`, arguments: [ obj(tx, otw) ], }) }

export interface EquipArgs { uidMut: TransactionObjectInput; key: GenericArg; weaponId: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function equip( tx: Transaction, typeArg: string, args: EquipArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::equip`, typeArguments: [typeArg], arguments: [ obj(tx, args.uidMut), generic(tx, `${typeArg}`, args.key), pure(tx, args.weaponId, `${ID.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface UnequipArgs { uidMut: TransactionObjectInput; key: GenericArg; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function unequip( tx: Transaction, typeArg: string, args: UnequipArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::unequip`, typeArguments: [typeArg], arguments: [ obj(tx, args.uidMut), generic(tx, `${typeArg}`, args.key), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export function colourWay( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::colour_way`, arguments: [ obj(tx, self) ], }) }

export function edition( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::edition`, arguments: [ obj(tx, self) ], }) }

export function imageUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::image_url`, arguments: [ obj(tx, self) ], }) }

export function killCount( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::kill_count`, arguments: [ obj(tx, self) ], }) }

export function manufacturer( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::manufacturer`, arguments: [ obj(tx, self) ], }) }

export function modelUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::model_url`, arguments: [ obj(tx, self) ], }) }

export function textureUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::texture_url`, arguments: [ obj(tx, self) ], }) }

export function slot( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::slot`, arguments: [ obj(tx, self) ], }) }

export function rarity( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::rarity`, arguments: [ obj(tx, self) ], }) }

export function wearRating( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::wear_rating`, arguments: [ obj(tx, self) ], }) }

export function upgrades( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::weapon::upgrades`, arguments: [ obj(tx, self) ], }) }
