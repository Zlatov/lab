return null

// Именованный экспорт
// В этом случае имя импорта должно совпадать с именем экспорта.
export { Name1, Name2, NameN }
import { Name1, Name2, NameN } from "./path/to/module"
export { variable1 as Name1, variable2 as Name2, NameN }
import { Name1, Name2, NameN } from "module-name"
export let Name1, Name2, NameN; // или var
export let Name1 = , Name2 = , NameN; // или var, const

// Дефолтный экспорт
// Имя, которое будет дано локально переменной, не обязательно должно быть
// названо как исходный экспорт. Экспорт по умолчанию может быть только один.
export default Name1
import X from "module-name";
export default function () {} // или class
export default function name1() {} // или class
export { Name1 as default, Name2 as default }

// Проброс
export { name1, name2, nameN } from "module-name"
export { import1 as name1, import2 as name2, nameN } from "module-name";

// Модуль может содержать как именованный экспорт, так и экспорт по умолчанию, и
// они могут быть импортированы вместе с помощью
import defaultExport, { namedExport1, namedExport3, etc } from 'module';


// Импорты
import "module-name";
import defaultExport from "module-name"; 
import { export } from "module-name"; 

import * as name from "module-name"; 
import { export as alias } from "module-name"; 
import { export1, export2 } from "module-name"; 
import { export1, export2 as alias2 } from "module-name"; 
import defaultExport, { export } from "module-name"; 
import defaultExport, * as name from "module-name"; 
import("/module-name.js").then(module => {…}) // Динамический импорт
