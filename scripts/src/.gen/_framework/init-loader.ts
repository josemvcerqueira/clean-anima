import * as package_source_1 from "../_dependencies/source/0x1/init";
import * as package_source_2 from "../_dependencies/source/0x2/init";
import * as package_source_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585 from "../_dependencies/source/0xbd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585/init";
import * as package_source_e86adff06b4e996c92649331daea74ce597e26819d7c81a75a9a9a1ae9d845f7 from "../act/init";
import * as package_source_9d4fcbdcdc69cc8a07c70724cff3a8ffb454b772381689810a30cf648133a9a4 from "../anima-lib/init";
import * as package_source_8c9dfd49291e31fb48885dcd1624dd3c0e6d8399bac576859c858fb0fd264b6 from "../anima/init";
import {StructClassLoader} from "./loader";

function registerClassesSource(loader: StructClassLoader) { package_source_1.registerClasses(loader);
package_source_2.registerClasses(loader);
package_source_8c9dfd49291e31fb48885dcd1624dd3c0e6d8399bac576859c858fb0fd264b6.registerClasses(loader);
package_source_9d4fcbdcdc69cc8a07c70724cff3a8ffb454b772381689810a30cf648133a9a4.registerClasses(loader);
package_source_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585.registerClasses(loader);
package_source_e86adff06b4e996c92649331daea74ce597e26819d7c81a75a9a9a1ae9d845f7.registerClasses(loader);
 }

export function registerClasses(loader: StructClassLoader) { registerClassesSource(loader); }
