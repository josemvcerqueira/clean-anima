import * as avatar from "./avatar/structs";
import * as cosmetic from "./cosmetic/structs";
import * as genesisDrop from "./genesis-drop/structs";
import * as genesisShop from "./genesis-shop/structs";
import * as upgrade from "./upgrade/structs";
import * as weapon from "./weapon/structs";
import {StructClassLoader} from "../_framework/loader";

export function registerClasses(loader: StructClassLoader) { loader.register(upgrade.Upgrade);
loader.register(weapon.Equip);
loader.register(weapon.WEAPON);
loader.register(weapon.Weapon);
loader.register(cosmetic.Equip);
loader.register(cosmetic.COSMETIC);
loader.register(cosmetic.Cosmetic);
loader.register(avatar.AVATAR);
loader.register(avatar.Avatar);
loader.register(avatar.AvatarRegistry);
loader.register(avatar.CosmeticKey);
loader.register(avatar.WeaponKey);
loader.register(genesisShop.Item);
loader.register(genesisShop.Builder);
loader.register(genesisShop.GenesisShop);
loader.register(genesisDrop.AvatarTicket);
loader.register(genesisDrop.GenesisPass);
loader.register(genesisDrop.Sale);
 }
