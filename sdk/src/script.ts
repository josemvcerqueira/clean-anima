import { getFullnodeUrl, OwnedObjectRef, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import { Transaction } from '@mysten/sui/transactions';
import dotenv from 'dotenv';

import { AnimaSDK } from './anima';

dotenv.config();

const client = new SuiClient({ url: getFullnodeUrl('testnet') });

const sleep = (ms = 0) => new Promise((resolve) => setTimeout(resolve, ms));

const keypair = Ed25519Keypair.fromSecretKey(
  Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
);

const executeTx = async (tx: Transaction) => {
  const result = await client.signAndExecuteTransaction({
    signer: keypair,
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

(async () => {
  const items = await sdk.getGenesisShopItems('HELM');
  console.log(items.length);
  console.log(items);
})();
