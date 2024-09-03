import {
    SerialTransactionExecutor,
    Transaction,
} from '@mysten/sui/transactions';
import dotenv from 'dotenv';
import * as fs from 'fs';
import { promisify } from 'util';
import * as pfps from "./.gen/act/profile-pictures/functions.js";

dotenv.config();
import { fromHEX } from '@mysten/sui/utils';
import path from 'path';
import { getId, keypair, client } from './utils.js';

const read = promisify(fs.readFile);

(async () => {
    const data = await read(
        path.join(__dirname, `./data/flat-v4.json`),
        'utf-8'
    );
    const parsedData = JSON.parse(data);
    const executor = new SerialTransactionExecutor({
        client,
        signer: keypair,
    });
    const promises = [];
    while (parsedData.length > 0) {
        const chunk = parsedData.splice(0, 200);
        const tx = new Transaction();
        tx.setGasBudget(1_000_000_000);
        tx.setSender(keypair.toSuiAddress());
        chunk.forEach((x: any) => {
            console.log(x);
            const hash = pfps.cosmeticToPfpHash(
                tx,
                {
                    helm: Array.from(fromHEX(x.helm)),
                    chestpiece: Array.from(fromHEX(x.chest)),
                    upperTorso: Array.from(fromHEX(x.torso)),
                }
            );
            pfps.add(tx, {
                profilePictures: getId("profile_pictures::ProfilePictures"),
                accessControl: getId("access_control::AccessControl"),
                admin: getId("access_control::Admin"),
                hash,
                ipfsUrl: x.ipfs,
            });
        });
        promises.push(executor.executeTransaction(tx));
    }
    const digests = await Promise.all(promises);
    console.log(digests.length);
})();
