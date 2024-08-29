import { KioskClient, KioskTransaction, Network } from '@mysten/kiosk';
import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Transaction } from '@mysten/sui/transactions';
import {
  isValidSuiAddress,
  isValidSuiObjectId,
  normalizeStructTag,
  normalizeSuiObjectId,
  SUI_CLOCK_OBJECT_ID,
} from '@mysten/sui/utils';
import { chunkArray, fetchAllDynamicFields } from '@polymedia/suitcase-core';
import * as changeCase from 'change-case';
import { path, pathOr } from 'ramda';
import invariant from 'tiny-invariant';

import {
  GENESIS_SHOP_NAMES,
  OWNED_OBJECTS,
  PACKAGES,
  SHARED_OBJECTS,
} from './constants';
import {
  AddAccoladeArgs,
  AirdropFreeMintArgs,
  AirdropWhitelistArgs,
  AnimaConstructorArgs,
  Avatar,
  EquipCosmeticsArgs,
  EquipWeaponsArgs,
  GenesisPass,
  GenesisShopItem,
  GiveReputationArgs,
  MintToKioskArgs,
  NewAnimaAccountArgs,
  RemoveAccoladeArgs,
  RemoveReputationArgs,
  SetDropsLeftArgs,
  SetMaxMintsArgs,
  SetPricesArgs,
  SetSaleActiveArgs,
  SetStartTimesArgs,
  UnequipCosmeticsArgs,
  UnequipWeaponsArgs,
  UpdateAliasArgs,
  UpdateUsernameArgs,
} from './types';
import {
  parseGenesisShopItem,
  parseImageObjectResponse,
  parseKioskItem,
} from './utils';

export class AnimaSDK {
  #packages: typeof PACKAGES;
  #sharedObjects: typeof SHARED_OBJECTS;
  #genesisShopItemsId: string;
  #client: SuiClient;
  #kioskClient: KioskClient;

  constructor(args: AnimaConstructorArgs | null | undefined = null) {
    const data = args
      ? args
      : {
          packages: PACKAGES,
          sharedObjects: SHARED_OBJECTS,
          genesisShopItemsId: OWNED_OBJECTS.GENESIS_SHOP_ITEMS_ID,
          fullNodeUrl: getFullnodeUrl('testnet'),
        };

    this.#packages = data.packages || PACKAGES;
    this.#sharedObjects = data.sharedObjects || SHARED_OBJECTS;
    this.#genesisShopItemsId =
      data.genesisShopItemsId || OWNED_OBJECTS.GENESIS_SHOP_ITEMS_ID;

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

  newAnimaAccount({
    tx = new Transaction(),
    alias,
    username,
  }: NewAnimaAccountArgs) {
    const account = tx.moveCall({
      target: `${this.#packages.ANIMA}::account::new`,
      arguments: [
        tx.object(this.#sharedObjects?.SYSTEM_MUT),
        tx.pure.string(alias),
        tx.pure.string(username),
        tx.object(SUI_CLOCK_OBJECT_ID),
      ],
    });

    tx.moveCall({
      target: `${this.#packages.ANIMA}::account::keep`,
      arguments: [account],
    });

    return tx;
  }

  updateAlias({ tx = new Transaction(), alias, account }: UpdateAliasArgs) {
    invariant(isValidSuiObjectId(account), 'invalid Acount Id');
    tx.moveCall({
      target: `${this.#packages.ANIMA}::account::update_alias`,
      arguments: [tx.object(account), tx.pure.string(alias)],
    });

    return tx;
  }

  updateUsername({
    tx = new Transaction(),
    username,
    account,
  }: UpdateUsernameArgs) {
    invariant(isValidSuiObjectId(account), 'invalid Acount Id');
    tx.moveCall({
      target: `${this.#packages.ANIMA}::account::update_username`,
      arguments: [tx.object(account), tx.pure.string(username)],
    });

    return tx;
  }

  async getAvatarItems(avatar: string) {
    invariant(isValidSuiObjectId(avatar), 'It is not a valid object');

    const fields = await fetchAllDynamicFields(this.#client, avatar);

    const chunks = chunkArray(fields, 50);

    const results = await Promise.all(
      chunks.map((items) =>
        this.#client.multiGetObjects({
          ids: items.map((item) => item.objectId),
          options: {
            showContent: true,
            showType: true,
          },
        })
      )
    );

    return results.flat().map((x) => parseKioskItem(x));
  }

  async getOwnedAvatarImages(objectId: string) {
    const data = await this.#client.getOwnedObjects({
      owner: objectId,
      options: { showType: true, showContent: true },
    });

