import { getFullnodeUrl, OwnedObjectRef, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import { Transaction } from '@mysten/sui/transactions';
import dotenv from 'dotenv';

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

(async () => {
  const tx = new Transaction();

  const admin = tx.moveCall({
    target:
      '0xb4d37fa68d148ae0ea3d48464415ee6969220de75f11f754aed007cebdec33df::access_control::new_admin',
    arguments: [tx.object(OBJECTS.ACCESS_CONTROL)],
  });

  tx.moveCall({
    target:
      '0xb4d37fa68d148ae0ea3d48464415ee6969220de75f11f754aed007cebdec33df::access_control::grant',
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
          '0xb4d37fa68d148ae0ea3d48464415ee6969220de75f11f754aed007cebdec33df::access_control::addy',
        arguments: [admin],
      }),
    ],
  });

  tx.transferObjects([admin], tx.pure.address(adminKeypair.toSuiAddress()));

  await executeTx(tx);
})();
