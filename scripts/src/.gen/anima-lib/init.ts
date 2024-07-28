import * as accessControl from "./access-control/structs";
import {StructClassLoader} from "../_framework/loader";

export function registerClasses(loader: StructClassLoader) { loader.register(accessControl.AccessControl);
loader.register(accessControl.Admin);
 }
