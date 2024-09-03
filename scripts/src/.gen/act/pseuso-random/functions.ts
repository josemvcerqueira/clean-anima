import {PUBLISHED_AT} from "..";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export function seed( tx: Transaction, clock: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::pseuso_random::seed`, arguments: [ obj(tx, clock) ], }) }

export function fromSeed( tx: Transaction, seed: Array<number | TransactionArgument> | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::pseuso_random::from_seed`, arguments: [ pure(tx, seed, `vector<u8>`) ], }) }

export function rawSeed( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::pseuso_random::raw_seed`, arguments: [ ], }) }

export interface RngArgs { min: bigint | TransactionArgument; max: bigint | TransactionArgument; clock: TransactionObjectInput }

export function rng( tx: Transaction, args: RngArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::pseuso_random::rng`, arguments: [ pure(tx, args.min, `u64`), pure(tx, args.max, `u64`), obj(tx, args.clock) ], }) }
