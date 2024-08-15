// import { getFullnodeUrl, OwnedObjectRef, SuiClient } from '@mysten/sui/client';
// import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
// import {
//   SerialTransactionExecutor,
//   Transaction,
// } from '@mysten/sui/transactions';
// import dotenv from 'dotenv';
// import invariant from 'tiny-invariant';
// import util from 'util';

// import { AnimaSDK } from './anima';
// import {
//   BUILDER_FN_NAMES,
//   OWNED_OBJECTS,
//   PACKAGES,
//   SHARED_OBJECTS,
// } from './constants';

// dotenv.config();

// const client = new SuiClient({
//   url: 'https://api.shinami.com/node/v1/sui_testnet_8d0574f74958d67931463c51da36bc24',
// });

// export const log = (x: unknown) =>
//   console.log(util.inspect(x, false, null, true));

// const adminKeypair = Ed25519Keypair.fromSecretKey(
//   Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
// );

// const addItem = (builder: string, tx = new Transaction()) => {
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

// // const deployBuilder = (key: string, tx = new Transaction()) => {
// //   const builder = tx.moveCall({
// //     target: `${PACKAGES.ACT}::genesis_shop::${key}`,
// //     arguments: [
// //       tx.object(SHARED_OBJECTS.GENESIS_SHOP_MUT),
// //       tx.object(SHARED_OBJECTS.ACCESS_CONTROL),
// //       tx.object(OWNED_OBJECTS.ADMIN),
// //     ],
// //   });

// //   tx.moveCall({
// //     target: `${PACKAGES.ACT}::genesis_shop::keep`,
// //     arguments: [tx.object(builder)],
// //   });

// //   return tx;
// // };

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

// // // (async () => {
// // //   const avatar = await sdk.getAvatar(adminKeypair.toSuiAddress());
// // //   invariant(avatar);
// // //   console.log(await sdk.getAvatarItems(avatar.objectId));
// // // })();

// // const giveAllAdminRoles = async (recipient: string) => {
// //   const tx = new Transaction();

// //   const admin = tx.moveCall({
// //     target: `${PACKAGES.ANIMA_LIB}::access_control::new_admin`,
// //     arguments: [tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT)],
// //   });

// //   tx.moveCall({
// //     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
// //     arguments: [
// //       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
// //       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
// //       tx.pure.vector(
// //         'u8',
// //         [83, 85, 80, 69, 82, 95, 65, 68, 77, 73, 78, 95, 82, 79, 76, 69]
// //       ),
// //       tx.moveCall({
// //         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
// //         arguments: [admin],
// //       }),
// //     ],
// //   });

// //   tx.moveCall({
// //     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
// //     arguments: [
// //       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
// //       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
// //       tx.pure.vector(
// //         'u8',
// //         [65, 67, 67, 79, 76, 65, 68, 69, 83, 95, 82, 79, 76, 69]
// //       ),
// //       tx.moveCall({
// //         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
// //         arguments: [admin],
// //       }),
// //     ],
// //   });

// //   tx.moveCall({
// //     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
// //     arguments: [
// //       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
// //       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
// //       tx.pure.vector(
// //         'u8',
// //         [82, 69, 80, 85, 84, 65, 84, 73, 79, 78, 95, 82, 79, 76, 69]
// //       ),
// //       tx.moveCall({
// //         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
// //         arguments: [admin],
// //       }),
// //     ],
// //   });

// //   tx.moveCall({
// //     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
// //     arguments: [
// //       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
// //       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
// //       tx.pure.vector(
// //         'u8',
// //         [85, 80, 71, 82, 65, 68, 69, 83, 95, 82, 79, 76, 69]
// //       ),
// //       tx.moveCall({
// //         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
// //         arguments: [admin],
// //       }),
// //     ],
// //   });

// //   tx.moveCall({
// //     target: `${PACKAGES.ANIMA_LIB}::access_control::grant`,
// //     arguments: [
// //       tx.object(OWNED_OBJECTS.SUPER_ADMIN),
// //       tx.object(SHARED_OBJECTS.ACCESS_CONTROL_MUT),
// //       tx.pure.vector(
// //         'u8',
// //         [
// //           71, 69, 78, 69, 83, 73, 83, 95, 77, 73, 78, 84, 69, 82, 95, 82, 79,
// //           76, 69,
// //         ]
// //       ),
// //       tx.moveCall({
// //         target: `${PACKAGES.ANIMA_LIB}::access_control::addy`,
// //         arguments: [admin],
// //       }),
// //     ],
// //   });

// //   tx.transferObjects([admin], tx.pure.address(recipient));

// //   await executeTx(tx);
// // };

// (async () => {
//   const passes = await sdk.getAvatarTicket(adminKeypair.toSuiAddress());
//   invariant(passes);

//   await executeTx(
//     await sdk.mintToAvatar({ sender: adminKeypair.toSuiAddress() })
//   );
// })();