    const avatarImages = data.data.filter(
      (elem) => elem.data?.type === `${this.#packages.ACT}::avatar::AvatarImage`
    );

    if (!avatarImages.length) return [];

    return data.data.map((elem) => parseImageObjectResponse(elem));
  }

  async getPersonalKiosks(address: string) {
    const { kioskOwnerCaps } = await this.#kioskClient.getOwnedKiosks({
      address,
    });

    return kioskOwnerCaps.filter((cap) => cap.isPersonal);
  }

  async getItemsInKiosk(address: string) {
    invariant(isValidSuiAddress(address), 'Please pass a valid Sui address');

    const { kioskOwnerCaps } = await this.#kioskClient.getOwnedKiosks({
      address,
    });

    if (!kioskOwnerCaps.length) return [];

    const promises = kioskOwnerCaps
      .filter((cap) => cap?.isPersonal)
      .map((elem) =>
        this.#kioskClient.getKiosk({
          id: elem.kioskId,
          options: {
            withObjects: true,
          },
        })
      );

    const result = await Promise.all(promises);

    const unparsedItems = result
      .map((x) => x.items)
      .flat()
      .filter(
        (item) =>
          item.type === `${this.#packages.ACT}::cosmetic::Cosmetic` ||
          item.type === `${this.#packages.ACT}::weapon::Weapon`
      )
      .map((item) => ({
        ...item,
        cap: kioskOwnerCaps.find(
          (x) =>
            normalizeSuiObjectId(x.kioskId) ===
            normalizeSuiObjectId(item.kioskId)
        )!.objectId,
      }));

    const capMap = unparsedItems.reduce(
      (acc, elem) => ({
        ...acc,
        [elem.objectId]: { cap: elem.cap, kioskId: elem.kioskId },
      }),
      {} as Record<string, { cap: string; kioskId: string }>
    );

    const chunks = chunkArray(
      unparsedItems.map((x) => x.objectId),
      50
    );

    const promiseArray = chunks.map((ids) =>
      this.#client.multiGetObjects({
        ids,
        options: { showContent: true, showType: true },
      })
    );

    const items = await Promise.all(promiseArray);

    return items.flat().map((x) => {
      invariant(x && x.data, 'Failed to get data');
      invariant(x.data.objectId);

      return { ...capMap[x.data.objectId], ...parseKioskItem(x) };
    });
  }

  async equipWeapons({
    avatarId,
    weaponIds,
    weaponSlots,
    sender,
    tx = new Transaction(),
  }: EquipWeaponsArgs) {
    invariant(
      weaponIds.length === weaponSlots.length && weaponIds.length != 0,
      'Mismatch configuration'
    );
    invariant(isValidSuiObjectId(avatarId), 'Invalid avatar id');
    const allItems = await this.getItemsInKiosk(sender);

    const record = weaponIds.reduce(
      (acc, id, i) => ({
        ...acc,
        [normalizeSuiObjectId(id)]: weaponSlots[i],
      }),
      {} as Record<string, string>
    );

    const items = allItems.filter((item) =>
      weaponIds
        .map((id) => normalizeSuiObjectId(id))
        .includes(normalizeSuiObjectId(item.objectId))
    );

    const [cap, borrow] = tx.moveCall({
      target: `${this.#packages.KIOSK}::personal_kiosk::borrow_val`,
      arguments: [tx.object(item.cap)],
    });

    tx.moveCall({
      target: `${this.#packages.ACT}::avatar::equip_weapons`,
      arguments: [
        tx.object(avatarId),
        tx.pure.vector(
          'id',
          items.map((elem) => elem.objectId)
        ),
        tx.pure.vector(
          'string',
          items.map((elem) => record[elem.objectId])
        ),
        tx.object(item.kioskId),
        tx.object(cap),
        tx.object(this.#sharedObjects.WEAPON_TRANSFER_POLICY_EQUIP),
      ],
    });

    tx.moveCall({
      target: `${this.#packages.KIOSK}::personal_kiosk::return_val`,
      arguments: [tx.object(item.cap), cap, borrow],
    });

    return tx;
  }

  async unequipWeapons({
    avatarId,
    weaponSlots,
    sender,
    tx = new Transaction(),
  }: UnequipWeaponsArgs) {
    invariant(weaponSlots.length, 'You must unequip at leas one weapon');
    const { kioskOwnerCaps } = await this.#kioskClient.getOwnedKiosks({
      address: sender,
    });
    invariant(isValidSuiObjectId(avatarId), 'Invalid avatar id');

    const cap = kioskOwnerCaps.find((cap) => cap.isPersonal);

    const kioskTx = new KioskTransaction({
      kioskClient: this.#kioskClient,
      transaction: tx,
      cap,
    });

    if (!cap) {
      kioskTx.createPersonal(true);
    }

    weaponSlots.forEach((slot) => {
      tx.moveCall({
        target: `${this.#packages.ACT}::avatar::unequip_weapon`,
        arguments: [
          tx.object(avatarId),
          tx.pure.string(slot),
          kioskTx.getKiosk(),
          kioskTx.getKioskCap(),
          tx.object(this.#sharedObjects.WEAPON_TRANSFER_POLICY_EQUIP),
        ],
      });
    });

    kioskTx.finalize();

    return tx;
  }

  async equipCosmetics({
    avatarId,
    cosmeticIds,
    cosmeticTypes,
    sender,
    tx = new Transaction(),
  }: EquipCosmeticsArgs) {
    invariant(
      cosmeticIds.length === cosmeticTypes.length && cosmeticTypes.length != 0,
      'Mismatch configuration'
    );

    invariant(isValidSuiObjectId(avatarId), 'Invalid avatar id');
    const allItems = await this.getItemsInKiosk(sender);

    const record = cosmeticIds.reduce(
      (acc, id, i) => ({
        ...acc,
        [normalizeSuiObjectId(id)]: cosmeticTypes[i],
      }),
      {} as Record<string, string>
    );

    const items = allItems.filter((item) =>
      cosmeticIds
        .map((id) => normalizeSuiObjectId(id))
        .includes(normalizeSuiObjectId(item.objectId))
    );

    items.forEach((item) => {
      const [cap, borrow] = tx.moveCall({
        target: `${this.#packages.KIOSK}::personal_kiosk::borrow_val`,
        arguments: [tx.object(item.cap)],
      });

      tx.moveCall({
        target: `${this.#packages.ACT}::avatar::equip_cosmetic`,
        arguments: [
          tx.object(avatarId),
          tx.pure.id(item.objectId),
          tx.pure.string(record[item.objectId]),
          tx.object(item.kioskId),
          tx.object(cap),
          tx.object(this.#sharedObjects.COSMETIC_TRANSFER_POLICY_EQUIP),
        ],
      });

      tx.moveCall({
        target: `${this.#packages.KIOSK}::personal_kiosk::return_val`,
        arguments: [tx.object(item.cap), cap, borrow],
      });
    });

    return tx;
  }

  async unequipCosmetics({
    avatarId,
    cosmeticTypes,
    sender,
    tx = new Transaction(),
  }: UnequipCosmeticsArgs) {
    invariant(
      cosmeticTypes.length != 0,
      'You must unequip at least one cosmetic'
    );
    const { kioskOwnerCaps } = await this.#kioskClient.getOwnedKiosks({
      address: sender,
    });
    invariant(isValidSuiObjectId(avatarId), 'Invalid avatar id');

    const cap = kioskOwnerCaps.find((cap) => cap.isPersonal);

    const kioskTx = new KioskTransaction({
      kioskClient: this.#kioskClient,
      transaction: tx,
      cap,
    });

    if (!cap) {
      kioskTx.createPersonal(true);
    }

    cosmeticTypes.forEach((type) => {
      tx.moveCall({
        target: `${this.#packages.ACT}::avatar::unequip_cosmetic`,
        arguments: [
          tx.object(avatarId),
          tx.pure.string(type),
          kioskTx.getKiosk(),
          kioskTx.getKioskCap(),
          tx.object(this.#sharedObjects.COSMETIC_TRANSFER_POLICY_EQUIP),
        ],
      });
    });

    kioskTx.finalize();

    return tx;
  }

  async getAvatars(address: string): Promise<Avatar[] | null> {
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

    const x = res.data;

    return x.map((elem) => {
      return {
        objectId: pathOr('', ['data', 'objectId'], elem),
        version: pathOr('', ['data', 'version'], elem),
        digest: pathOr('', ['data', 'digest'], elem),
        type: pathOr('', ['data', 'type'], elem),
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
        attributesHash: pathOr(
          [] as Record<string, string>[],
          [
            'data',
            'content',
            'fields',
            'attributes_hash',
            'fields',
            'contents',
          ],
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
    });
  }

  newAvatar({ tx = new Transaction() }) {
    const avatar = tx.moveCall({
      target: `${this.#packages.ACT}::avatar::new`,
      arguments: [tx.object(this.#sharedObjects.AVATAR_SETTINGS)],
    });

    tx.moveCall({
      target: `${this.#packages.ACT}::avatar::keep`,
      arguments: [avatar],
    });

    return tx;
  }

  async mintToKiosk({
    tx = new Transaction(),
    nftQuantity,
    suiValue,
    sender,
    passId,
  }: MintToKioskArgs) {
    invariant(nftQuantity > 0, 'You must mint at least one kiosk');

    const payment = tx.splitCoins(tx.gas, [tx.pure.u64(suiValue)]);

    const { kioskOwnerCaps } = await this.#kioskClient.getOwnedKiosks({
      address: sender,
    });

    const cap = kioskOwnerCaps.find((cap) => cap.isPersonal);

    const kioskTx = new KioskTransaction({
      kioskClient: this.#kioskClient,
      transaction: tx,
      cap,
    });

    if (!cap) {
      kioskTx.createPersonal(true);
    }

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::mint_to_kiosk`,
      arguments: [
        tx.object(this.#sharedObjects.SALE_MUT),
        tx.object(this.#sharedObjects.GENESIS_SHOP_MUT),
        passId
          ? tx.makeMoveVec({
              elements: [passId],
              type: `${this.#packages.ACT}::genesis_drop::GenesisPass`,
            })
          : tx.moveCall({
              target: '0x1::vector::empty',
              typeArguments: [
                `${this.#packages.ACT}::genesis_drop::GenesisPass`,
              ],
            }),
        kioskTx.getKiosk(),
        kioskTx.getKioskCap(),
        payment,
        tx.pure.u64(nftQuantity),
        tx.object(SUI_CLOCK_OBJECT_ID),
      ],
    });

    kioskTx.finalize();

    return tx;
  }

  async getGenesisShopItems(
    name: keyof typeof GENESIS_SHOP_NAMES
  ): Promise<ReadonlyArray<GenesisShopItem>> {
    const keys = await this.#client.getDynamicFieldObject({
      parentId: this.#genesisShopItemsId,
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
        options: { showContent: true, showType: true },
      })
    );

    const items = await Promise.all(promises);

    return items.flat().map((x) => {
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
  airdropFreeMint({
    recipient,
    adminCap,
    tx = new Transaction(),
  }: AirdropFreeMintArgs) {
    invariant(isValidSuiAddress(recipient), 'Please provide a valid recipient');

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::airdrop_freemint`,
      arguments: [
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
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
    adminCap,
    tx = new Transaction(),
  }: AirdropWhitelistArgs) {
    invariant(isValidSuiAddress(recipient), 'Please provide a valid recipient');

    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::airdrop_whitelist`,
      arguments: [
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.address(recipient),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setSaleActive({
    active,
    adminCap,
    tx = new Transaction(),
  }: SetSaleActiveArgs) {
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_active`,
      arguments: [
        tx.object(this.#sharedObjects.SALE_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.bool(active),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   * @notice The times are in milliseconds. Each value is a sale phase.
   */
  setStartTimes({
    startTimes,
    adminCap,
    tx = new Transaction(),
  }: SetStartTimesArgs) {
    invariant(startTimes.length == 3, 'There are only 3 phases');
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_start_times`,
      arguments: [
        tx.object(this.#sharedObjects.SALE_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.vector('u64', startTimes),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setMaxMints({ maxMints, adminCap, tx = new Transaction() }: SetMaxMintsArgs) {
    invariant(maxMints.length == 3, 'There are only 3 phases');
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_max_mints`,
      arguments: [
        tx.object(this.#sharedObjects.SALE_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.vector('u64', maxMints),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setPrices({ prices, adminCap, tx = new Transaction() }: SetPricesArgs) {
    invariant(prices.length == 3, 'There are only 3 phases');
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_prices`,
      arguments: [
        tx.object(this.#sharedObjects.SALE_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.vector('u64', prices),
      ],
    });

    return tx;
  }

  /**
   * @notice This account must hold an AdminCap with sufficient permissions
   */
  setDropsLeft({
    dropsLeft,
    adminCap,
    tx = new Transaction(),
  }: SetDropsLeftArgs) {
    tx.moveCall({
      target: `${this.#packages.ACT}::genesis_drop::set_drops_left`,
      arguments: [
        tx.object(this.#sharedObjects.SALE_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.u64(dropsLeft),
      ],
    });

    return tx;
  }

  giveReputation({
    tx = new Transaction(),
    account,
    recipient,
    type,
    description,
    url,
    positive,
    value,
  }: GiveReputationArgs) {
    tx.moveCall({
      target: `${this.#packages.ANIMA}::account::give_reputation`,
      arguments: [
        tx.object(this.#sharedObjects.SYSTEM_MUT),
        tx.object(account),
        tx.pure.address(recipient),
        tx.pure.string(type),
        tx.pure.u64(value),
        tx.pure.bool(positive),
        tx.pure.string(description),
        tx.pure.string(url),
      ],
    });
    return tx;
  }

  removeReputation({
    account,
    index,
    adminCap,
    tx = new Transaction(),
  }: RemoveReputationArgs) {
    tx.moveCall({
      target: `${this.#packages.ANIMA}::account::remove_reputation`,
      arguments: [
        tx.object(this.#sharedObjects.SYSTEM_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.address(account),
        tx.pure.u64(index),
      ],
    });
    return tx;
  }

  addAccolade({
    description,
    recipient,
    type,
    url,
    adminCap,
    tx = new Transaction(),
  }: AddAccoladeArgs) {
    tx.moveCall({
      target: `${this.#packages.ANIMA}::account::add_accolade`,
      arguments: [
        tx.object(this.#sharedObjects.SYSTEM_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.address(recipient),
        tx.pure.string(type),
        tx.pure.string(description),
        tx.pure.string(url),
      ],
    });
    return tx;
  }

  removeAccolade({
    account,
    index,
    adminCap,
    tx = new Transaction(),
  }: RemoveAccoladeArgs) {
    tx.moveCall({
      target: `${this.#packages.ANIMA}::account::remove_accolade`,
      arguments: [
        tx.object(this.#sharedObjects.SYSTEM_MUT),
        tx.object(this.#sharedObjects.ACCESS_CONTROL),
        tx.object(adminCap),
        tx.pure.address(account),
        tx.pure.u64(index),
      ],
    });
    return tx;
  }
}
