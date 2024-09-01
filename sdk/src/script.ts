// import { bcs } from '@mysten/sui/bcs';
// import { getFullnodeUrl, OwnedObjectRef, SuiClient } from '@mysten/sui/client';
// import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
// import {
//   GasData,
//   SerialTransactionExecutor,
//   Transaction,
// } from '@mysten/sui/transactions';
// import { chunkArray, fetchAllDynamicFields } from '@polymedia/suitcase-core';
// import dotenv from 'dotenv';
// import * as fs from 'fs';
// import invariant from 'tiny-invariant';
// import util from 'util';
// import { promisify } from 'util';

// import { AnimaSDK } from './anima';
// import {
//   BUILDER_FN_NAMES,
//   OWNED_OBJECTS,
//   PACKAGES,
//   SHARED_OBJECTS,
// } from './constants';

// dotenv.config();
// import { fromHEX, toHEX } from '@mysten/sui/utils';
// import path from 'path';
// import { slice } from 'ramda';

// const read = promisify(fs.readFile);
// const write = promisify(fs.writeFile);

// const client = new SuiClient({
//   url: getFullnodeUrl('testnet'),
// });

// export const log = (x: unknown) =>
//   console.log(util.inspect(x, false, null, true));

// const adminKeypair = Ed25519Keypair.fromSecretKey(
//   Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
// );

// export const executeTx = async (tx: Transaction) => {
//   const result = await client.signAndExecuteTransaction({
//     signer: adminKeypair,
//     transaction: tx,
//     options: {
//       showEffects: true,
//     },
//     requestType: 'WaitForLocalExecution',
//   });

//   // return if the tx hasn't succeed
//   if (result.effects?.status?.status !== 'success') {
//     console.log('\n\nCreating a new stable pool failed');
//     return;
//   }

//   console.log('SUCCESS!');

//   // get all created objects IDs
//   const createdObjectIds = result.effects.created?.map(
//     (item: OwnedObjectRef) => item.reference.objectId
//   );

//   if (createdObjectIds)
//     // fetch objects data
//     return client.multiGetObjects({
//       ids: createdObjectIds,
//       options: { showContent: true, showType: true, showOwner: true },
//     });
// };

// const sdk = new AnimaSDK();
// const DAY = 86400000;

// const addItem = (builder: string, tx = new Transaction()) => {
//   tx.setGasBudget(5_000_000_000);
//   let i = 0;
//   while (60 > i) {
//     tx.moveCall({
//       target: `${PACKAGES.ACT}::genesis_shop::new_item`,
//       arguments: [
//         tx.object(SHARED_OBJECTS.GENESIS_SHOP_MUT),
//         tx.object(builder),
//       ],
//     });
//     i++;
//   }

//   return tx;
// };

// const destroy = (builder: string, tx = new Transaction()) => {
//   tx.moveCall({
//     target: `${PACKAGES.ACT}::genesis_shop::destroy_builder`,
//     arguments: [tx.object(builder)],
//   });

//   return tx;
// };

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

//   tx.moveCall({
//     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
//     arguments: [
//       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
//       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
//       tx.pure.vector(
//         'u8',
//         [
//           80, 82, 79, 70, 73, 76, 69, 95, 80, 73, 67, 84, 85, 82, 69, 83, 95,
//           82, 79, 76, 69,
//         ]
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
//           65, 86, 65, 84, 65, 82, 95, 83, 69, 84, 84, 73, 78, 71, 83, 95, 82,
//           79, 76, 69,
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
//         addItem(builder, tx);
//       });

//       promises.push(executor.executeTransaction(tx));
//     });
//   }

//   const digests = await Promise.all(promises);

//   log(digests.length);
// })();

