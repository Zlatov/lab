// Возвращает или изменяет значение свойств выбранных элементов страницы
// (разница и связь между атрибутами и свойствами). Функция имеет четыре
// варианта использования:

$().prop(propName)
// возвращает значение атрибута propName у выбранного элемента. Если выбрано несколько элементов, то значение будет взято у первого. Метод возвращает значение undefined в случае, если на первый из выбранных элементов не установлено указанное свойство или набор выбранных элементов пуст.

$().prop(propName, value)
// во всех выбранных элементах, свойство propName примет значение value.

$().prop({propName1:value1, propName2:value2, ...})
// во всех выбранных элементах изменит значения группы свойств propName1, propName2, ... сделав их равными value1, value2, ... соответственно.

$().prop(propName, function(index, value))
// свойству propName будет присвоено значение, возвращенное пользовательской
// функцией (если она ничего не вернет, то свойство просто не изменит своего
// значения). Функция вызывается отдельно, для каждого из выбранных элементов.
// При вызове ей передаются следующие параметры: index — позиция элемента в
// наборе, value — текущее значение свойства propName у элемента.


// Примеры:

// если первый input-элемент на странице не активен, вернет true. Иначе false.
$("input:first").prop("disabled")
// вернет активность всем input-элементам.
$("input").prop("disabled", false)
// сделает активным последний переключатель на странице и сделает его выбранным.
$("radio:last").prop({"disabled":false, "checked":true)