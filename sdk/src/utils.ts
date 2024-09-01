import { SuiObjectResponse } from '@mysten/sui/client';
import { toHEX } from '@mysten/sui/utils';
import * as changeCase from 'change-case';
import { pathOr } from 'ramda';
import invariant from 'tiny-invariant';

export const parseGenesisShopItem = (x: SuiObjectResponse) => {
  invariant(x.data, 'Something went fetching the genesis shop item');

  return {
    objectId: x.data.objectId,
    version: x.data.version,
    digest: x.data.digest,
    type: x.data.type,
    hash: toHEX(
      Uint8Array.from(
        pathOr([], ['data', 'content', 'fields', 'value', 'fields', 'hash'], x)
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
};

export const parseKioskItem = (x: SuiObjectResponse) => {
  invariant(x.data, 'Something went wrong fetching the items data');

  return {
    objectId: x.data.objectId,
    version: x.data.version,
    digest: x.data.digest,
    type: x.data.type,
    hash: toHEX(
      Uint8Array.from(pathOr([], ['data', 'content', 'fields', 'hash'], x))
    ),
    name: pathOr('', ['data', 'content', 'fields', 'name'], x),
    colourWay: pathOr('', ['data', 'content', 'fields', 'colour_way'], x),
    manufacturer: pathOr('', ['data', 'content', 'fields', 'manufacturer'], x),
    rarity: pathOr('', ['data', 'content', 'fields', 'rarity'], x),
    imageUrl: pathOr('', ['data', 'content', 'fields', 'image_url'], x),
    modelUrl: pathOr('', ['data', 'content', 'fields', 'model_url'], x),
    textureUrl: pathOr('', ['data', 'content', 'fields', 'texture_url'], x),
    edition: pathOr('', ['data', 'content', 'fields', 'edition'], x),
    wearRating: pathOr('', ['data', 'content', 'fields', 'wear_rating'], x),
    equipment:
      pathOr('', ['data', 'content', 'fields', 'slot'], x) ||
      pathOr('', ['data', 'content', 'fields', 'type'], x),
  };
};

export const parseAvatar = (elem: SuiObjectResponse) => {
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
    attributesHash: pathOr(
      [] as Record<string, string>[],
      ['data', 'content', 'fields', 'attributes_hash', 'fields', 'contents'],
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
};

export const parseSales = (data: SuiObjectResponse) => {
  return {
    objectId: pathOr('', ['data', 'content', 'fields', 'id', 'id'], data),
    active: pathOr(false, ['data', 'content', 'fields', 'active'], data),
    prices: pathOr([], ['data', 'content', 'fields', 'prices'], data),
    maxMints: pathOr([], ['data', 'content', 'fields', 'max_mints'], data),
    dropsLeft: BigInt(
      pathOr(0n, ['data', 'content', 'fields', 'drops_left'], data)
    ),
    type: pathOr('', ['data', 'content', 'type'], data),
    digest: pathOr('', ['data', 'digest'], data),
    version: pathOr('', ['data', 'version'], data),
  };
};

export const parseGenesisPass = (elem: SuiObjectResponse) => {
  return {
    objectId: pathOr('', ['data', 'content', 'fields', 'id', 'id'], elem),
    phase: BigInt(pathOr(0n, ['data', 'content', 'fields', 'phase'], elem)),
    name: pathOr('', ['data', 'content', 'fields', 'name'], elem),
    imageUrl: pathOr('', ['data', 'content', 'fields', 'image_url'], elem),
    description: pathOr('', ['data', 'content', 'fields', 'description'], elem),
    type: pathOr('', ['data', 'type'], elem),
    digest: pathOr('', ['data', 'digest'], elem),
    version: pathOr('', ['data', 'version'], elem),
  };
};
