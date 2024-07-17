import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {ID} from "../../_dependencies/source/0x2/object/structs";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export interface NewArgs { registry: TransactionObjectInput; alias: string | TransactionArgument; username: string | TransactionArgument; imageUrl: string | TransactionArgument; imageHash: string | TransactionArgument; modelUrl: string | TransactionArgument; avatarUrl: string | TransactionArgument; avatarHash: string | TransactionArgument; edition: string | TransactionArgument; clock: TransactionObjectInput }

export function new_( tx: Transaction, args: NewArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::new`, arguments: [ obj(tx, args.registry), pure(tx, args.alias, `${String.$typeName}`), pure(tx, args.username, `${String.$typeName}`), pure(tx, args.imageUrl, `${String.$typeName}`), pure(tx, args.imageHash, `${String.$typeName}`), pure(tx, args.modelUrl, `${String.$typeName}`), pure(tx, args.avatarUrl, `${String.$typeName}`), pure(tx, args.avatarHash, `${String.$typeName}`), pure(tx, args.edition, `${String.$typeName}`), obj(tx, args.clock) ], }) }

export interface TransferArgs { self: TransactionObjectInput; recipient: string | TransactionArgument }

export function transfer( tx: Transaction, args: TransferArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::transfer`, arguments: [ obj(tx, args.self), pure(tx, args.recipient, `address`) ], }) }

export interface CreateArgs { registry: TransactionObjectInput; alias: string | TransactionArgument; username: string | TransactionArgument; imageUrl: string | TransactionArgument; imageHash: string | TransactionArgument; modelUrl: string | TransactionArgument; avatarUrl: string | TransactionArgument; avatarHash: string | TransactionArgument; edition: string | TransactionArgument; clock: TransactionObjectInput }

export function create( tx: Transaction, args: CreateArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::create`, arguments: [ obj(tx, args.registry), pure(tx, args.alias, `${String.$typeName}`), pure(tx, args.username, `${String.$typeName}`), pure(tx, args.imageUrl, `${String.$typeName}`), pure(tx, args.imageHash, `${String.$typeName}`), pure(tx, args.modelUrl, `${String.$typeName}`), pure(tx, args.avatarUrl, `${String.$typeName}`), pure(tx, args.avatarHash, `${String.$typeName}`), pure(tx, args.edition, `${String.$typeName}`), obj(tx, args.clock) ], }) }

export interface UpgradeArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; name: string | TransactionArgument; image: string | TransactionArgument }

export function upgrade( tx: Transaction, args: UpgradeArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::upgrade`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.name, `${String.$typeName}`), pure(tx, args.image, `${String.$typeName}`) ], }) }

export function init( tx: Transaction, otw: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::init`, arguments: [ obj(tx, otw) ], }) }

export function attributes( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::attributes`, arguments: [ obj(tx, self) ], }) }

export function edition( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::edition`, arguments: [ obj(tx, self) ], }) }

export function imageHash( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::image_hash`, arguments: [ obj(tx, self) ], }) }

export function imageUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::image_url`, arguments: [ obj(tx, self) ], }) }

export function modelUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::model_url`, arguments: [ obj(tx, self) ], }) }

export function upgrades( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::upgrades`, arguments: [ obj(tx, self) ], }) }

export function accolades( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::accolades`, arguments: [ obj(tx, self) ], }) }

export interface AddAccoladeArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; type: string | TransactionArgument; description: string | TransactionArgument; link: string | TransactionArgument }

export function addAccolade( tx: Transaction, args: AddAccoladeArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::add_accolade`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.type, `${String.$typeName}`), pure(tx, args.description, `${String.$typeName}`), pure(tx, args.link, `${String.$typeName}`) ], }) }

export interface AddReputationArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; type: string | TransactionArgument; value: bigint | TransactionArgument; positive: boolean | TransactionArgument; description: string | TransactionArgument; link: string | TransactionArgument }

export function addReputation( tx: Transaction, args: AddReputationArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::add_reputation`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.type, `${String.$typeName}`), pure(tx, args.value, `u64`), pure(tx, args.positive, `bool`), pure(tx, args.description, `${String.$typeName}`), pure(tx, args.link, `${String.$typeName}`) ], }) }

export function alias( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::alias`, arguments: [ obj(tx, self) ], }) }

export interface AssertHasAvatarArgs { self: TransactionObjectInput; addr: string | TransactionArgument }

export function assertHasAvatar( tx: Transaction, args: AssertHasAvatarArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::assert_has_avatar`, arguments: [ obj(tx, args.self), pure(tx, args.addr, `address`) ], }) }

