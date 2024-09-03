import {PUBLISHED_AT} from "..";
import {String} from "../../_dependencies/source/0x1/string/structs";
import {ID} from "../../_dependencies/source/0x2/object/structs";
import {obj, pure} from "../../_framework/util";
import {Transaction, TransactionArgument, TransactionObjectInput} from "@mysten/sui/transactions";

export function new_( tx: Transaction, settings: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::new`, arguments: [ obj(tx, settings) ], }) }

export function init( tx: Transaction, otw: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::init`, arguments: [ obj(tx, otw) ], }) }

export function attributes( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::attributes`, arguments: [ obj(tx, self) ], }) }

export function edition( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::edition`, arguments: [ obj(tx, self) ], }) }

export function imageUrl( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::image_url`, arguments: [ obj(tx, self) ], }) }

export function avatarModel( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::avatar_model`, arguments: [ obj(tx, self) ], }) }

export function avatarTexture( tx: Transaction, self: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::avatar_texture`, arguments: [ obj(tx, self) ], }) }

export interface EquipCosmeticArgs { self: TransactionObjectInput; pfps: TransactionObjectInput; cosmeticId: string | TransactionArgument; cosmeticType: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function equipCosmetic( tx: Transaction, args: EquipCosmeticArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::equip_cosmetic`, arguments: [ obj(tx, args.self), obj(tx, args.pfps), pure(tx, args.cosmeticId, `${ID.$typeName}`), pure(tx, args.cosmeticType, `${String.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface EquipMintedCosmeticArgs { self: TransactionObjectInput; cosmetic: TransactionObjectInput }

export function equipMintedCosmetic( tx: Transaction, args: EquipMintedCosmeticArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::equip_minted_cosmetic`, arguments: [ obj(tx, args.self), obj(tx, args.cosmetic) ], }) }

export interface EquipMintedWeaponArgs { self: TransactionObjectInput; weapon: TransactionObjectInput }

export function equipMintedWeapon( tx: Transaction, args: EquipMintedWeaponArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::equip_minted_weapon`, arguments: [ obj(tx, args.self), obj(tx, args.weapon) ], }) }

export interface EquipWeaponArgs { self: TransactionObjectInput; weaponId: string | TransactionArgument; weaponSlot: string | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function equipWeapon( tx: Transaction, args: EquipWeaponArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::equip_weapon`, arguments: [ obj(tx, args.self), pure(tx, args.weaponId, `${ID.$typeName}`), pure(tx, args.weaponSlot, `${String.$typeName}`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface HasCosmeticArgs { self: TransactionObjectInput; type: string | TransactionArgument }

export function hasCosmetic( tx: Transaction, args: HasCosmeticArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::has_cosmetic`, arguments: [ obj(tx, args.self), pure(tx, args.type, `${String.$typeName}`) ], }) }

export interface HasWeaponArgs { self: TransactionObjectInput; slot: string | TransactionArgument }

export function hasWeapon( tx: Transaction, args: HasWeaponArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::has_weapon`, arguments: [ obj(tx, args.self), pure(tx, args.slot, `${String.$typeName}`) ], }) }

export function newGenesisEdition( tx: Transaction, ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::new_genesis_edition`, arguments: [ ], }) }

export interface SetImageArgs { self: TransactionObjectInput; imageUrl: string | TransactionArgument }

export function setImage( tx: Transaction, args: SetImageArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::set_image`, arguments: [ obj(tx, args.self), pure(tx, args.imageUrl, `${String.$typeName}`) ], }) }

export interface SetSettingsActiveArgs { settings: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; active: boolean | TransactionArgument }

export function setSettingsActive( tx: Transaction, args: SetSettingsActiveArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::set_settings_active`, arguments: [ obj(tx, args.settings), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.active, `bool`) ], }) }

export interface SetSettingsAvatarModelArgs { settings: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; avatarModel: string | TransactionArgument }

export function setSettingsAvatarModel( tx: Transaction, args: SetSettingsAvatarModelArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::set_settings_avatar_model`, arguments: [ obj(tx, args.settings), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.avatarModel, `${String.$typeName}`) ], }) }

export interface SetSettingsAvatarTextureArgs { settings: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; avatarTexture: string | TransactionArgument }

export function setSettingsAvatarTexture( tx: Transaction, args: SetSettingsAvatarTextureArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::set_settings_avatar_texture`, arguments: [ obj(tx, args.settings), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.avatarTexture, `${String.$typeName}`) ], }) }

export interface SetSettingsEditionArgs { settings: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; edition: string | TransactionArgument }

export function setSettingsEdition( tx: Transaction, args: SetSettingsEditionArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::set_settings_edition`, arguments: [ obj(tx, args.settings), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.edition, `${String.$typeName}`) ], }) }

export interface SetSettingsImageUrlArgs { settings: TransactionObjectInput; accessControl: TransactionObjectInput; admin: TransactionObjectInput; imageUrl: string | TransactionArgument }

export function setSettingsImageUrl( tx: Transaction, args: SetSettingsImageUrlArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::set_settings_image_url`, arguments: [ obj(tx, args.settings), obj(tx, args.accessControl), obj(tx, args.admin), pure(tx, args.imageUrl, `${String.$typeName}`) ], }) }

export function settingsAvatarActive( tx: Transaction, settings: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::settings_avatar_active`, arguments: [ obj(tx, settings) ], }) }

export function settingsAvatarModel( tx: Transaction, settings: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::settings_avatar_model`, arguments: [ obj(tx, settings) ], }) }

export function settingsAvatarTexture( tx: Transaction, settings: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::settings_avatar_texture`, arguments: [ obj(tx, settings) ], }) }

export function settingsEdition( tx: Transaction, settings: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::settings_edition`, arguments: [ obj(tx, settings) ], }) }

export function settingsImageUrl( tx: Transaction, settings: TransactionObjectInput ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::settings_image_url`, arguments: [ obj(tx, settings) ], }) }

export interface UnequipCosmeticsArgs { self: TransactionObjectInput; pfps: TransactionObjectInput; cosmeticTypes: Array<string | TransactionArgument> | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function unequipCosmetics( tx: Transaction, args: UnequipCosmeticsArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::unequip_cosmetics`, arguments: [ obj(tx, args.self), obj(tx, args.pfps), pure(tx, args.cosmeticTypes, `vector<${String.$typeName}>`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface UnequipWeaponsArgs { self: TransactionObjectInput; weaponSlots: Array<string | TransactionArgument> | TransactionArgument; kiosk: TransactionObjectInput; cap: TransactionObjectInput; policy: TransactionObjectInput }

export function unequipWeapons( tx: Transaction, args: UnequipWeaponsArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::unequip_weapons`, arguments: [ obj(tx, args.self), pure(tx, args.weaponSlots, `vector<${String.$typeName}>`), obj(tx, args.kiosk), obj(tx, args.cap), obj(tx, args.policy) ], }) }

export interface UpdateImageArgs { self: TransactionObjectInput; pfps: TransactionObjectInput }

export function updateImage( tx: Transaction, args: UpdateImageArgs ) { return tx.moveCall({ target: `${PUBLISHED_AT}::avatar::update_image`, arguments: [ obj(tx, args.self), obj(tx, args.pfps) ], }) }
