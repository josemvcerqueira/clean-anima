import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export interface ContainsArgs { profilePictures: TransactionObjectInput; helm: Array<number | TransactionArgument> | TransactionArgument; chestpiece: Array<number | TransactionArgument> | TransactionArgument; upperTorso: Array<number | TransactionArgument> | TransactionArgument }

export function contains( tx: Transaction, args: ContainsArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::profile_pictures::contains`, arguments: [ obj(tx, args.profilePictures), pure(tx, args.helm, `vector<u8>`), pure(tx, args.chestpiece, `vector<u8>`), pure(tx, args.upperTorso, `vector<u8>`) ], }) }

export interface RemoveArgs { profilePictures: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; hash: Array<number | TransactionArgument> | TransactionArgument }

export function remove( tx: Transaction, args: RemoveArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::profile_pictures::remove`, arguments: [ obj(tx, args.profilePictures), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.hash, `vector<u8>`) ], }) }

export interface GetArgs { profilePictures: TransactionObjectInput; helm: Array<number | TransactionArgument> | TransactionArgument; chestpiece: Array<number | TransactionArgument> | TransactionArgument; upperTorso: Array<number | TransactionArgument> | TransactionArgument }

export function get( tx: Transaction, args: GetArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::profile_pictures::get`, arguments: [ obj(tx, args.profilePictures), pure(tx, args.helm, `vector<u8>`), pure(tx, args.chestpiece, `vector<u8>`), pure(tx, args.upperTorso, `vector<u8>`) ], }) }

export interface AddArgs { profilePictures: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; hash: Array<number | TransactionArgument> | TransactionArgument; ipfsUrl: string | TransactionArgument }

export function add( tx: Transaction, args: AddArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::profile_pictures::add`, arguments: [ obj(tx, args.profilePictures), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.hash, `vector<u8>`), pure(tx, args.ipfsUrl, `${String.$typeName}`) ], }) }

export function init( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::profile_pictures::init`, arguments: [ ], }) }

export interface CosmeticToPfpHashArgs { helm: Array<number | TransactionArgument> | TransactionArgument; chestpiece: Array<number | TransactionArgument> | TransactionArgument; upperTorso: Array<number | TransactionArgument> | TransactionArgument }

export function cosmeticToPfpHash( tx: Transaction, args: CosmeticToPfpHashArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::profile_pictures::cosmetic_to_pfp_hash`, arguments: [ pure(tx, args.helm, `vector<u8>`), pure(tx, args.chestpiece, `vector<u8>`), pure(tx, args.upperTorso, `vector<u8>`) ], }) }

export function hashToIpfs( tx: Transaction, profilePictures: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::profile_pictures::hash_to_ipfs`, arguments: [ obj(tx, profilePictures) ], }) }
