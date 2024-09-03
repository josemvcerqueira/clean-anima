import * as floorPriceRule from "./floor-price-rule/structs";
import * as kioskLockRule from "./kiosk-lock-rule/structs";
import * as personalKioskRule from "./personal-kiosk-rule/structs";
import * as personalKiosk from "./personal-kiosk/structs";
import * as royaltyRule from "./royalty-rule/structs";
import * as witnessRule from "./witness-rule/structs";
import {StructClassLoader} from "../../../_framework/loader";

export function registerClasses(loader: StructClassLoader) { loader.register(floorPriceRule.Config);
loader.register(floorPriceRule.Rule);
loader.register(kioskLockRule.Config);
loader.register(kioskLockRule.Rule);
loader.register(personalKiosk.Borrow);
loader.register(personalKiosk.NewPersonalKiosk);
loader.register(personalKiosk.OwnerMarker);
loader.register(personalKiosk.PersonalKioskCap);
loader.register(personalKioskRule.Rule);
loader.register(royaltyRule.Config);
loader.register(royaltyRule.Rule);
loader.register(witnessRule.Rule);
 }
