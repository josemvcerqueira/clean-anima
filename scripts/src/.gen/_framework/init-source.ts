import * as package_1 from "../_dependencies/source/0x1/init";
import * as package_2 from "../_dependencies/source/0x2/init";
import * as package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585 from "../_dependencies/source/0xbd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585/init";
import * as package_3bd003f67108ad52e2623256c06a1254125705ae0ee15b013ef0a52304badb9e from "../act/init";
import * as package_f013fc886023ddad5f2470ed24419d81ec2497f03d5981bfdab20848ec73209c from "../anima-lib/init";
import * as package_d4899972711ec1edc08ac1c8e4955ba7f434971f516f6befe8c87837bffb42c9 from "../anima/init";
import {structClassLoaderSource as structClassLoader} from "./loader";

let initialized = false; export function initLoaderIfNeeded() { if (initialized) { return }; initialized = true; package_1.registerClasses(structClassLoader);
package_2.registerClasses(structClassLoader);
package_3bd003f67108ad52e2623256c06a1254125705ae0ee15b013ef0a52304badb9e.registerClasses(structClassLoader);
package_bd8fc1947cf119350184107a3087e2dc27efefa0dd82e25a1f699069fe81a585.registerClasses(structClassLoader);
package_d4899972711ec1edc08ac1c8e4955ba7f434971f516f6befe8c87837bffb42c9.registerClasses(structClassLoader);
package_f013fc886023ddad5f2470ed24419d81ec2497f03d5981bfdab20848ec73209c.registerClasses(structClassLoader);
 }
