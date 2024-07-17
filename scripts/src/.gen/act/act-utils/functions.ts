import {PUBLISHED_AT} from "..";
import {pure} from "../../_framework/util";
import {Transaction, TransactionArgument} from "@mysten/sui/transactions";

export interface MinArgs { x: bigint | TransactionArgument; y: bigint | TransactionArgument }

export function min( tx: Transaction, args: MinArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_utils::min`, arguments: [ pure(tx, args.x, `u64`), pure(tx, args.y, `u64`) ], }) }