export interface AssertNoAvatarArgs { self: TransactionObjectInput; addr: string | TransactionArgument }

export function assertNoAvatar( tx: Transaction, args: AssertNoAvatarArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::assert_no_avatar`, arguments: [ obj(tx, args.self), pure(tx, args.addr, `address`) ], }) }

export function avatarHash( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::avatar_hash`, arguments: [ obj(tx, self) ], }) }

export function avatarUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::avatar_url`, arguments: [ obj(tx, self) ], }) }

export function username( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::username`, arguments: [ obj(tx, self) ], }) }

export function creationDate( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::creation_date`, arguments: [ obj(tx, self) ], }) }

export interface EquipCosmeticArgs { self: TransactionObjectInput; cosmeticId: string | TransactionArgument; cosmeticType: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function equipCosmetic( tx: Transaction, args: EquipCosmeticArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::equip_cosmetic`, arguments: [ obj(tx, args.self), pure(tx, args.cosmeticId, `${ID.$typeName}`), pure(tx, args.cosmeticType, `${String.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface EquipMintedCosmeticArgs { self: TransactionObjectInput; cosmetic: TransactionObjectInput }

export function equipMintedCosmetic( tx: Transaction, args: EquipMintedCosmeticArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::equip_minted_cosmetic`, arguments: [ obj(tx, args.self), obj(tx, args.cosmetic) ], }) }

export interface EquipMintedWeaponArgs { self: TransactionObjectInput; weapon: TransactionObjectInput }

export function equipMintedWeapon( tx: Transaction, args: EquipMintedWeaponArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::equip_minted_weapon`, arguments: [ obj(tx, args.self), obj(tx, args.weapon) ], }) }

export interface EquipWeaponArgs { self: TransactionObjectInput; weaponId: string | TransactionArgument; weaponSlot: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function equipWeapon( tx: Transaction, args: EquipWeaponArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::equip_weapon`, arguments: [ obj(tx, args.self), pure(tx, args.weaponId, `${ID.$typeName}`), pure(tx, args.weaponSlot, `${String.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface RemoveReputationArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; idx: bigint | TransactionArgument }

export function removeReputation( tx: Transaction, args: RemoveReputationArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::remove_reputation`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.idx, `u64`) ], }) }

export function reputation( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::reputation`, arguments: [ obj(tx, self) ], }) }

export interface UnequipCosmeticArgs { self: TransactionObjectInput; cosmeticType: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function unequipCosmetic( tx: Transaction, args: UnequipCosmeticArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::unequip_cosmetic`, arguments: [ obj(tx, args.self), pure(tx, args.cosmeticType, `${String.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface UnequipWeaponArgs { self: TransactionObjectInput; weaponSlot: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function unequipWeapon( tx: Transaction, args: UnequipWeaponArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::unequip_weapon`, arguments: [ obj(tx, args.self), pure(tx, args.weaponSlot, `${String.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface UpdateAliasArgs { self: TransactionObjectInput; alias: string | TransactionArgument }

export function updateAlias( tx: Transaction, args: UpdateAliasArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::update_alias`, arguments: [ obj(tx, args.self), pure(tx, args.alias, `${String.$typeName}`) ], }) }

export interface UpdateUsernameArgs { self: TransactionObjectInput; username: string | TransactionArgument }

export function updateUsername( tx: Transaction, args: UpdateUsernameArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::update_username`, arguments: [ obj(tx, args.self), pure(tx, args.username, `${String.$typeName}`) ], }) }

export interface UpgradeEquippedCosmeticArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; type: string | TransactionArgument; name: string | TransactionArgument; image: string | TransactionArgument }

export function upgradeEquippedCosmetic( tx: Transaction, args: UpgradeEquippedCosmeticArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::upgrade_equipped_cosmetic`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.type, `${String.$typeName}`), pure(tx, args.name, `${String.$typeName}`), pure(tx, args.image, `${String.$typeName}`) ], }) }

export interface UpgradeEquippedWeaponArgs { self: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; slot: string | TransactionArgument; name: string | TransactionArgument; image: string | TransactionArgument }

export function upgradeEquippedWeapon( tx: Transaction, args: UpgradeEquippedWeaponArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::act_avatar::upgrade_equipped_weapon`, arguments: [ obj(tx, args.self), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.slot, `${String.$typeName}`), pure(tx, args.name, `${String.$typeName}`), pure(tx, args.image, `${String.$typeName}`) ], }) }
