import {PUBLISHED_AT} from "..";
import {pure} from "../../_framework/util";
import {Transaction, TransactionArgument} from "@mysten/sui/transactions";

export interface GetChestpieceArgs { name: Array<number | TransactionArgument> | TransactionArgument; colourWay: Array<number | TransactionArgument> | TransactionArgument }

export function getChestpiece( tx: Transaction, args: GetChestpieceArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_chestpiece`, arguments: [ pure(tx, args.name, `vector<u8>`), pure(tx, args.colourWay, `vector<u8>`) ], }) }

export interface GetHelmArgs { name: Array<number | TransactionArgument> | TransactionArgument; colourWay: Array<number | TransactionArgument> | TransactionArgument }

export function getHelm( tx: Transaction, args: GetHelmArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_helm`, arguments: [ pure(tx, args.name, `vector<u8>`), pure(tx, args.colourWay, `vector<u8>`) ], }) }

export interface GetLeftBracerArgs { name: Array<number | TransactionArgument> | TransactionArgument; colourWay: Array<number | TransactionArgument> | TransactionArgument }

export function getLeftBracer( tx: Transaction, args: GetLeftBracerArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_left_bracer`, arguments: [ pure(tx, args.name, `vector<u8>`), pure(tx, args.colourWay, `vector<u8>`) ], }) }

export interface GetLeftPauldronArgs { name: Array<number | TransactionArgument> | TransactionArgument; colourWay: Array<number | TransactionArgument> | TransactionArgument }

export function getLeftPauldron( tx: Transaction, args: GetLeftPauldronArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_left_pauldron`, arguments: [ pure(tx, args.name, `vector<u8>`), pure(tx, args.colourWay, `vector<u8>`) ], }) }

export interface GetOtherArgs { name: Array<number | TransactionArgument> | TransactionArgument; equipment: Array<number | TransactionArgument> | TransactionArgument; colourWay: Array<number | TransactionArgument> | TransactionArgument }

export function getOther( tx: Transaction, args: GetOtherArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_other`, arguments: [ pure(tx, args.name, `vector<u8>`), pure(tx, args.equipment, `vector<u8>`), pure(tx, args.colourWay, `vector<u8>`) ], }) }

export interface GetRightBracerArgs { name: Array<number | TransactionArgument> | TransactionArgument; colourWay: Array<number | TransactionArgument> | TransactionArgument }

export function getRightBracer( tx: Transaction, args: GetRightBracerArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_right_bracer`, arguments: [ pure(tx, args.name, `vector<u8>`), pure(tx, args.colourWay, `vector<u8>`) ], }) }

export interface GetRightPauldronArgs { name: Array<number | TransactionArgument> | TransactionArgument; colourWay: Array<number | TransactionArgument> | TransactionArgument }

export function getRightPauldron( tx: Transaction, args: GetRightPauldronArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_right_pauldron`, arguments: [ pure(tx, args.name, `vector<u8>`), pure(tx, args.colourWay, `vector<u8>`) ], }) }

export function getWeapon( tx: Transaction, name: Array<number | TransactionArgument> | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::uris::get_weapon`, arguments: [ pure(tx, name, `vector<u8>`) ], }) }
