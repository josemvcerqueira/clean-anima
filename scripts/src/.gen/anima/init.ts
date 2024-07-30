import * as account from "./account/structs";
import {StructClassLoader} from "../_framework/loader";

export function registerClasses(loader: StructClassLoader) { loader.register(account.Accolade);
loader.register(account.Account);
loader.register(account.Registry);
loader.register(account.Reputation);
 }
