import * as package_1 from "../_dependencies/source/0x1/init";
import * as package_2 from "../_dependencies/source/0x2/init";
import * as package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585 from "../_dependencies/source/0xbd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585/init";
import * as package_6a39432e88d4bceb6c8f684d990c137243ddc0679b77f92027c787bfcd981cbc from "../act/init";
import * as package_8b06bd74267785fe6a6a0d39e42b08233c999d13c34f87b08ea960afa1bce40d from "../anima-lib/init";
import * as package_30ad6c8edc1e5e21fa09fe6296c7ba3bb9d5a26028ff95b615611b1723ba86da from "../anima/init";
import {structClassLoaderSource as structClassLoader} from "./loader";

let initialized = false; export function initLoaderIfNeeded() { if (initialized) { return }; initialized = true; package_1.registerClasses(structClassLoader);
package_2.registerClasses(structClassLoader);
package_30ad6c8edc1e5e21fa09fe6296c7ba3bb9d5a26028ff95b615611b1723ba86da.registerClasses(structClassLoader);
package_6a39432e88d4bceb6c8f684d990c137243ddc0679b77f92027c787bfcd981cbc.registerClasses(structClassLoader);
package_8b06bd74267785fe6a6a0d39e42b08233c999d13c34f87b08ea960afa1bce40d.registerClasses(structClassLoader);
package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585.registerClasses(structClassLoader);
 }
