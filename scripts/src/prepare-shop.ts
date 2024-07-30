import { Transaction } from '@mysten/sui/transactions';
import { client, keypair, getId } from './utils.js';
import * as shop from "./.gen/act/genesis-shop/functions.js";

(async () => {
	const functions = [
		shop.addHelm,
		shop.addUpperTorso,
		shop.addChestpiece,
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
			console.log(fun.name);

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
				
				if (j == 5) {
					shop.destroyBuilder(tx, builder);
				} else {
					shop.keep(tx, builder);
				}

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
					console.log("Items created: " + (j * 500 + 500));
				} else {
					console.log(result.effects?.status.error);
				}

				if (!builderId) {
					builderId = result.objectChanges?.find((obj: any) => obj.objectType.endsWith("::Builder")).objectId;
					console.log("Builder: " + builderId);
				}

				j++;
			}
		}

	} catch (e) {
		console.log(e)
	}
})()