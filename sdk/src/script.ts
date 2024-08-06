import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Signer } from '@mysten/sui/cryptography';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import { Transaction } from '@mysten/sui/transactions';
import dotenv from 'dotenv';

import { AnimaSDK } from './anima';
import { OBJECTS, PACKAGES } from './constants';

dotenv.config();

const client = new SuiClient({ url: getFullnodeUrl('testnet') });

const sleep = (ms = 0) => new Promise((resolve) => setTimeout(resolve, ms));

const adminKeypair = Ed25519Keypair.fromSecretKey(
  Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
);

const aliceKeyPair = Ed25519Keypair.deriveKeypair(
  'harvest pass loyal goat diagram lesson atom talent pigeon flash brush super'
);

const executeTx = async (tx: Transaction, signer: Signer) => {
  const result = await client.signAndExecuteTransaction({
    signer,
    transaction: tx,
    options: {
      showEffects: true,
    },
    requestType: 'WaitForLocalExecution',
  });

  // return if the tx hasn't succeed
  if (result.effects?.status?.status !== 'success') {
    console.log('\n\nCreating a new stable pool failed');
    return;
  }

  console.log('SUCCESS!');

  const createdObjectIds = result.effects.created!.map(
    (item: OwnedObjectRef) => item.reference.objectId
  );

  const createdObjects = await client.multiGetObjects({
    ids: createdObjectIds,
    options: { showContent: true, showType: true },
  });

  console.log(createdObjects);
};

const sdk = new AnimaSDK();

const DAY = 86400000n;

const addItem = (builder: string, tx = new Transaction()) => {
  let i = 0;
  while (30 > i) {
    tx.moveCall({
      target: `${PACKAGES.ACT}::genesis_shop::new_item`,
      arguments: [tx.object(OBJECTS.GENESIS_SHOP), tx.object(builder)],
    });
    i++;
  }

  return tx;
};

const destroy = (builder: string, tx = new Transaction()) => {
  tx.moveCall({
    target: `${PACKAGES.ACT}::genesis_shop::destroy_builder`,
    arguments: [tx.object(builder)],
  });

  return tx;
};

const deployBuilder = (tx = new Transaction()) => {
  const builder = tx.moveCall({
    target: `${PACKAGES.ACT}::genesis_shop::add_tertiary`,
    arguments: [
      tx.object(OBJECTS.GENESIS_SHOP),
      tx.object(OBJECTS.ACCESS_CONTROL),
      tx.object(OBJECTS.ADMIN),
    ],
  });

  tx.moveCall({
    target: `${PACKAGES.ACT}::genesis_shop::keep`,
    arguments: [tx.object(builder)],
  });

  return tx;
};

(async () => {
  const items = await sdk.getGenesisShopItems('BELT');
  console.log(items.filter((item) => item.imageUrl === ''));
})();
