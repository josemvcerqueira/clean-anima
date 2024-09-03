// import { bcs } from '@mysten/sui/bcs';
import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import {
    SerialTransactionExecutor,
    Transaction,
} from '@mysten/sui/transactions';
import { fetchAllDynamicFields } from '@polymedia/suitcase-core';
import dotenv from 'dotenv';
import {
    PACKAGES,
    SHARED_OBJECTS,
} from '../constants';

dotenv.config();

const client = new SuiClient({
    url: getFullnodeUrl('testnet'),
});

const adminKeypair = Ed25519Keypair.fromSecretKey(
    Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
);

(async () => {
    const tx = new Transaction();
    tx.setGasBudget(1_000_000_000);
    tx.setSender(adminKeypair.toSuiAddress());

    const executor = new SerialTransactionExecutor({
      client,
      signer: adminKeypair,
    });
    const promises = [];

    const dfs = await fetchAllDynamicFields(
      client,
      "0xf790a081f7f138acd08008b44d0ea30f6e44f0a44a80732a7ee69baab277c0d1"
    );

    while (dfs.length > 0) {
      const chunk = dfs.splice(0, 500);
      const tx = new Transaction();
      tx.setGasBudget(1_000_000_000);
      tx.setSender(adminKeypair.toSuiAddress());
      chunk.forEach((df: any) => {
        console.log(df);
        tx.moveCall({
          target: `${PACKAGES.ACT}::profile_pictures::remove`,
          arguments: [
            tx.object(SHARED_OBJECTS.PROFILE_PICTURES_MUT),
            tx.object(SHARED_OBJECTS.ACCESS_CONTROL),
            tx.object("0x0773a577228fa1b821fc72be2256390a0c22b08841ad72736ab276d5d684432c"),
            tx.pure.vector('u8', df.name.value),
          ],
        });
      });
      promises.push(executor.executeTransaction(tx));
    }

    const digests = await Promise.all(promises);
    console.log(digests.length);
})();
