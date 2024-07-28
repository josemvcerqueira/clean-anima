import {PUBLISHED_AT} from "..";
import {obj} from "../../_framework/util";
import {Transaction, TransactionObjectInput} from "@mysten/sui/transactions";

export interface AssertReputationRoleArgs { accessControl: TransactionObjectInput; admin: TransactionObjectInput }

export function assertReputationRole( tx: Transaction, args: AssertReputationRoleArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::admin::assert_reputation_role`, arguments: [ obj(tx, args.accessControl), obj(tx, args.admin) ], }) }

export function init( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::admin::init`, arguments: [ ], }) }

export interface AssertAccoladesRoleArgs { accessControl: TransactionObjectInput; admin: TransactionObjectInput }

export function assertAccoladesRole( tx: Transaction, args: AssertAccoladesRoleArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::admin::assert_accolades_role`, arguments: [ obj(tx, args.accessControl), obj(tx, args.admin) ], }) }
