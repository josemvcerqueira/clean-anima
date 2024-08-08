// import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
// import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
// import {
//   SerialTransactionExecutor,
//   Transaction,
// } from '@mysten/sui/transactions';
// import dotenv from 'dotenv';

// import { OBJECTS, PACKAGES } from './constants';

// dotenv.config();

// const client = new SuiClient({ url: getFullnodeUrl('testnet') });

// const adminKeypair = Ed25519Keypair.fromSecretKey(
//   Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
// );

// const addItem = (builder: string, tx = new Transaction()) => {
//   let i = 0;
//   while (30 > i) {
//     tx.moveCall({
//       target: `${PACKAGES.ACT}::genesis_shop::new_item`,
//       arguments: [tx.object(OBJECTS.GENESIS_SHOP), tx.object(builder)],
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
//   const builder = tx.moveCall({
//     target: `${PACKAGES.ACT}::genesis_shop::${key}`,
//     arguments: [
//       tx.object(OBJECTS.GENESIS_SHOP),
//       tx.object(OBJECTS.ACCESS_CONTROL),
//       tx.object(OBJECTS.ADMIN),
//     ],
//   });

//   tx.moveCall({
//     target: `${PACKAGES.ACT}::genesis_shop::keep`,
//     arguments: [tx.object(builder)],
//   });

//   return tx;
// };

// (async () => {

// })();