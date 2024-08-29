import { getFullnodeUrl, OwnedObjectRef, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import {
  GasData,
  SerialTransactionExecutor,
  Transaction,
} from '@mysten/sui/transactions';
import { fetchAllDynamicFields } from '@polymedia/suitcase-core';
import dotenv from 'dotenv';
import invariant from 'tiny-invariant';
import util from 'util';

import { AnimaSDK } from './anima';
import {
  BUILDER_FN_NAMES,
  OWNED_OBJECTS,
  PACKAGES,
  SHARED_OBJECTS,
} from './constants';

dotenv.config();

const client = new SuiClient({
  url: getFullnodeUrl('testnet'),
});

export const log = (x: unknown) =>
  console.log(util.inspect(x, false, null, true));

const adminKeypair = Ed25519Keypair.fromSecretKey(
  Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
);

const addItem = (builder: string, tx = new Transaction()) => {
  tx.setGasBudget(5_000_000_000);
  let i = 0;
  while (60 > i) {
    tx.moveCall({
      target: `${PACKAGES.ACT}::genesis_shop::new_item`,
      arguments: [
        tx.object(SHARED_OBJECTS.GENESIS_SHOP_MUT),
        tx.object(builder),
      ],
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

// const deployBuilder = (key: string, tx = new Transaction()) => {
//   tx.setGasBudget(500_000_000n);
//   const builder = tx.moveCall({
//     target: `${PACKAGES.ACT}::genesis_shop::${key}`,
//     arguments: [
//       tx.object(SHARED_OBJECTS.GENESIS_SHOP_MUT),
//       tx.object(SHARED_OBJECTS.ACCESS_CONTROL),
//       tx.object(OWNED_OBJECTS.ADMIN),
//     ],
//   });

//   tx.moveCall({
//     target: `${PACKAGES.ACT}::genesis_shop::keep`,
//     arguments: [tx.object(builder)],
//   });

//   return tx;
// };

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
  const createdObjectIds = result.effects.created?.map(
    (item: OwnedObjectRef) => item.reference.objectId
  );

  if (createdObjectIds)
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

// const giveAllAdminRoles = async (recipient: string) => {
//   const tx = new Transaction();

//   const admin = tx.moveCall({
//     target: `${PACKAGES.ANIMA_LIB}::access_control::new_admin`,
//     arguments: [tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT)],
//   });

//   tx.moveCall({
//     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
//     arguments: [
//       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
//       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
//       tx.pure.vector(
//         'u8',
//         [83, 85, 80, 69, 82, 95, 65, 68, 77, 73, 78, 95, 82, 79, 76, 69]
//       ),
//       tx.moveCall({
//         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
//         arguments: [admin],
//       }),
//     ],
//   });

//   tx.moveCall({
//     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
//     arguments: [
//       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
//       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
//       tx.pure.vector(
//         'u8',
//         [65, 67, 67, 79, 76, 65, 68, 69, 83, 95, 82, 79, 76, 69]
//       ),
//       tx.moveCall({
//         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
//         arguments: [admin],
//       }),
//     ],
//   });

//   tx.moveCall({
//     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
//     arguments: [
//       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
//       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
//       tx.pure.vector(
//         'u8',
//         [82, 69, 80, 85, 84, 65, 84, 73, 79, 78, 95, 82, 79, 76, 69]
//       ),
//       tx.moveCall({
//         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
//         arguments: [admin],
//       }),
//     ],
//   });

//   tx.moveCall({
//     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
//     arguments: [
//       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
//       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
//       tx.pure.vector(
//         'u8',
//         [85, 80, 71, 82, 65, 68, 69, 83, 95, 82, 79, 76, 69]
//       ),
//       tx.moveCall({
//         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
//         arguments: [admin],
//       }),
//     ],
//   });

//   tx.moveCall({
//     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
//     arguments: [
//       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
//       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
//       tx.pure.vector(
//         'u8',
//         [
//           71, 69, 78, 69, 83, 73, 83, 95, 77, 73, 78, 84, 69, 82, 95, 82, 79,
//           76, 69,
//         ]
//       ),
//       tx.moveCall({
//         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
//         arguments: [admin],
//       }),
//     ],
//   });

//   tx.transferObjects([admin], tx.pure.address(recipient));

//   await executeTx(tx);
// };

const builders = [
  {
    id: '0x031c59763fe0de6d64ce8bbb2864b2040618d612fcf57af5a9a6d6db133c6e8b',
    type: 'Left Pauldron',
  },
  {
    id: '0x1313b3676e3db1e9d86fa1dcf0c811a7d1b45984e49a8966373f3b438e276ca5',
    type: 'Right Arm',
  },
  {
    id: '0x23360e46ed78036d6f9649e18f98461b952857e7fbf3fde4e7c900d24a0d1f97',
    type: 'Helm',
  },
  {
    id: '0x43a676a945c6b494191173ac43eb438e0c81352ac4f7e9ac46ca40d3583f682b',
    type: 'Left Glove',
  },
  {
    id: '0x4c6d1108569bacc7b1e0737a6d3eb3e13c5b92c3f7c092cccd5614107c9e6800',
    type: 'Right Bracer',
  },
  {
    id: '0x4d5aeeb5a1e2ef50530689cd5ad56d5f2b8bf9bf2451a1bc5418687a83dc3e75',
    type: 'Upper Torso',
  },
  {
    id: '0x7cc3d052bee1a671341a34c01de1efa1d7dbaedad52af10a2af8f0686454c315',
    type: 'Chestpiece',
  },
  {
    id: '0x7f5dac6f07a7d83a8629689a5cce9162f192abccd9626ff6f26c5f08411b680b',
    type: 'Left Arm',
  },
  {
    id: '0x8b0d9a12ce2c454bb32535c0c2528a416866b39869e61d5341fef47dfe86d851',
    type: 'Belt',
  },
  {
    id: '0x8d791b95c060ad3b40a5d502d85b6f9f9fcdd3bce1dee7eb4f15ad61f9155aab',
    type: 'Shins',
  },
  {
    id: '0x8ed7af78c44e4709189c6ae41e08d770455738c8703d739b8f67bbee8d9d33fc',
    type: 'Legs',
  },
  {
    id: '0x95b37154e19e689ee6899a55743681e44d657c2588cd5b5b9edee41a463f2acd',
    type: 'Left Bracer',
  },
  {
    id: '0xac5cefcf3c12faaedd3cea11e5f6f2f4cefc9034f033274dd5743808f229a023',
    type: 'Right Pauldron',
  },
  {
    id: '0xbc88bf7ed82f5128ca7160aab272972f491f0d2ea1ea8de5ffcd4af4ffb798e5',
    type: 'Tertiary',
  },
  {
    id: '0xd4b6565566f295e5630e4dd46a53fd43c76461726a97557897597a1ef74c2afd',
    type: 'Primary',
  },
  {
    id: '0xe2332d3ed0bafd237fa0da04a7cb63f8ffa5baeccb89345c118f8e69f1b4b6cc',
    type: 'Right Glove',
  },
  {
    id: '0xf63dab0a6bda4874e70f51479619bfa554e0bb27cc6a5b1e01ed2c773413d790',
    type: 'Secondary',
  },
  {
    id: '0xf938afd33fa60c1252b226443237df06247d6e3d6fa0d321a07acd2669e5d494',
    type: 'Boots',
  },
];

// (async () => {
//   const executor = new SerialTransactionExecutor({
//     client,
//     signer: adminKeypair,
//   });

//   const promises: Promise<{
//     digest: string;
//     effects: string;
//   }>[] = [];

//   for (const builder of builders) {
//     [...Array(7).keys()].forEach(() => {
//       const tx = new Transaction();

//       [...Array(10).keys()].forEach(() => {
//         addItem(builder.id, tx);
//       });

//       promises.push(executor.executeTransaction(tx));
//     });
//   }

//   const digests = await Promise.all(promises);

//   log(digests.length);
// })();
