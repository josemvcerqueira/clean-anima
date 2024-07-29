import { Transaction } from '@mysten/sui/transactions';
import { client, keypair, getId } from './utils.js';
import * as shop from "./.gen/act/genesis-shop/functions.js";

(async () => {
	const functions = [
		shop.addHelm,
		shop.addUpperTorso,
		shop.addChestpiece,
		shop.addBoots,
		shop.addLeftArm,
		shop.addRightArm,
		shop.addLeftBracer,
		shop.addRightBracer,
		shop.addLeftGlove,
		shop.addRightGlove,
		shop.addLeftPauldron,
		shop.addRightPauldron,
		shop.addLegs,
		shop.addShins,
		shop.addBoots,
		shop.addPrimary,
		shop.addSecondary,
		shop.addTertiary,
	];

	const args = {
		genesisShop: getId("genesis_shop::GenesisShop"),
		accessControl: getId("access_control::AccessControl"),
		admin: getId("access_control::Admin"),
	};

	try {
		console.log("calling...")

		for (let fun of functions) {
			let builderId = "";
			let j = 0;
			while (j < 6) {
				const tx = new Transaction();
				tx.setGasBudget(10000000000);
				
				let builder;
				if (!builderId) { 
					builder = fun(tx, args) 
				} else {
					builder = tx.object(builderId);
				}

				let i = 0;
				while (i < 500) {
					shop.newItem(tx, {
						genesisShop: getId("genesis_shop::GenesisShop"),
						builder: builder,
					});
					i++;
				}
				shop.keep(tx, builder);

				const result: any = await client.signAndExecuteTransaction({
					signer: keypair,
					transaction: tx,
					options: {
						showObjectChanges: true,
						showEffects: true,
					},
					requestType: "WaitForLocalExecution"
				});

				if (!builderId) {
					builderId = result.objectChanges?.find((obj: any) => obj.objectType.endsWith("::Builder")).objectId;
					console.log("Builder: " + builderId);
				}

				let status = result.effects?.status.status;
				if (status === "success") {
					console.log("tx success");
				} else {
					console.log(result.effects?.status.error);
				}
			}
		}

	} catch (e) {
		console.log(e)
	}
})()