import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { isValidSuiAddress } from '@mysten/sui/utils';
import invariant from 'tiny-invariant';

import { AnimaConstructorArgs } from './anima.types';

export class Anima {
  #client: SuiClient;
  #actPackageId: string;
  #animaPackageId: string;

  constructor({
    fullNodeUrl,
    actPackageId,
    animaPackageId,
  }: AnimaConstructorArgs) {
    invariant(fullNodeUrl, 'Provide a valid node url');
    invariant(
      isValidSuiAddress(actPackageId),
      'Provide a valid act package id'
    );
    invariant(
      isValidSuiAddress(animaPackageId),
      'Provide a valid anima package id'
    );

    this.#client = new SuiClient({
      url: fullNodeUrl ?? getFullnodeUrl('mainnet'),
    });
    this.#actPackageId = actPackageId;
    this.#animaPackageId = animaPackageId;
  }
}
