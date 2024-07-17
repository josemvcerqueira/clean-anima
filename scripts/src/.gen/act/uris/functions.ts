import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {pure} from "../../_framework/util";
import {Transaction, TransactionArgument} from "@mysten/sui/transactions";

export interface GetCosmeticUrisArgs { name: string | TransactionArgument; colourWay: string | TransactionArgument }

export function getCosmeticUris( tx: Transaction, args: GetCosmeticUrisArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_cosmetic_uris`, arguments: [ pure(tx, args.name, `${String.$typeName}`), pure(tx, args.colourWay, `${String.$typeName}`) ], }) }

export interface GetWeaponUrisArgs { name: string | TransactionArgument; colourWay: string | TransactionArgument }

export function getWeaponUris( tx: Transaction, args: GetWeaponUrisArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_weapon_uris`, arguments: [ pure(tx, args.name, `${String.$typeName}`), pure(tx, args.colourWay, `${String.$typeName}`) ], }) }
