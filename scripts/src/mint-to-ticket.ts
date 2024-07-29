import { Transaction } from '@mysten/sui/transactions';
import { client, keypair, getId } from './utils.js';
import * as shop from "./.gen/act/genesis-shop/functions.js";
import * as drop from "./.gen/act/genesis-drop/functions.js";

(async () => {

    try {
        console.log("calling...")

        const tx = new Transaction();
        tx.setGasBudget(100000000);
        
        const coin = tx.splitCoins(tx.gas, [10n]);

        drop.mintToTicket(tx, {
            sale: getId("genesis_drop::Sale"),
            genesisShop: getId("genesis_shop::GenesisShop"),
            registry: getId("avatar::Registry"),
            pass: [],
            coin,
            random: "0x8",
            clock: "0x6"
        });

        const result: any = await client.signAndExecuteTransaction({
            signer: keypair,
            transaction: tx,
            options: {
                showObjectChanges: true,
                showEffects: true,
            },
            requestType: "WaitForLocalExecution"
        });

        console.log(result.objectChanges);

        let status = result.effects?.status.status;
        if (status === "success") {
            console.log("tx success");
        } else {
            console.log(result.effects?.status.error);
        }

    } catch (e) {
        console.log(e)
    }
})()