(async () => {
  // const avatar = await sdk.getAvatars(
  //   '0x3cf8b73df4aa8c60f89108f9d7ab32222c15b53eac02bc58fad179d59d503d12'
  // );
  // log(avatar);
  // const tx = new Transaction();
  // tx.moveCall({
  //   target: `${PACKAGES.ACT}::profile_pictures::get`,
  //   arguments: [
  //     tx.object(SHARED_OBJECTS.PROFILE_PICTURES),
  //     tx.pure.vector('u8', []),
  //     tx.pure.vector(
  //       'u8',
  //       [
  //         50, 151, 55, 124, 15, 255, 204, 222, 229, 39, 90, 166, 235, 243, 188,
  //         149, 126, 223, 179, 165, 103, 38, 118, 235, 220, 120, 161, 60, 32, 32,
  //         34, 41,
  //       ]
  //     ),
  //     tx.pure.vector(
  //       'u8',
  //       [
  //         62, 225, 28, 94, 36, 73, 169, 176, 119, 139, 205, 55, 172, 33, 33, 14,
  //         60, 131, 210, 86, 157, 98, 196, 75, 94, 143, 134, 223, 153, 45, 3, 84,
  //       ]
  //     ),
  //   ],
  // });
  // const result = await client.devInspectTransactionBlock({
  //   transactionBlock: tx,
  //   sender: adminKeypair.toSuiAddress(),
  // });
  // log(result);
  // console.log(
  //   toHEX(
  //     Uint8Array.from([
  //       50, 151, 55, 124, 15, 255, 204, 222, 229, 39, 90, 166, 235, 243, 188,
  //       149, 126, 223, 179, 165, 103, 38, 118, 235, 220, 120, 161, 60, 32, 32,
  //       34, 41,
  //     ])
  //   )
  // );
  // console.log(
  //   toHEX(
  //     Uint8Array.from([
  //       62, 225, 28, 94, 36, 73, 169, 176, 119, 139, 205, 55, 172, 33, 33, 14,
  //       60, 131, 210, 86, 157, 98, 196, 75, 94, 143, 134, 223, 153, 45, 3, 84,
  //     ])
  //   )
  // );
  // const data = await read(
  //   path.join(__dirname, `../pfps/flat-v3.json`),
  //   'utf-8'
  // );
  // const parsedData = JSON.parse(data);
  // const x = parsedData.find(
  //   (elem: any) =>
  //     elem.chest ===
  //       '3297377c0fffccdee5275aa6ebf3bc957edfb3a5672676ebdc78a13c20202229' &&
  //     !elem.helm &&
  //     elem.torso ===
  //       '3ee11c5e2449a9b0778bcd37ac21210e3c83d2569d62c44b5e8f86df992d0354'
  // );
  // log(x);
  // const tx = sdk.addProfilePicture({
  //   adminCap: OWNED_OBJECTS.ADMIN,
  //   ipfsUrl: 'bafybeifupy7fr7vmeu7wkbb57uzgyl64jru2vee3sunp34moo4dvp2naui',
  //   chestpiece:
  //     '3297377c0fffccdee5275aa6ebf3bc957edfb3a5672676ebdc78a13c20202229',
  //   helm: '',
  //   upperTorso:
  //     '3ee11c5e2449a9b0778bcd37ac21210e3c83d2569d62c44b5e8f86df992d0354',
  // });
  // await executeTx(tx);
  // const executor = new SerialTransactionExecutor({
  //   client,
  //   signer: adminKeypair,
  // });
  // const promises = [];
  // const chunks = chunkArray(parsedData.slice(373), 50);
  // for (const arr of chunks) {
  //   const tx = new Transaction();
  //   tx.setGasBudget(1_000_000_000);
  //   tx.setSender(adminKeypair.toSuiAddress());
  //   arr.forEach((x: any) => {
  //     console.log(x);
  //     const hash = tx.moveCall({
  //       target: `${PACKAGES.ACT}::profile_pictures::cosmetic_to_pfp_hash`,
  //       arguments: [
  //         tx.pure.vector('u8', fromHEX(x.helm)),
  //         tx.pure.vector('u8', fromHEX(x.chest)),
  //         tx.pure.vector('u8', fromHEX(x.torso)),
  //       ],
  //     });
  //     tx.moveCall({
  //       target: `${PACKAGES.ACT}::profile_pictures::add`,
  //       arguments: [
  //         tx.object(SHARED_OBJECTS.PROFILE_PICTURES_MUT),
  //         tx.object(SHARED_OBJECTS.ACCESS_CONTROL),
  //         tx.object(OWNED_OBJECTS.ADMIN),
  //         hash,
  //         tx.pure.string(x.ipfs),
  //       ],
  //     });
  //   });
  //   promises.push(executor.executeTransaction(tx));
  // }
  // const digests = await Promise.all(promises);
  // console.log(digests.length);
})();
