import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export interface NewArgs { name: string | TransactionArgument; image: string | TransactionArgument }

export function new_( tx: Transaction, args: NewArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_upgrade::new`, arguments: [ pure(tx, args.name, `${String.$typeName}`), pure(tx, args.image, `${String.$typeName}`) ], }) }

export function name( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_upgrade::name`, arguments: [ obj(tx, self) ], }) }

export function image( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_upgrade::image`, arguments: [ obj(tx, self) ], }) }
