import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {pure} from "../../_framework/util";
import {Transaction, TransactionArgument} from "@mysten/sui/transactions";

export function new_( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::new`, arguments: [ ], }) }

export function types( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::types`, arguments: [ ], }) }

export function accessory( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::accessory`, arguments: [ ], }) }

export function assertIsValidCosmetic( tx: Transaction, str: string | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::assert_is_valid_cosmetic`, arguments: [ pure(tx, str, `${String.$typeName}`) ], }) }

export function assertIsValidWeapon( tx: Transaction, str: string | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::assert_is_valid_weapon`, arguments: [ pure(tx, str, `${String.$typeName}`) ], }) }

export function backpiece( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::backpiece`, arguments: [ ], }) }

export function boots( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::boots`, arguments: [ ], }) }

export function chestpiece( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::chestpiece`, arguments: [ ], }) }

export function cosmeticTypes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::cosmetic_types`, arguments: [ ], }) }

export function helm( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::helm`, arguments: [ ], }) }

export function leftArm( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_arm`, arguments: [ ], }) }

export function leftBracer( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_bracer`, arguments: [ ], }) }

export function leftGlove( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_glove`, arguments: [ ], }) }

export function leftPauldron( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_pauldron`, arguments: [ ], }) }

export function legs( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::legs`, arguments: [ ], }) }

export function primary( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::primary`, arguments: [ ], }) }

export function rightArm( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_arm`, arguments: [ ], }) }

export function rightBracer( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_bracer`, arguments: [ ], }) }

export function rightGlove( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_glove`, arguments: [ ], }) }

export function rightPauldron( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_pauldron`, arguments: [ ], }) }

export function secondary( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::secondary`, arguments: [ ], }) }

export function shins( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::shins`, arguments: [ ], }) }

export function tertiary( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::tertiary`, arguments: [ ], }) }

export function upperTorso( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::upper_torso`, arguments: [ ], }) }

export function weaponTypes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::weapon_types`, arguments: [ ], }) }
