# jsTree

```js
$('#example1').jstree({
	core: {
		data: [
			{ "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
			{ "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
			{ "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
			{ "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
		]
	}
})
```

## Инстансы

**В событиях (*.on("event.jstree"), function(){…}*)**

```js
var tree = data.instance
var struct = tree.element
// дата-атрибуты структуры:
var tree_type = struct.data("tree_type")
```

## Основные методы

### refresh

Перезагрузить все узлы дерева (выполнив запрос к *core.data*)

```js
// Параметры метода
tree.refresh()
// эквивалентно:
tree.refresh(false, false)
// Первый параметр - отключить анимацию загрузки дерева
// Второй параметр - сбросить состояние (закрыть все узлы)
```

обновить данные ноды:

```js
$('#example_change_data').jstree(true).redraw_node('4') // without childrens, work!
$('#example_change_data').jstree(true).redraw_node('7', true) // with childrens, work!
```


<h3>Предок</h3>
<pre class="prettyprint lang-js eval_js">
tree = $('#example3').jstree({
	core: {
		data: [
			{ "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
			{ "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
			{ "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
			{ "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
			{ "id" : "ajson5", "parent" : "#", "text" : "Root node 3" },
			{ "id" : "ajson6", "parent" : "ajson5", "text" : "Child 1" },
		]
	},
	plugins: ["search"]
})
</pre>
<pre class="eval_js">
console.log(tree.jstree().get_parent('ajson3'))
</pre>
<pre class="eval_js">
console.log(
	tree.jstree().get_node( tree.jstree().get_parent('ajson3') )
)
</pre>
<pre class="eval_js">
console.log(
	tree.jstree().get_node( tree.jstree().get_parent('ajson3') ).text
)
</pre>

<h2>Действия</h2>
<h3>Переместить ноду</h3>
<pre class="eval_js">
$.ajax({
	type: 'POST',
	url: '/jstree/temp.json',
	data: null,
	cache: false,
	async: false,
	contentType: false,
	processData: false,
	dataType: 'json',
	beforeSend: function(jqXHR, settings){
	},
	success: function(data, textStatus, jqXHR){
		tree = $('#example_move_node').jstree({
			core: {
				data: data,
				check_callback: true
			},
			types: {
				file: {
					icon: 'jstree-file'
				}
			},
			plugins: ['search', 'types', 'dnd']
		  table: {
		    columns: [
		      {width: 200, header: "Name"},
		      {width: 150, value: "article", header: "article"}
		    ],
		    resizable: true,
		    draggable: true,
		    contextmenu: true,
		    width: 500,
		    height: 300
		  }
		})
	},
	fail: function(){
		console.log('error')
	}
})
</pre>
