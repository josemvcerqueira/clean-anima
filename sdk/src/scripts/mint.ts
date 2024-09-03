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
    const tx = new Transaction();
    tx.setGasBudget(1_000_000_000);
    tx.setSender(adminKeypair.toSuiAddress());
    
    // tx.moveCall({
    //     target: `${PACKAGES.ACT}::genesis_drop::airdrop_freemint`,
    //     arguments: [
    //         tx.object(SHARED_OBJECTS.ACCESS_CONTROL),
    //         tx.object("0x0773a577228fa1b821fc72be2256390a0c22b08841ad72736ab276d5d684432c"),
    //         tx.pure.address(adminKeypair.toSuiAddress()),
    //     ],
    // });

    const payment = tx.splitCoins(tx.gas, [tx.pure.u64(0)]);

    const avatar = tx.moveCall({
        target: `${PACKAGES.ACT}::genesis_drop::mint_to_avatar`,
        arguments: [
            tx.object(SHARED_OBJECTS.SALE_MUT),
            tx.object(SHARED_OBJECTS.GENESIS_SHOP_MUT),
            tx.makeMoveVec({
                elements: ["0xd536e833abcf0f42262bd6cf4c7aa0b89647f778719d3f1dd3c7cbf2bd55bd82"],
                type: `${PACKAGES.ACT}::genesis_drop::GenesisPass`,
            }),
            tx.object(SHARED_OBJECTS.PROFILE_PICTURES),
            payment,
            tx.object("0x6"),
        ],
    });

    tx.transferObjects([avatar], tx.pure.address(adminKeypair.toSuiAddress()));

    const results = await client.signAndExecuteTransaction({ 
        transaction: tx, 
        signer: adminKeypair, 
        options: { showObjectChanges: true },
        requestType: 'WaitForLocalExecution',
    });
    console.log(results)
})();
