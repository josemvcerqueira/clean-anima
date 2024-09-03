import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { Ed25519Keypair } from '@mysten/sui/keypairs/ed25519';
import { Transaction } from '@mysten/sui/transactions';
import dotenv from 'dotenv';
import { AnimaSDK } from '../anima';
import { PACKAGES, SHARED_OBJECTS } from 'src/constants';

dotenv.config();

const adminKeypair = Ed25519Keypair.fromSecretKey(
    Uint8Array.from(Buffer.from(process.env.KEY!, 'base64')).slice(1)
);

const client = new SuiClient({
    url: getFullnodeUrl('testnet'),
});

(async () => {
    const sdk = new AnimaSDK();

    const tx = await sdk.unequipWeapons({
        weaponSlots: ["Tertiary"],
        avatarId: "0xae05d43f73b7c1e6087603f88869a0fa1cf80fa1bd960b35722476adc3e38658",
        sender: adminKeypair.toSuiAddress(),
    })

    const results = await client.signAndExecuteTransaction({
        transaction: tx,
        signer: adminKeypair,
        options: { showObjectChanges: true },
        requestType: 'WaitForLocalExecution',
    });
    console.log(results)
})();
