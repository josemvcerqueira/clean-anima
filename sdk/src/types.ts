import { SuiObjectRef } from '@mysten/sui/client';
import { Transaction } from '@mysten/sui/transactions';

import type { OBJECTS, PACKAGES } from './constants';

export interface AnimaConstructorArgs {
  fullNodeUrl?: string;
  packages?: typeof PACKAGES;
  objects?: typeof OBJECTS;
}

interface MaybeTx {
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

export interface GeenesisShopItem extends SuiObjectRef {
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
