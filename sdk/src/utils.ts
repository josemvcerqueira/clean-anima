import { SuiObjectResponse } from '@mysten/sui/client';
import { toHEX } from '@mysten/sui/utils';
import { pathOr } from 'ramda';
import invariant from 'tiny-invariant';

export const parseGenesisShopItem = (x: SuiObjectResponse) => {
  invariant(x.data, 'Something went fetching the genesis shop item');
  return {
    objectId: x.data.objectId,
    version: x.data.version,
    digest: x.data.digest,
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
