import * as package_1 from "../_dependencies/source/0x1/init";
import * as package_2 from "../_dependencies/source/0x2/init";
import * as package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585 from "../_dependencies/source/0xbd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585/init";
import * as package_2fe22d778d0e62a095eae09fdfa0a781bb868a82a5abb0534acde7fab6a7ebe7 from "../act/init";
import * as package_eb5dd3a26fdf5f95b63d60ccd280d40ec3ead1a3d479ede43308835a89f6e152 from "../anima-lib/init";
import * as package_bacd50dfc91cdb1b9d8ee11c84322534503a542e68f5cbede9425e369f5f31dc from "../anima/init";
import {structClassLoaderSource as structClassLoader} from "./loader";

let initialized = false; export function initLoaderIfNeeded() { if (initialized) { return }; initialized = true; package_1.registerClasses(structClassLoader);
package_2.registerClasses(structClassLoader);
package_2fe22d778d0e62a095eae09fdfa0a781bb868a82a5abb0534acde7fab6a7ebe7.registerClasses(structClassLoader);
package_bacd50dfc91cdb1b9d8ee11c84322534503a542e68f5cbede9425e369f5f31dc.registerClasses(structClassLoader);
package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585.registerClasses(structClassLoader);
package_eb5dd3a26fdf5f95b63d60ccd280d40ec3ead1a3d479ede43308835a89f6e152.registerClasses(structClassLoader);
 }
