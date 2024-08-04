import { KioskClient, Network } from '@mysten/kiosk';
import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Transaction } from '@mysten/sui/transactions';
import {
  isValidSuiAddress,
  normalizeStructTag,
  toHEX,
} from '@mysten/sui/utils';
import { chunkArray, fetchAllDynamicFields } from '@polymedia/suitcase-core';
import { path, pathOr } from 'ramda';
import invariant from 'tiny-invariant';

import { GENESIS_SHOP_NAMES, OBJECTS, PACKAGES } from './constants';
import {
  AirdropFreeMintArgs,
  AirdropWhitelistArgs,
  AnimaConstructorArgs,
  GenesisPass,
  GenesisShopItem,
  SetDropsLeftArgs,
  SetMaxMintsArgs,
  SetPricesArgs,
  SetSaleActiveArgs,
  SetStartTimesArgs,
} from './types';

export class AnimaSDK {
  #packages: typeof PACKAGES;
  #objects: typeof OBJECTS;
  #client: SuiClient;
  #kioskClient: KioskClient;

  constructor(
    args: AnimaConstructorArgs = {
      packages: PACKAGES,
      objects: OBJECTS,
      fullNodeUrl: getFullnodeUrl('testnet'),
    }
  ) {
    const data = args
      ? args
      : {
          packages: PACKAGES,
          objects: OBJECTS,
          fullNodeUrl: getFullnodeUrl('testnet'),
        };
    this.#packages = data.packages || PACKAGES;
    this.#objects = data.objects || OBJECTS;
    this.#client = new SuiClient({
      url: data.fullNodeUrl || getFullnodeUrl('testnet'),
    });
    this.#kioskClient = new KioskClient({
      client: new SuiClient({
        url: data.fullNodeUrl || getFullnodeUrl('testnet'),
      }),
      network: Network.TESTNET,
    });
  }

  async getGenesisShopItems(
    name: keyof typeof GENESIS_SHOP_NAMES
  ): Promise<ReadonlyArray<GenesisShopItem>> {
    const keys = await this.#client.getDynamicFieldObject({
      parentId: this.#objects.GENESIS_SHOP_ITEMS_ID,
      name: GENESIS_SHOP_NAMES[name],
    });

    const tableKeyIds = path(
      [
        'data',
        'content',
        'fields',
        'value',
        'fields',
        'contents',
        'fields',
        'id',
        'id',
      ],
      keys
    ) as string;

    const fields = await fetchAllDynamicFields(this.#client, tableKeyIds);
    const innerTableKeysIds = fields.map((elem) => elem.objectId);

    const chunks = chunkArray(innerTableKeysIds, 50);

    const promises = chunks.map((ids) =>
      this.#client.multiGetObjects({
        ids,
        options: { showContent: true },
      })
    );

    const items = await Promise.all(promises);

    return items
      .flatMap((x) => x!)
      .map((x) => {
        invariant(x && x.data, 'Failed to get data');

        return {
          objectId: x.data.objectId,
          version: x.data.version,
          digest: x.data.digest,
          hash: toHEX(
            Uint8Array.from(
              pathOr(
                [],
                ['data', 'content', 'fields', 'value', 'fields', 'hash'],
                x
              )
            )
          ),
          name: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'name'],
            x
          ),
          equipment: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'equipment'],
            x
          ),
          colourWay: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'colour_way'],
            x
          ),
          manufacturer: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'manufacturer'],
            x
          ),
          rarity: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'rarity'],
            x
          ),
          imageUrl: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'image_url'],
            x
          ),
          modelUrl: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'model_url'],
            x
          ),
          textureUrl: pathOr(
            '',
            ['data', 'content', 'fields', 'value', 'fields', 'texture_url'],
            x
          ),
        };
      });
  }

  /**
   * @notice Assumes the user does not have more than 50 passes
   */
  async getGenesisPasses(address: string): Promise<ReadonlyArray<GenesisPass>> {
    invariant(isValidSuiAddress(address), 'Please pass a valid Sui address');

    const passes = await this.#client.getOwnedObjects({
      owner: address,
      filter: {
        StructType: normalizeStructTag(
          `${this.#packages.ACT}::genesis_drop::GenesisPass`
        ),
      },
      options: {
        showContent: true,
        showType: true,
      },
    });

    if (!passes.data.length) return [];

    return passes.data.map((elem) => ({
      objectId: pathOr('', ['data', 'content', 'fields', 'id', 'id'], elem),
      phase: BigInt(pathOr(0n, ['data', 'content', 'fields', 'phase'], elem)),
      type: pathOr('', ['data', 'type'], elem),
      digest: pathOr('', ['data', 'digest'], elem),
      version: pathOr('', ['data', 'version'], elem),
    }));
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  airdropFreeMint({ recipient, tx = new Transaction() }: AirdropFreeMintArgs) {
    invariant(isValidSuiAddress(recipient), 'Please provide a valid recipient');

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::airdrop_freemint`,
      arguments: [
        tx.object(this.#objects.ACCESS_CONTROL),
        tx.object(this.#objects.ADMIN),
        tx.pure.address(recipient),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  airdropWhitelist({
    recipient,
    tx = new Transaction(),
  }: AirdropWhitelistArgs) {
    invariant(isValidSuiAddress(recipient), 'Please provide a valid recipient');

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::airdrop_whitelist`,
      arguments: [
        tx.object(this.#objects.ACCESS_CONTROL),
        tx.object(this.#objects.ADMIN),
        tx.pure.address(recipient),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setSaleActive({ active, tx = new Transaction() }: SetSaleActiveArgs) {
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_active`,
      arguments: [
        tx.object(this.#objects.SALE),
        tx.object(this.#objects.ACCESS_CONTROL),
        tx.object(this.#objects.ADMIN),
        tx.pure.bool(active),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   * @notice The times are in milliseconds. Each value is a sale phase.
   */
  setStartTimes({ startTimes, tx = new Transaction() }: SetStartTimesArgs) {
    invariant(startTimes.length == 3, 'There are only 3 phases');
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_start_times`,
      arguments: [
        tx.object(this.#objects.SALE),
        tx.object(this.#objects.ACCESS_CONTROL),
        tx.object(this.#objects.ADMIN),
        tx.pure.vector('u64', startTimes),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setMaxMints({ maxMints, tx = new Transaction() }: SetMaxMintsArgs) {
    invariant(maxMints.length == 3, 'There are only 3 phases');
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_max_mints`,
      arguments: [
        tx.object(this.#objects.SALE),
        tx.object(this.#objects.ACCESS_CONTROL),
        tx.object(this.#objects.ADMIN),
        tx.pure.vector('u64', maxMints),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setPrices({ prices, tx = new Transaction() }: SetPricesArgs) {
    invariant(prices.length == 3, 'There are only 3 phases');
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_prices`,
      arguments: [
        tx.object(this.#objects.SALE),
        tx.object(this.#objects.ACCESS_CONTROL),
        tx.object(this.#objects.ADMIN),
        tx.pure.vector('u64', prices),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setDropsLeft({ dropsLeft, tx = new Transaction() }: SetDropsLeftArgs) {
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_drops_left`,
      arguments: [
        tx.object(this.#objects.SALE),
        tx.object(this.#objects.ACCESS_CONTROL),
        tx.object(this.#objects.ADMIN),
        tx.pure.u64(dropsLeft),
      ],
    });

    return tx;
  }
}
