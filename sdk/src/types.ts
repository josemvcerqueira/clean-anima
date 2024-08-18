import { SuiObjectRef } from '@mysten/sui/client';
import { Transaction } from '@mysten/sui/transactions';

import type { PACKAGES, SHARED_OBJECTS } from './constants';

export interface AnimaConstructorArgs {
  fullNodeUrl?: string;
  packages?: typeof PACKAGES;
  genesisShopItemsId?: string;
  sharedObjects?: typeof SHARED_OBJECTS;
}

export interface MaybeTx {
  tx?: Transaction;
}

export interface AdminFn {
  adminCap: string;
}

export interface AirdropFreeMintArgs extends MaybeTx, AdminFn {
  recipient: string;
}

export interface AirdropWhitelistArgs extends MaybeTx, AdminFn {
  recipient: string;
}

export interface SetSaleActiveArgs extends MaybeTx, AdminFn {
  active: boolean;
}

export interface SetStartTimesArgs extends MaybeTx, AdminFn {
  startTimes: Array<bigint>;
}

export interface SetMaxMintsArgs extends MaybeTx, AdminFn {
  maxMints: Array<bigint>;
}

export interface SetPricesArgs extends MaybeTx, AdminFn {
  prices: Array<bigint>;
}

export interface SetDropsLeftArgs extends MaybeTx, AdminFn {
  dropsLeft: bigint;
}

export interface GenesisPass extends SuiObjectRef {
  phase: bigint;
  type: string;
}

export interface MintToKioskArgs extends MaybeTx {
  nftQuantity: bigint;
  suiValue: bigint;
  sender: string;
  passId?: string;
}

export interface MintToTicketArgs extends MaybeTx {
  suiValue: bigint;
  passId?: string;
}

export interface CreateAvatarArgs extends MaybeTx {
  imageUrl: string;
}

export interface UpdateAvatarTicketImageArgs extends MaybeTx {
  image: string;
  sender: string;
}

export interface EquipWeaponsArgs extends MaybeTx {
  weaponIds: string[];
  weaponSlots: string[];
  sender: string;
}

export interface UnequipWeaponsArgs extends MaybeTx {
  weaponSlots: string[];
  sender: string;
}

export interface EquipCosmeticsArgs extends MaybeTx {
  cosmeticIds: string[];
  cosmeticTypes: string[];
  sender: string;
}

export interface UnequipCosmeticsArgs extends MaybeTx {
  cosmeticTypes: string[];
  sender: string;
}

export interface GenesisShopItem extends SuiObjectRef {
  hash: string;
  name: string;
  equipment: string;
  colourWay: string;
  manufacturer: string;
  rarity: string;
  imageUrl: string;
  modelUrl: string;
  textureUrl: string;
}

export interface Avatar extends SuiObjectRef {
  imageUrl: string;
  equippedCosmeticsHash: string;
  type: string;
  avatarImage: string;
  avatarModel: string;
  avatarTexture: string;
  edition: string;
  upgrades: any;
  attributes: Record<string, string>;
  misc: Record<string, string>;
}

export interface AvatarTicket extends SuiObjectRef {
  imageUrl: string;
  equippedCosmeticsHash: string;
  drops: ReadonlyArray<GenesisShopItem>;
  type: string;
}

export interface NewAnimaAccountArgs extends MaybeTx {
  alias: string;
  username: string;
}

export interface UpdateAliasArgs extends MaybeTx {
  account: string;
  alias: string;
}

export interface UpdateUsernameArgs extends MaybeTx {
  account: string;
  username: string;
}

export interface GiveReputationArgs extends MaybeTx {
  account: string;
  recipient: string;
  type: string;
  value: bigint;
  positive: boolean;
  description: string;
  url: string;
}

export interface RemoveReputationArgs extends MaybeTx, AdminFn {
  account: string;
  index: bigint;
}

export interface AddAccoladeArgs extends MaybeTx, AdminFn {
  recipient: string;
  type: string;
  description: string;
  url: string;
}

export interface RemoveAccoladeArgs extends MaybeTx, AdminFn {
  account: string;
  index: bigint;
}

export interface UpdateAvatarArgs extends MaybeTx {
  avatar: string;
  image: string;
}

export interface UpgradeAvatarArgs extends MaybeTx {
  avatar: string;
  lockedUpgrade: string;
}

export interface UpgradeAvatarWeaponArgs extends MaybeTx {
  avatar: string;
  lockedUpgrade: string;
  slot: string;
}

export interface UpgradeAvatarCosmeticArgs extends MaybeTx {
  avatar: string;
  lockedUpgrade: string;
  type: string;
}

export interface UpgradeEquippedCosmeticArgs extends MaybeTx {
  avatar: string;
  lockedUpgrade: string;
  type: string;
}

export interface UpgradeEquippedWeaponArgs extends MaybeTx {
  avatar: string;
  lockedUpgrade: string;
  slot: string;
}

export interface NewAvatarImageArgs extends MaybeTx, AdminFn {
  imageUrl: string;
  equippedCosmeticHash: string;
  recipient: string;
}

export interface NewUpgradeArgs extends MaybeTx, AdminFn {
  imageUrl: string;
  name: string;
  modelUrl: string;
  textureUrl: string;
  recipient: string;
}
