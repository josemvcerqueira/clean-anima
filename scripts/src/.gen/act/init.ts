import * as avatar from "./avatar/structs";
import * as cosmetic from "./cosmetic/structs";
import * as genesisDrop from "./genesis-drop/structs";
import * as genesisShop from "./genesis-shop/structs";
import * as profilePictures from "./profile-pictures/structs";
import * as weapon from "./weapon/structs";
import {StructClassLoader} from "../_framework/loader";

export function registerClasses(loader: StructClassLoader) { loader.register(weapon.Equip);
loader.register(weapon.WEAPON);
loader.register(weapon.Weapon);
loader.register(profilePictures.ProfilePictures);
loader.register(cosmetic.Equip);
loader.register(cosmetic.COSMETIC);
loader.register(cosmetic.Cosmetic);
loader.register(avatar.AVATAR);
loader.register(avatar.Avatar);
loader.register(avatar.AvatarSettings);
loader.register(avatar.CosmeticKey);
loader.register(avatar.WeaponKey);
loader.register(genesisShop.Item);
loader.register(genesisShop.Builder);
loader.register(genesisShop.GenesisShop);
loader.register(genesisDrop.GENESIS_DROP);
loader.register(genesisDrop.GenesisPass);
loader.register(genesisDrop.Sale);
 }
