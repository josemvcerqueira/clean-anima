import { Transaction } from '@mysten/sui/transactions';
import { client, keypair, getId } from './utils.js';
import * as drop from "./.gen/act/genesis-drop/functions.js";

(async () => {

    try {
        console.log("calling...")

        const tx = new Transaction();
        tx.setGasBudget(100000000);

        drop.generateImageToTicket(tx, {
            ticket: "",
            imageUrl: "ipfs://bafybeictvrpb2vdek7i3gmfihnwrl4j6egoht6em36slnbghq7jqdl7ul4/415.png",
        });

        drop.mintToAvatar(tx, {
            ticket: "",
            registry: getId("avatar::Registry"),
            random: "0x8",
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