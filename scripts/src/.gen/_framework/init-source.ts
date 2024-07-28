import * as package_1 from "../_dependencies/source/0x1/init";
import * as package_2 from "../_dependencies/source/0x2/init";
import * as package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585 from "../_dependencies/source/0xbd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585/init";
import * as package_5054564f5e0c149a3162e2867c2a2e179e048a1e81f9937f03b77b6086816d4e from "../act/init";
import * as package_4e298d2f57a9fbaed409ca59f82983d7fdefad659212d9d5b1ae1faaca68eb76 from "../anima-lib/init";
import * as package_f833b73d652171fcffd9fc5e9099c77a39d734742c832b97d08b047cd5d1716e from "../anima/init";
import {structClassLoaderSource as structClassLoader} from "./loader";

let initialized = false; export function initLoaderIfNeeded() { if (initialized) { return }; initialized = true; package_1.registerClasses(structClassLoader);
package_2.registerClasses(structClassLoader);
package_4e298d2f57a9fbaed409ca59f82983d7fdefad659212d9d5b1ae1faaca68eb76.registerClasses(structClassLoader);
package_5054564f5e0c149a3162e2867c2a2e179e048a1e81f9937f03b77b6086816d4e.registerClasses(structClassLoader);
package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585.registerClasses(structClassLoader);
package_f833b73d652171fcffd9fc5e9099c77a39d734742c832b97d08b047cd5d1716e.registerClasses(structClassLoader);
 }
