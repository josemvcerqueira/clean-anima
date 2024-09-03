import {PUBLISHED_AT} from "..";
import {obj, pure, vector} from "../../_framework/util";
import {GenesisPass} from "./structs";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export function init( tx: Transaction, otw: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::init`, arguments: [ obj(tx, otw) ], }) }

export interface AdminMintToKioskArgs { accessControl: TransactionObjectInput; admin: TransactionObjectInput; genesisShop: TransactionObjectInput; kiosk: TransactionObjectInput; cap: TransactionObjectInput; quantity: bigint | TransactionArgument; clock: TransactionObjectInput }

export function adminMintToKiosk( tx: Transaction, args: AdminMintToKioskArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::admin_mint_to_kiosk`, arguments: [ obj(tx, args.accessControl), obj(tx, args.admin), obj(tx, args.genesisShop), obj(tx, args.kiosk), obj(tx, args.cap), pure(tx, args.quantity, `u64`), obj(tx, args.clock) ], }) }

export interface AirdropFreemintArgs { accessControl: TransactionObjectInput; admin: TransactionObjectInput; recipient: string | TransactionArgument }

export function airdropFreemint( tx: Transaction, args: AirdropFreemintArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::airdrop_freemint`, arguments: [ obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.recipient, `address`) ], }) }

export interface AirdropWhitelistArgs { accessControl: TransactionObjectInput; admin: TransactionObjectInput; recipient: string | TransactionArgument }

export function airdropWhitelist( tx: Transaction, args: AirdropWhitelistArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::airdrop_whitelist`, arguments: [ obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.recipient, `address`) ], }) }

export interface AssertCanMintArgs { sale: TransactionObjectInput; pass: Array<TransactionObjectInput> | TransactionArgument; amount: bigint | TransactionArgument; quantity: bigint | TransactionArgument; now: bigint | TransactionArgument }

export function assertCanMint( tx: Transaction, args: AssertCanMintArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::assert_can_mint`, arguments: [ obj(tx, args.sale), vector(tx, `${GenesisPass.$typeName}`, args.pass), pure(tx, args.amount, `u64`), pure(tx, args.quantity, `u64`), pure(tx, args.now, `u64`) ], }) }

export interface MintToAvatarArgs { sale: TransactionObjectInput; genesisShop: TransactionObjectInput; pass: Array<TransactionObjectInput> | TransactionArgument; pfps: TransactionObjectInput; coin: TransactionObjectInput; clock: TransactionObjectInput }

export function mintToAvatar( tx: Transaction, args: MintToAvatarArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::mint_to_avatar`, arguments: [ obj(tx, args.sale), obj(tx, args.genesisShop), vector(tx, `${GenesisPass.$typeName}`, args.pass), obj(tx, args.pfps), obj(tx, args.coin), obj(tx, args.clock) ], }) }

export interface MintToKioskArgs { sale: TransactionObjectInput; genesisShop: TransactionObjectInput; pass: Array<TransactionObjectInput> | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; coin: TransactionObjectInput; quantity: bigint | TransactionArgument; clock: TransactionObjectInput }

export function mintToKiosk( tx: Transaction, args: MintToKioskArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::mint_to_kiosk`, arguments: [ obj(tx, args.sale), obj(tx, args.genesisShop), vector(tx, `${GenesisPass.$typeName}`, args.pass), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.coin), pure(tx, args.quantity, `u64`), obj(tx, args.clock) ], }) }

export interface MintToKioskImplArgs { genesisShop: TransactionObjectInput; kiosk: TransactionObjectInput; cap: TransactionObjectInput; quantity: bigint | TransactionArgument; clock: TransactionObjectInput }

export function mintToKioskImpl( tx: Transaction, args: MintToKioskImplArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::mint_to_kiosk_impl`, arguments: [ obj(tx, args.genesisShop), obj(tx, args.kiosk), obj(tx, args.cap), pure(tx, args.quantity, `u64`), obj(tx, args.clock) ], }) }

export function passDescription( tx: Transaction, pass: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::pass_description`, arguments: [ obj(tx, pass) ], }) }

export function passImageUrl( tx: Transaction, pass: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::pass_image_url`, arguments: [ obj(tx, pass) ], }) }

export function passName( tx: Transaction, pass: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::pass_name`, arguments: [ obj(tx, pass) ], }) }

export function passPhase( tx: Transaction, pass: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::pass_phase`, arguments: [ obj(tx, pass) ], }) }

export interface SetActiveArgs { sale: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; active: boolean | TransactionArgument }

export function setActive( tx: Transaction, args: SetActiveArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::set_active`, arguments: [ obj(tx, args.sale), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.active, `bool`) ], }) }

export interface SetDropsLeftArgs { sale: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; dropsLeft: bigint | TransactionArgument }

export function setDropsLeft( tx: Transaction, args: SetDropsLeftArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::set_drops_left`, arguments: [ obj(tx, args.sale), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.dropsLeft, `u64`) ], }) }

export interface SetMaxMintsArgs { sale: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; maxMints: Array<bigint | TransactionArgument> | TransactionArgument }

export function setMaxMints( tx: Transaction, args: SetMaxMintsArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::set_max_mints`, arguments: [ obj(tx, args.sale), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.maxMints, `vector<u64>`) ], }) }

export interface SetPricesArgs { sale: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; prices: Array<bigint | TransactionArgument> | TransactionArgument }

export function setPrices( tx: Transaction, args: SetPricesArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::set_prices`, arguments: [ obj(tx, args.sale), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.prices, `vector<u64>`) ], }) }

export interface SetStartTimesArgs { sale: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; startTimes: Array<bigint | TransactionArgument> | TransactionArgument }

export function setStartTimes( tx: Transaction, args: SetStartTimesArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::genesis_drop::set_start_times`, arguments: [ obj(tx, args.sale), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.startTimes, `vector<u64>`) ], }) }
