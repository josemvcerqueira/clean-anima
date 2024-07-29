import { Transaction } from '@mysten/sui/transactions';
import { client, keypair, getId } from './utils.js';
import * as shop from "./.gen/act/genesis-shop/functions.js";
import * as drop from "./.gen/act/genesis-drop/functions.js";

(async () => {

	try {
		console.log("calling...")

		const tx = new Transaction();
		tx.setGasBudget(100000000);

		drop.setActive(tx, {
			sale: getId("genesis_drop::Sale"),
			accessControl: getId("access_control::AccessControl"),
			admin: getId("access_control::Admin"),
			active: true,
		});
		drop.setStartTimes(tx, {
			sale: getId("genesis_drop::Sale"),
			accessControl: getId("access_control::AccessControl"),
			admin: getId("access_control::Admin"),
			startTimes: [0n, 0n, 0n],
		});
		drop.setMaxMints(tx, {
			sale: getId("genesis_drop::Sale"),
			accessControl: getId("access_control::AccessControl"),
			admin: getId("access_control::Admin"),
			maxMints: [100n, 100n, 100n],
		});
		drop.setPrices(tx, {
			sale: getId("genesis_drop::Sale"),
			accessControl: getId("access_control::AccessControl"),
			admin: getId("access_control::Admin"),
			prices: [10n, 10n, 10n],
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