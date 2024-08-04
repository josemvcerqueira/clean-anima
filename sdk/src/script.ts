import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Signer } from '@mysten/sui/cryptography';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import { Transaction } from '@mysten/sui/transactions';
import dotenv from 'dotenv';

import { AnimaSDK } from './anima';

dotenv.config();

const client = new SuiClient({ url: getFullnodeUrl('testnet') });

// const sleep = (ms = 0) => new Promise((resolve) => setTimeout(resolve, ms));

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

  console.log(result.effects);

  // const createdObjectIds = result.effects.created!.map(
  //   (item: OwnedObjectRef) => item.reference.objectId
  // );

  // const createdObjects = await client.multiGetObjects({
  //   ids: createdObjectIds,
  //   options: { showContent: true, showType: true },
  // });

  // console.log(createdObjects);
};

const sdk = new AnimaSDK();

// const DAY = 86400000n;

(async () => {
  await executeTx(
    await sdk.mintToAvatar({ sender: aliceKeyPair.toSuiAddress() }),
    aliceKeyPair
  );
})();
