import * as package_source_1 from "../_dependencies/source/0x1/init";
import * as package_source_2 from "../_dependencies/source/0x2/init";
import * as package_source_434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879 from "../_dependencies/source/0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879/init";
import * as package_source_75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33 from "../act/init";
import * as package_source_a51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c from "../anima-lib/init";
import * as package_source_41e1771682029b727adeded87f54be24e86b96fb122290be88fd41135644fac6 from "../anima/init";
import {StructClassLoader} from "./loader";

function registerClassesSource(loader: StructClassLoader) { package_source_1.registerClasses(loader);
package_source_2.registerClasses(loader);
package_source_41e1771682029b727adeded87f54be24e86b96fb122290be88fd41135644fac6.registerClasses(loader);
package_source_434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879.registerClasses(loader);
package_source_75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33.registerClasses(loader);
package_source_a51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c.registerClasses(loader);
 }

export function registerClasses(loader: StructClassLoader) { registerClassesSource(loader); }
