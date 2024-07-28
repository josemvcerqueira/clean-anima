import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export function new_( tx: Transaction, url: string | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::upgrade::new`, arguments: [ pure(tx, url, `${String.$typeName}`) ], }) }

export function url( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::upgrade::url`, arguments: [ obj(tx, self) ], }) }
