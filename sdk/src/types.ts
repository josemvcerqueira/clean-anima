import { SuiObjectRef } from '@mysten/sui/client';
import { Transaction } from '@mysten/sui/transactions';

import type { PACKAGES, SHARED_OBJECTS } from './constants';

export interface AnimaConstructorArgs {
  fullNodeUrl?: string;
  packages?: typeof PACKAGES;
  genesisShopItemsId?: string;
  saleId?: string;
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

export interface UpdateImage extends MaybeTx {
  avatarId: string;
}

export interface MintToKioskArgs extends MaybeTx {
  nftQuantity: bigint;
  suiValue: bigint;
  sender: string;
  passId?: string;
}

export interface MintToAvatarArgs extends MaybeTx {
  suiValue: bigint;
  sender: string;
  passId?: string;
}

export interface EquipWeaponsArgs extends MaybeTx {
  weaponIds: string[];
  weaponSlots: string[];
  sender: string;
  avatarId: string;
}

export interface UnequipWeaponsArgs extends MaybeTx {
  weaponSlots: string[];
  sender: string;
  avatarId: string;
}

export interface EquipCosmeticsArgs extends MaybeTx {
  cosmeticIds: string[];
  avatarId: string;
  cosmeticTypes: string[];
  sender: string;
}

export interface UnequipCosmeticsArgs extends MaybeTx {
  cosmeticTypes: string[];
  avatarId: string;
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
  type: string;
  imageUrl: string;
  avatarModel: string;
  avatarTexture: string;
  edition: string;
  attributes: Record<string, string>;
  attributesHash: Record<string, string>;
  misc: Record<string, string>;
}

export interface NewAvatarArgs extends MaybeTx {
  recipient: string;
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

export interface SetAvatarSettingsEdition extends MaybeTx, AdminFn {
  edition: string;
}

export interface SetAvatarSettingsImageUrl extends MaybeTx, AdminFn {
  imageUrl: string;
  texture: string;
  model: string;
}

export interface SetAvatarSettingsActive extends MaybeTx, AdminFn {
  active: boolean;
}

export interface AddProfilePicture extends MaybeTx, AdminFn {
  hash: string;
  ipfsUrl: string;
}

export interface RemoveProfilePicture extends MaybeTx, AdminFn {
  hash: string;
}

export interface AdminMintToKioskArgs extends MaybeTx, AdminFn {
  nftQuantity: bigint;
  sender: string;
}
