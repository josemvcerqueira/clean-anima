import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import dotenv from "dotenv";
import * as fs from "fs";

export interface IObjectInfo {
    type: string | undefined
	id: string | undefined
}

dotenv.config();

export const keypair = Ed25519Keypair.fromSecretKey(Uint8Array.from(Buffer.from(process.env.ANIMA_KEY!, "base64")).slice(1));

export const client = new SuiClient({ url: getFullnodeUrl("testnet") });

export const getId = (type: string): string => {
    const libData = fs.readFileSync('./src/data/lib-created.json', 'utf8');
    const libParsed: IObjectInfo[] = JSON.parse(libData);
    const actData = fs.readFileSync('./src/data/act-created.json', 'utf8');
    const actParsed: IObjectInfo[] = JSON.parse(actData);
    const animaData = fs.readFileSync('./src/data/anima-created.json', 'utf8');
    const animaParsed: IObjectInfo[] = JSON.parse(animaData);

    const parsed = [...libParsed, ...actParsed, ...animaParsed];
    const typeToId = new Map(parsed.map(item => [item.type, item.id]));
    // Find the first key that starts with the type
    for (let [key, value] of typeToId) {
        if (key?.startsWith(type)) {
            if (value === undefined) {
                throw new Error(`Value for ${type} is undefined`);
            }
            return value;
        }
    }
    throw new Error(`Type ${type} not found in created.json`);
}