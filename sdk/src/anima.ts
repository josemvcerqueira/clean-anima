import { KioskClient, Network } from '@mysten/kiosk';
import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Transaction } from '@mysten/sui/transactions';
import {
  isValidSuiAddress,
  normalizeStructTag,
  SUI_CLOCK_OBJECT_ID,
  toHEX,
} from '@mysten/sui/utils';
import { chunkArray, fetchAllDynamicFields } from '@polymedia/suitcase-core';
import * as changeCase from 'change-case';
import { path, pathOr } from 'ramda';
import invariant from 'tiny-invariant';

import { GENESIS_SHOP_NAMES, OBJECTS, PACKAGES } from './constants';
import {
  AirdropFreeMintArgs,
  AirdropWhitelistArgs,
  AnimaConstructorArgs,
  Avatar,
  AvatarTicket,
  CreateAvatarArgs,
  GenerateImageUrlToAvatarTicketArgs,
  GenesisPass,
  GenesisShopItem,
  MaybeTx,
  MintToKioskArgs,
  MintToTicketArgs,
  SetDropsLeftArgs,
  SetMaxMintsArgs,
  SetPricesArgs,
  SetSaleActiveArgs,
  SetStartTimesArgs,
} from './types';
import { parseGenesisShopItem } from './utils';

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

  async getAvatarTicket(address: string): Promise<AvatarTicket | null> {
    invariant(isValidSuiAddress(address), 'Please pass a valid Sui address');

    const res = await this.#client.getOwnedObjects({
      owner: address,
      filter: {
        StructType: normalizeStructTag(
          `${this.#packages.ACT}::genesis_drop::AvatarTicket`
        ),
      },
      options: {
        showType: true,
        showContent: true,
      },
    });

    if (!res.data.length) return null;

    const elem = res.data[0];

    pathOr(null, ['data', 'content', 'fields', 'drop', 0, 'fields'], elem);

    return {
      objectId: pathOr('', ['data', 'objectId'], elem),
      version: pathOr('', ['data', 'version'], elem),
      digest: pathOr('', ['data', 'digest'], elem),
      type: pathOr('', ['data', 'type'], elem),
      imageUrl: pathOr('', ['data', 'content', 'fields', 'image_url'], elem),
      drops: pathOr([], ['data', 'content', 'fields', 'drop'], elem).map(
        (x) => {
          const fields = pathOr(null, ['fields'], x);
          invariant(fields, 'Failed to get item fields');

          return Object.keys(fields).reduce(
            (acc, elem) => ({
              ...acc,
              [changeCase.camelCase(elem)]:
                elem === 'hash' ? toHEX(fields[elem]) : fields[elem],
            }),
            {} as GenesisShopItem
          );
        }
      ),
    };
  }

  async generateImageUrlToAvatarTicket({
    tx = new Transaction(),
    imageUrl,
    sender,
  }: GenerateImageUrlToAvatarTicketArgs) {
    const ticket = await this.getAvatarTicket(sender);

    invariant(ticket, 'Mint an AvatarTicket first');

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::generate_image_to_ticket`,
      arguments: [tx.object(ticket?.objectId), tx.pure.string(imageUrl)],
    });

    return tx;
  }

  async getAvatar(address: string): Promise<Avatar | null> {
    invariant(isValidSuiAddress(address), 'Please pass a valid Sui address');

    const res = await this.#client.getOwnedObjects({
      owner: address,
      filter: {
        StructType: normalizeStructTag(`${this.#packages.ACT}::avatar::Avatar`),
      },
      options: {
        showType: true,
        showContent: true,
      },
    });

    if (!res.data.length) return null;

    const elem = res.data[0];

    return {
      objectId: pathOr('', ['data', 'objectId'], elem),
      version: pathOr('', ['data', 'version'], elem),
      digest: pathOr('', ['data', 'digest'], elem),
      type: pathOr('', ['data', 'type'], elem),
      avatarImage: pathOr(
        '',
        ['data', 'content', 'fields', 'avatar_image'],
        elem
      ),
      avatarModel: pathOr(
        '',
        ['data', 'content', 'fields', 'avatar_model'],
        elem
      ),
      avatarTexture: pathOr(
        '',
        ['data', 'content', 'fields', 'avatar_texture'],
        elem
      ),
      edition: pathOr('', ['data', 'content', 'fields', 'edition'], elem),
      imageUrl: pathOr('', ['data', 'content', 'fields', 'image_url'], elem),
      upgrades: pathOr([], ['data', 'content', 'fields', 'upgrades'], elem),
      attributes: pathOr(
        [] as Record<string, string>[],
        ['data', 'content', 'fields', 'attributes', 'fields', 'contents'],
        elem
      ).reduce(
        (acc, elem) => {
          const data = pathOr({} as Record<string, string>, ['fields'], elem);
          return {
            ...acc,
            [changeCase.camelCase(data.key)]: data.value,
          };
        },
        {} as Record<string, string>
      ),
      misc: pathOr(
        [] as Record<string, string>[],
        ['data', 'content', 'fields', 'misc', 'fields', 'contents'],
        elem
      ).reduce(
        (acc, elem) => {
          const data = pathOr({} as Record<string, string>, ['fields'], elem);
          return {
            ...acc,
            [changeCase.camelCase(data.key)]: data.value,
          };
        },
        {} as Record<string, string>
      ),
    };
  }

  async getCap(address: string) {
    invariant(isValidSuiAddress(address), 'Please pass a valid Sui address');

    const { kioskOwnerCaps } = await this.#kioskClient.getOwnedKiosks({
      address,
    });

    return kioskOwnerCaps[0];
  }

  createAvatar({ tx = new Transaction(), imageUrl }: CreateAvatarArgs) {
    const avatar = tx.moveCall({
      target: `${this.#packages.ACT}::avatar::new`,
      arguments: [
        tx.object(this.#objects.AVATAR_REGISTRY),
        tx.pure.string(imageUrl),
      ],
    });

    tx.moveCall({
      target: `${this.#packages.ACT}::avatar::keep`,
      arguments: [avatar],
    });

    return tx;
  }

  async mintToAvatar({
    tx = new Transaction(),
    sender,
  }: MaybeTx & { sender: string }) {
    const ticket = await this.getAvatarTicket(sender);

    invariant(ticket, 'Mint an AvatarTicket first');

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::mint_to_avatar`,
      arguments: [
        tx.object(ticket.objectId),
        tx.object(this.#objects.AVATAR_REGISTRY),
        tx.object(SUI_CLOCK_OBJECT_ID),
      ],
    });

    return tx;
  }

  async mintToKiosk({
    tx = new Transaction(),
    nftQuantity,
    suiValue,
    sender,
  }: MintToKioskArgs) {
    invariant(nftQuantity > 0, 'You must mint at least one kiosk');

    const payment = tx.splitCoins(tx.gas, [tx.pure.u64(suiValue)]);

    const { kioskOwnerCaps } = await this.#kioskClient.getOwnedKiosks({
      address: sender,
    });

    // const kioskTx = new KioskTransaction({
    //   kioskClient: this.#kioskClient,
    //   transaction: tx,
    //   cap: kioskCap,
    // });

    // if (!kioskCap) kioskTx.create();

    const passes = await this.getGenesisPasses(sender);

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::mint_to_kiosk`,
      arguments: [
        tx.object(this.#objects.SALE),
        tx.object(this.#objects.GENESIS_SHOP),
        tx.object(this.#objects.AVATAR_REGISTRY),
        tx.makeMoveVec({
          elements: [passes[0].objectId],
          type: `${this.#packages.ACT}::genesis_drop::GenesisPass`,
        }),
        tx.object(kioskOwnerCaps[0].kioskId),
        tx.object(kioskOwnerCaps[0].objectId),
        payment,
        tx.pure.u64(nftQuantity),
        tx.object(SUI_CLOCK_OBJECT_ID),
      ],
    });

    // if (!kioskCap) {
    //   kioskTx.shareAndTransferCap(sender);
    // }

    // kioskTx.finalize();

    return tx;
  }

  async mintToTicket({
    tx = new Transaction(),
    suiValue,
    sender,
  }: MintToTicketArgs) {
    const payment = tx.splitCoins(tx.gas, [tx.pure.u64(suiValue)]);

    const passes = await this.getGenesisPasses(sender);

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::mint_to_ticket`,
      arguments: [
        tx.object(this.#objects.SALE),
        tx.object(this.#objects.GENESIS_SHOP),
        tx.object(this.#objects.AVATAR_REGISTRY),
        tx.makeMoveVec({
          elements: [passes[0].objectId],
          type: `${this.#packages.ACT}::genesis_drop::GenesisPass`,
        }),
        payment,
        tx.object(SUI_CLOCK_OBJECT_ID),
      ],
    });

    return tx;
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

        return parseGenesisShopItem(x);
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
