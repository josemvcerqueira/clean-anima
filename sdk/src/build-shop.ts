import { getFullnodeUrl, OwnedObjectRef, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import {
  SerialTransactionExecutor,
  Transaction,
} from '@mysten/sui/transactions';
import dotenv from 'dotenv';
import invariant from 'tiny-invariant';

import { AnimaSDK } from './anima';
import { OBJECTS, PACKAGES } from './constants';

dotenv.config();

const client = new SuiClient({ url: getFullnodeUrl('testnet') });

const adminKeypair = Ed25519Keypair.fromSecretKey(
  Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
);

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

const deployBuilder = (key: string, tx = new Transaction()) => {
  const builder = tx.moveCall({
    target: `${PACKAGES.ACT}::genesis_shop::${key}`,
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

export const executeTx = async (tx: Transaction) => {
  const result = await client.signAndExecuteTransaction({
    signer: adminKeypair,
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

  // get all created objects IDs
  const createdObjectIds = result.effects.created!.map(
    (item: OwnedObjectRef) => item.reference.objectId
  );

  // fetch objects data
  return client.multiGetObjects({
    ids: createdObjectIds,
    options: { showContent: true, showType: true, showOwner: true },
  });
};

const sdk = new AnimaSDK();
const DAY = 86400000;

// (async () => {
//   const avatar = await sdk.getAvatar(adminKeypair.toSuiAddress());
//   invariant(avatar);
//   console.log(await sdk.getAvatarItems(avatar.objectId));
// })();

(async () => {
  const tx = new Transaction();

  const admin = tx.moveCall({
    target:
      '0xad1654082fcb7d214be43b51fc00109e91d11af1dc929af5a6cc85c8657e7af4::access_control::new_admin',
    arguments: [tx.object(OBJECTS.ACCESS_CONTROL)],
  });

  tx.moveCall({
    target:
      '0xad1654082fcb7d214be43b51fc00109e91d11af1dc929af5a6cc85c8657e7af4::access_control::grant',
    arguments: [
      tx.object(OBJECTS.SUPER_ADMIN),
      tx.object(OBJECTS.ACCESS_CONTROL),
      tx.pure.vector(
        'u8',
        [
          71, 69, 78, 69, 83, 73, 83, 95, 77, 73, 78, 84, 69, 82, 95, 82, 79,
          76, 69,
        ]
      ),
      tx.moveCall({
        target:
          '0xad1654082fcb7d214be43b51fc00109e91d11af1dc929af5a6cc85c8657e7af4::access_control::addy',
        arguments: [admin],
      }),
    ],
  });

  tx.transferObjects(
    [admin],
    tx.pure.address(
      '0x23db92f4373fa9353ab56f8be76263432f9f93b2974e50e613265266f5d3d3e7'
    )
  );

  await executeTx(tx);
})();
