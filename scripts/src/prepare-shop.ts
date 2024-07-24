import { Transaction } from '@mysten/sui/transactions';
import { client, keypair, getId } from './utils.js';
import * as shop from "./.gen/act/genesis-shop/functions.js";

(async () => {
	try {
		console.log("calling...")

		const tx = new Transaction();
		const args = {
			genesisShop: tx.object(getId("genesis_shop::GenesisShop")),
			accessControl: tx.object(getId("access_control::AccessControl")),
			admin: tx.object(getId("access_control::Admin")),
		};

		tx.moveCall({
			target: `${getId("package_id")}::genesis_shop::add_helm`,
			arguments: [
				tx.object(getId("genesis_shop::GenesisShop")),
				tx.object(getId("access_control::AccessControl")),
				tx.object(getId("access_control::Admin")),
			]
		})

		// shop.addHelm(tx, args);
		// shop.addUpperTorso(tx, args);
		// shop.addChestpiece(tx, args);
		// shop.addBoots(tx, args);
		// shop.addLeftArm(tx, args);
		// shop.addRightArm(tx, args);
		// shop.addLeftBracer(tx, args);
		// shop.addRightBracer(tx, args);
		// shop.addLeftGlove(tx, args);
		// shop.addRightGlove(tx, args);
		// shop.addLeftPauldron(tx, args);
		// shop.addRightPauldron(tx, args);
		// shop.addLegs(tx, args);
		// shop.addAccessory(tx, args);
		// shop.addShins(tx, args);
		// shop.addBoots(tx, args);
		// shop.addPrimary(tx, args);
		// shop.addSecondary(tx, args);
		// shop.addTertiary(tx, args);

		tx.setGasBudget(10000000000);

		const result = await client.signAndExecuteTransaction({
			signer: keypair,
			transaction: tx,
			options: {
				showObjectChanges: true,
				showEffects: true,
			},
			requestType: "WaitForLocalExecution"
		});

		console.log("result: ", JSON.stringify(result.objectChanges, null, 2));
		console.log("status: ", JSON.stringify(result.effects?.status, null, 2));

	} catch (e) {
		console.log(e)
	}
})()