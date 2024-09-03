import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {pure} from "../../_framework/util";
import {Transaction, TransactionArgument} from "@mysten/sui/transactions";

export function new_( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::new`, arguments: [ ], }) }

export function types( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::types`, arguments: [ ], }) }

export function accessory( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::accessory`, arguments: [ ], }) }

export function accessoryBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::accessory_bytes`, arguments: [ ], }) }

export function assertIsValidCosmetic( tx: Transaction, str: string | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::assert_is_valid_cosmetic`, arguments: [ pure(tx, str, `${String.$typeName}`) ], }) }

export function assertIsValidWeapon( tx: Transaction, str: string | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::assert_is_valid_weapon`, arguments: [ pure(tx, str, `${String.$typeName}`) ], }) }

export function backpiece( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::backpiece`, arguments: [ ], }) }

export function backpieceBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::backpiece_bytes`, arguments: [ ], }) }

export function belt( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::belt`, arguments: [ ], }) }

export function beltBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::belt_bytes`, arguments: [ ], }) }

export function boots( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::boots`, arguments: [ ], }) }

export function bootsBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::boots_bytes`, arguments: [ ], }) }

export function chestpiece( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::chestpiece`, arguments: [ ], }) }

export function chestpieceBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::chestpiece_bytes`, arguments: [ ], }) }

export function cosmeticTypes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::cosmetic_types`, arguments: [ ], }) }

export function genesisMintTypes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::genesis_mint_types`, arguments: [ ], }) }

export function helm( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::helm`, arguments: [ ], }) }

export function helmBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::helm_bytes`, arguments: [ ], }) }

export function leftArm( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_arm`, arguments: [ ], }) }

export function leftArmBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_arm_bytes`, arguments: [ ], }) }

export function leftBracer( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_bracer`, arguments: [ ], }) }

export function leftBracerBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_bracer_bytes`, arguments: [ ], }) }

export function leftGlove( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_glove`, arguments: [ ], }) }

export function leftGloveBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_glove_bytes`, arguments: [ ], }) }

export function leftPauldron( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_pauldron`, arguments: [ ], }) }

export function leftPauldronBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::left_pauldron_bytes`, arguments: [ ], }) }

export function legs( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::legs`, arguments: [ ], }) }

export function legsBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::legs_bytes`, arguments: [ ], }) }

export function makeFormattedType( tx: Transaction, type: string | TransactionArgument ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::make_formatted_type`, arguments: [ pure(tx, type, `${String.$typeName}`) ], }) }

export function newHashes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::new_hashes`, arguments: [ ], }) }

export function primary( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::primary`, arguments: [ ], }) }

export function primaryBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::primary_bytes`, arguments: [ ], }) }

export function rightArm( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_arm`, arguments: [ ], }) }

export function rightArmBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_arm_bytes`, arguments: [ ], }) }

export function rightBracer( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_bracer`, arguments: [ ], }) }

export function rightBracerBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_bracer_bytes`, arguments: [ ], }) }

export function rightGlove( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_glove`, arguments: [ ], }) }

export function rightGloveBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_glove_bytes`, arguments: [ ], }) }

export function rightPauldron( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_pauldron`, arguments: [ ], }) }

export function rightPauldronBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::right_pauldron_bytes`, arguments: [ ], }) }

export function secondary( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::secondary`, arguments: [ ], }) }

export function secondaryBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::secondary_bytes`, arguments: [ ], }) }

export function shins( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::shins`, arguments: [ ], }) }

export function shinsBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::shins_bytes`, arguments: [ ], }) }

export function tertiary( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::tertiary`, arguments: [ ], }) }

export function tertiaryBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::tertiary_bytes`, arguments: [ ], }) }

export function upperTorso( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::upper_torso`, arguments: [ ], }) }

export function upperTorsoBytes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::upper_torso_bytes`, arguments: [ ], }) }

export function weaponTypes( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::attributes::weapon_types`, arguments: [ ], }) }
