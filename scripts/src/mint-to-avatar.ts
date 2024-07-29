import { Transaction } from '@mysten/sui/transactions';
import { client, keypair, getId } from './utils.js';
import * as drop from "./.gen/act/genesis-drop/functions.js";

(async () => {

    try {
        console.log("calling...")

        const tx = new Transaction();
        tx.setGasBudget(100000000);

        drop.generateImageToTicket(tx, {
            ticket: "0xdf3149addcf98b2dcea4e59fd9c92da9ee453e952fe37c8b7dcb99a341d992cb",
            imageUrl: "ipfs://bafybeictvrpb2vdek7i3gmfihnwrl4j6egoht6em36slnbghq7jqdl7ul4/414.png",
        });

        drop.mintToAvatar(tx, {
            ticket: "0xdf3149addcf98b2dcea4e59fd9c92da9ee453e952fe37c8b7dcb99a341d992cb",
            registry: getId("avatar::AvatarRegistry"),
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