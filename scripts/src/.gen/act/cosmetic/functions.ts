import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {ID} from "../../_dependencies/source/0x2/object/structs";
import {GenericArg, generic, obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export function hash( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::hash`, arguments: [ obj(tx, self) ], }) }

export interface NewArgs { hash: Array<number | TransactionArgument> | TransactionArgument; name: string | TransactionArgument; imageUrl: string | TransactionArgument; modelUrl: string | TransactionArgument; textureUrl: string | TransactionArgument; type: string | TransactionArgument; colourWay: string | TransactionArgument; edition: string | TransactionArgument; manufacturer: string | TransactionArgument; rarity: string | TransactionArgument; wearRating: bigint | TransactionArgument }

export function new_( tx: Transaction, args: NewArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::new`, arguments: [ pure(tx, args.hash, `vector<u8>`), pure(tx, args.name, `${String.$typeName}`), pure(tx, args.imageUrl, `${String.$typeName}`), pure(tx, args.modelUrl, `${String.$typeName}`), pure(tx, args.textureUrl, `${String.$typeName}`), pure(tx, args.type, `${String.$typeName}`), pure(tx, args.colourWay, `${String.$typeName}`), pure(tx, args.edition, `${String.$typeName}`), pure(tx, args.manufacturer, `${String.$typeName}`), pure(tx, args.rarity, `${String.$typeName}`), pure(tx, args.wearRating, `u64`) ], }) }

export function name( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::name`, arguments: [ obj(tx, self) ], }) }

export function type_( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::type_`, arguments: [ obj(tx, self) ], }) }

export interface UpgradeArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; url: string | TransactionArgument }

export function upgrade( tx: Transaction, args: UpgradeArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::upgrade`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.url, `${String.$typeName}`) ], }) }

export function init( tx: Transaction, otw: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::init`, arguments: [ obj(tx, otw) ], }) }

export interface EquipArgs { uidMut: TransactionObjectInput; key: GenericArg; cosmeticId: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function equip( tx: Transaction, typeArg: string, args: EquipArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::equip`, typeArguments: [typeArg], arguments: [ obj(tx, args.uidMut), generic(tx, `${typeArg}`, args.key), pure(tx, args.cosmeticId, `${ID.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface UnequipArgs { uidMut: TransactionObjectInput; key: GenericArg; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function unequip( tx: Transaction, typeArg: string, args: UnequipArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::unequip`, typeArguments: [typeArg], arguments: [ obj(tx, args.uidMut), generic(tx, `${typeArg}`, args.key), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export function colourWay( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::colour_way`, arguments: [ obj(tx, self) ], }) }

export function edition( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::edition`, arguments: [ obj(tx, self) ], }) }

export function imageUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::image_url`, arguments: [ obj(tx, self) ], }) }

export function manufacturer( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::manufacturer`, arguments: [ obj(tx, self) ], }) }

export function modelUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::model_url`, arguments: [ obj(tx, self) ], }) }

export function textureUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::texture_url`, arguments: [ obj(tx, self) ], }) }

export function rarity( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::rarity`, arguments: [ obj(tx, self) ], }) }

export function wearRating( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::wear_rating`, arguments: [ obj(tx, self) ], }) }

export function upgrades( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::cosmetic::upgrades`, arguments: [ obj(tx, self) ], }) }
