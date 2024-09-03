// import { bcs } from '@mysten/sui/bcs';
import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import {
    SerialTransactionExecutor,
    Transaction,
} from '@mysten/sui/transactions';
import dotenv from 'dotenv';
import * as fs from 'fs';
import { promisify } from 'util';

import {
    PACKAGES,
    SHARED_OBJECTS,
} from '../constants';

dotenv.config();
import { fromHEX } from '@mysten/sui/utils';
import path from 'path';

const read = promisify(fs.readFile);

const client = new SuiClient({
    url: getFullnodeUrl('testnet'),
});

const adminKeypair = Ed25519Keypair.fromSecretKey(
    Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
);
(async () => {
    const data = await read(
        path.join(__dirname, `../pfps/flat-v3.json`),
        'utf-8'
    );
    const parsedData = JSON.parse(data);
    const executor = new SerialTransactionExecutor({
        client,
        signer: adminKeypair,
    });
    const promises = [];
    while (parsedData.length > 0) {
        const chunk = parsedData.splice(0, 200);
        const tx = new Transaction();
        tx.setGasBudget(1_000_000_000);
        tx.setSender(adminKeypair.toSuiAddress());
        chunk.forEach((x: any) => {
            console.log(x);
            const hash = tx.moveCall({
                target: `${PACKAGES.ACT}::profile_pictures::cosmetic_to_pfp_hash`,
                arguments: [
                    tx.pure.vector('u8', fromHEX(x.helm)),
                    tx.pure.vector('u8', fromHEX(x.chest)),
                    tx.pure.vector('u8', fromHEX(x.torso)),
                ],
            });
            tx.moveCall({
                target: `${PACKAGES.ACT}::profile_pictures::add`,
                arguments: [
                    tx.object(SHARED_OBJECTS.PROFILE_PICTURES_MUT),
                    tx.object(SHARED_OBJECTS.ACCESS_CONTROL),
                    tx.object("0x0773a577228fa1b821fc72be2256390a0c22b08841ad72736ab276d5d684432c"),
                    hash,
                    tx.pure.string(x.ipfs),
                ],
            });
        });
        promises.push(executor.executeTransaction(tx));
    }
    const digests = await Promise.all(promises);
    console.log(digests.length);
})();
