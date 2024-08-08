import { SuiObjectRef } from '@mysten/sui/client';
import { Transaction } from '@mysten/sui/transactions';

import type { OBJECTS, PACKAGES } from './constants';

export interface AnimaConstructorArgs {
  fullNodeUrl?: string;
  packages?: typeof PACKAGES;
  objects?: typeof OBJECTS;
}

export interface MaybeTx {
  tx?: Transaction;
}

export interface AirdropFreeMintArgs extends MaybeTx {
  recipient: string;
}

export interface AirdropWhitelistArgs extends MaybeTx {
  recipient: string;
}

export interface SetSaleActiveArgs extends MaybeTx {
  active: boolean;
}

export interface SetStartTimesArgs extends MaybeTx {
  startTimes: Array<bigint>;
}

export interface SetMaxMintsArgs extends MaybeTx {
  maxMints: Array<bigint>;
}

export interface SetPricesArgs extends MaybeTx {
  prices: Array<bigint>;
}

export interface SetDropsLeftArgs extends MaybeTx {
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
  passId: string;
}

export interface MintToTicketArgs extends MaybeTx {
  suiValue: bigint;
  passId: string;
}

export interface CreateAvatarArgs extends MaybeTx {
  imageUrl: string;
}

export interface GenerateImageUrlToAvatarTicketArgs extends MaybeTx {
  imageUrl: string;
  sender: string;
}

export interface EquipWeaponsArgs extends MaybeTx {
  weaponIds: string[];
  weaponSlots: string[];
  sender: string;
  kioskId: string;
}

export interface UnequipWeaponsArgs extends MaybeTx {
  weaponSlots: string[];
  sender: string;
  kioskId: string;
}

export interface EquipCosmeticsArgs extends MaybeTx {
  cosmeticIds: string[];
  cosmeticTypes: string[];
  sender: string;
  kioskId: string;
}

export interface UnequipCosmeticsArgs extends MaybeTx {
  cosmeticTypes: string[];
  sender: string;
  kioskId: string;
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

export interface RemoveReputationArgs extends MaybeTx {
  account: string;
  index: bigint;
}

export interface AddAccoladeArgs extends MaybeTx {
  recipient: string;
  type: string;
  description: string;
  url: string;
}

export interface RemoveAccoladeArgs extends MaybeTx {
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

export interface NewAvatarImageArgs extends MaybeTx {
  imageUrl: string;
  equippedCosmeticHash: string;
  recipient: string;
}

export interface NewUpgradeArgs extends MaybeTx {
  imageUrl: string;
  name: string;
  modelUrl: string;
  textureUrl: string;
  recipient: string;
}
