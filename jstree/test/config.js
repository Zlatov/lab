window.config = {}
window.config.tree = {
  node_types: {
    default: {
      icon: 'yellow folder icon', // icon: 'jstree-file'
      name: 'папка'
    },
    file: {
      icon: 'file outline icon' // icon: 'jstree-file'
    },
    filter: {
      icon: 'filter icon'
    },
    group: {
      icon: 'copy icon',
      name: 'группа товаров'
    },
    other: {
      icon: 'file icon'
    },
    pantone: {
      icon: 'black folder icon'
    },
    ral: {
      icon: 'orange folder icon'
    },
    zcolor: {
      icon: 'circle thin icon',
      name: 'цвет фильтров'
    },
    some_with_url: {
      icon: 'folder icon',
      name: 'что-то со ссылкой'
    },
    property: {
      icon: 'tag icon',
      name: 'свойство'
    },
    brand: {
      icon: 'copyright icon',
      name: 'брэнд'
    },
    value: {
      icon: 'hashtag icon',
      name: 'значение'
    }
  },
  contextmenu_options: {
    Create: true,
    DeleteDuplicates: true,
    Rename: true,
    Copy: true,
    Paste: true,
    Cut: true,
    Remove: true,
    SetNodeType: true,
    Edit: true,
    HighlightInSibling: true,
    UnHighlight: true,
    Reveal: true,
    Download: true,
    Download_flat: true
  },
  contextmenu_items: {
    Create: function(node_data, tree) {
      return {
        label: "Создать папку",
        icon: 'green folder icon',
        action: function (obj) {
          node_data = tree.create_node(node_data);
          tree.edit(node_data);
        }
      }
    },
    DeleteDuplicates: function(node_data, tree) {
      return {
        label: "Удалить дубликаты",
        // icon: 'green folder icon',
        action: function (obj) {
          var flat = tree
            .get_selected() // массив id выделенных нод
            .map(function(node_id){ // получаем json каждой выделенной ноды, вместо id
              var nodes = tree.get_json(node_id, {
                no_state:true,
                no_id:false,
                no_children:false,
                no_data:false,
                no_li_attr:true,
                no_a_attr:true,
                flat:false
              })
              return nodes
            })
            .to_flat(false) // вложенную структуру преобразуем в список
          console.log('flat: ', flat)
          var cache = {}
          for(var i=0, l=flat.length; i<l; i++) {
            if (cache[flat[i]['text']]!=null) {
              tree.delete_node(flat[i]['id'])
            } else {
              cache[flat[i]['text']] = flat[i]['id']
            }
          }
        }
      }
    }
    // SetNodeType: (full_node_data, struct_id, tree) => {
    //   var tree_type = window.config.tree.get_type(struct_id)
    //   var object_of_submenu = {}
    //   object_of_submenu.default = {
    //     label: "папка",
    //     icon: 'yellow folder icon',
    //     action: function (obj) {
    //       var array_nodes_id = tree.get_selected()
    //       var l = array_nodes_id.length
    //       for(var i=0; i<l; i++){
    //         tree.set_type(array_nodes_id[i], 'default')
    //       }
    //     }
    //   }
    //   var items_types = window.config.tree.items_types[tree_type]
    //   var node_types = window.config.tree.node_types
    //   var items_names = window.config.tree.items_names
    //   for (var node_type in items_types) {
    //     if (node_type==='default') {
    //       continue
    //     }
    //     var submenu_label = window.config.functions.get_item_name(tree_type, node_type)
    //     object_of_submenu[node_type] = {
    //       node_type: node_type,
    //       label: submenu_label,
    //       icon: (node_types[node_type].icon || ''),
    //       action: function(obj) {
    //         var array_nodes_id = tree.get_selected()
    //         var l = array_nodes_id.length
    //         for(var i=0; i<l; i++){
    //           tree.set_type(array_nodes_id[i], obj.item.node_type)
    //         }
    //       }
    //     }
    //   }
    //   return {
    //     label: "Установить тип",
    //     icon: 'black folder outline icon',
    //     submenu: object_of_submenu
    //   }
    // },
    // SetHex: (full_node_data, struct_id, tree) => {
    //   if (full_node_data.type!='zcolor') {
    //     return null
    //   }
    //   return {
    //     label: "Установить HEX",
    //     icon: 'black circle thin icon',
    //     action: function(obj) {
    //       Modal.get_instance('set_hex').modal({
    //         onApprove: function(q) {
    //           var form_data = Modal.get_instance('set_hex').get_form_data()
    //           if (form_data.hex==null||form_data.hex=='') {
    //             return null
    //           }
    //           if (form_data.hex.substring(0,1)!=='#') {
    //             form_data.hex = '#' + form_data.hex
    //           }
    //           var node_data = full_node_data.data || {}
    //           node_data.hex = form_data.hex
    //           full_node_data.data = node_data
    //           // tree.refresh_node(full_node_data.id)
    //         }
    //       }).set_header('Назначение HEX цвету „' + full_node_data.text + '“')

    //       if (full_node_data.data&&full_node_data.data.hex) {
    //         Modal.get_instance('set_hex').set_content({
    //           hex: full_node_data.data.hex.substring(1)
    //         })
    //       }

    //       Modal.get_instance('set_hex').render()
    //     }
    //   }
    // },
    // CreateArticle: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Создать статью",
    //     icon: 'green file text icon',
    //     action: function (obj) {
    //       var new_node_parent_id = null
    //       if (full_node_data.type==='default') {
    //         new_node_parent_id = full_node_data.id
    //       }
    //       if (full_node_data.type==='file') {
    //         new_node_parent_id = full_node_data.parent
    //       }
    //       if (new_node_parent_id) {
    //         var new_node_id = tree.create_node(new_node_parent_id, {
    //           text: 'Новая статья',
    //           type: 'file'
    //         })
    //         save_panel(window.config.panel.get_position_struct(struct_id))
    //         tree.edit(new_node_id)
    //       }
    //     }
    //   }
    // },
    // CreateZcolor: (full_node_data, struct_id, tree) => {
    //   if (
    //     ( full_node_data.type !== 'default' || full_node_data.text !== 'Цвета' ) &&
    //     full_node_data.type !== 'zcolor'
    //   ) {
    //     return null
    //   }
    //   return {
    //     label: "Создать цвет фильтра",
    //     icon: 'circle thin icon',
    //     action: function (obj) {
    //       var parent_id = null
    //       if (full_node_data.type==='default') {
    //         parent_id = full_node_data.id
    //       }
    //       if (full_node_data.type==='zcolor') {
    //         parent_id = full_node_data.parent
    //       }
    //       if (parent_id) {
    //         var node = tree.create_node(parent_id, {
    //           text: 'Цвет',
    //           type: 'zcolor'
    //         })
    //         // save_panel(window.config.panel.get_position_struct(struct_id))
    //         tree.edit(node)
    //       }
    //     }
    //   }
    // },
    // Rename: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Переименовать",
    //     icon: 'blue text cursor icon',
    //     action: function (obj) {
    //       if(full_node_data.type == 'file') return;
    //       tree.edit(full_node_data);
    //     }
    //   }
    // },
    // Copy: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Копировать",
    //     icon: 'copy icon',
    //     separator_before: true,
    //     action: function (obj) {
    //       $(full_node_data).addClass("copy");
    //       nodes = $('#' + struct_id).jstree('get_selected')
    //       window['last_cp_nodes'] = nodes
    //       tree.copy(nodes)
    //       //tree.copy(full_node_data);
    //     }
    //   }
    // },
    // Paste: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Вставить",
    //     icon: 'paste icon',
    //     action: function (node) {
    //       $(full_node_data).addClass("paste");
    //       tree.paste(full_node_data)
    //       tree.copy(window['last_cp_nodes'])
    //     }
    //   }
    // },
    // Cut: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Вырезать",
    //     icon: 'cut icon',
    //     action: function (node) {
    //       $(full_node_data).addClass("cut")
    //       tree.cut(full_node_data)
    //     }
    //   }
    // },
    // Remove: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Удалить",
    //     icon: 'remove icon',
    //     separator_before: true,
    //     action: function (obj) {
    //       window.delete_from_self = true
    //       tree.delete_node(tree.get_selected())
    //       // tree.delete_node(full_node_data)
    //       window.delete_from_self = false
    //     }
    //   }
    // },
    // Edit: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Редактировать",
    //     separator_before: true,
    //     // icon  : 'circular inverted blue write icon',
    //     icon  : 'blue edit icon',
    //     action: function (obj) {
    //       var nodes = $('#' + struct_id).jstree('get_selected')
    //       var node = nodes[0]
    //       var node_data = null
    //       node_data = tree.get_json(node, {
    //         no_state:true,
    //         no_id:false,
    //         no_children:false,
    //         no_data:false,
    //         no_li_attr:true,
    //         no_a_attr:true,
    //         flat:false
    //       })
    //       window.item(node_data,struct_id)
    //     }
    //   }
    // },
    // EditById: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Редактировать по id",
    //     separator_before: false,
    //     // icon  : 'circular inverted blue write icon',
    //     icon  : 'blue edit icon',
    //     action: function (obj) {
    //       var id = prompt('Введите артикул:', 0)
    //       if (id) {
    //         new Promise(function(resolver) {
    //           srabotay_kogda_zevershtsya_poisk_kak_event_data = resolver
    //           $('#' + struct_id).on('search.jstree', srabotay_kogda_zevershtsya_poisk_kak_event_data, (event, data) => {
    //             //console.log(data.nodes)
    //             //console.log(data.str)
    //             //console.log(data.res)
    //             event.data(data.res)
    //           })
    //           tree.search(id, false, false)
    //         }).then(function(massiv_id_naydenih_nod) {
    //           if (massiv_id_naydenih_nod[0]!=null) {
    //             node_data = tree.get_json(massiv_id_naydenih_nod[0], {
    //               no_state:true,
    //               no_id:false,
    //               no_children:false,
    //               no_data:false,
    //               no_li_attr:true,
    //               no_a_attr:true,
    //               flat:false
    //             })
    //             window.item(node_data,struct_id)
    //           } else {
    //             console.log('Нет таких!')
    //           }
    //         })
    //       }
    //     }
    //   }
    // },
    // HighlightInSibling: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Подсветить совпадения",
    //     separator_before: true,
    //     icon  : 'olive bookmark icon',
    //     action: function (obj) {
    //       // full_node_data не подходит, так как содержит всегда только один элемент
    //       var nodes = $('#' + struct_id).jstree('get_selected')
    //       var intersection_by = (window.config.controller.id==='tree')?'article':'text'
    //       var sibling_id = (struct_id===window.config.panel.structs_id[1])?window.config.panel.structs_id[0]:window.config.panel.structs_id[1]
    //       var current = $('#'+struct_id)
    //       var sibling = $('#'+sibling_id)
    //       var current_data = []
    //       nodes.forEach(function(e,i,a){
    //         current_data.push(current.jstree().get_json(
    //           e,
    //           {
    //             no_state:true,
    //             no_id:false,
    //             no_children:false,
    //             no_data: false,
    //             no_li_attr:true,
    //             no_a_attr:true,
    //             flat: false
    //           }
    //         ))
    //       })
    //       var sibling_data = sibling.jstree().get_json(
    //         '#',
    //         {
    //           no_state:true,
    //           no_id:false,
    //           no_children:false,
    //           no_data: false,
    //           no_li_attr:true,
    //           no_a_attr:true,
    //           flat: false
    //         }
    //       )
    //       current_data.to_flat()
    //       sibling_data.to_flat()
    //       intersection_data(current_data, sibling_data, intersection_by)
    //       highlight(sibling, 'olive', intersection_by)
    //     }
    //   }
    // },
    // UnHighlight: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Убрать подсветку",
    //     icon: 'olive remove bookmark icon',
    //     action: function (obj) {
    //       unhighlight();
    //     }
    //   }
    // },
    // Reveal: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Раскрыть папку",
    //     icon: 'folder open icon',
    //     separator_before: true,
    //     action: function (obj) {
    //       var nodes = tree.get_selected()
    //       var l = nodes.length
    //       if (l === 1) {
    //         tree.open_all(nodes[0])
    //         return
    //       }
    //       var count = 0
    //       for (var i = 0; i < l; i++) {
    //         var json_multi = tree.get_json('#'+nodes[i], {
    //           no_state: true,
    //           no_data: true,
    //           no_li_attr: true,
    //           no_a_attr: true
    //         })
    //         count = count + ([json_multi].to_flat(false).length - 1)
    //         if (count>2000) {
    //           var position = window.config.panel.get_position_struct(struct_id)
    //           Informer.get_instance(position+'_info').print('В папках ' + count + ' элементов, раскройте по очереди.', 'warning')
    //           return
    //         }
    //       }
    //       for (var i in nodes) {
    //         if (typeof nodes[i] === 'string') {
    //           var node_id = '#' + nodes[i];
    //           tree.open_all(node_id);
    //         }
    //       }
    //     }
    //   }
    // },
    // Download: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Скачать структуру",
    //     icon: 'angle double down icon',
    //     separator_before: true,
    //     action: function (obj) {
    //       var data = []
    //       var nodes = $('#' + struct_id).jstree('get_selected')
    //       nodes.forEach((item) => {
    //         data.push( tree.get_json(item, {
    //           no_state:true,
    //           no_id:false,
    //           no_children:false,
    //           no_data:false,
    //           no_li_attr:true,
    //           no_a_attr:true,
    //           flat:false
    //         }) )

    //       })
    //       download(JSON.stringify(data))
    //     }
    //   }
    // },
    // Download_flat: (full_node_data, struct_id, tree) => {
    //   return {
    //     label: "Скачать flat структуру",
    //     icon: 'angle down icon',
    //     action: function (obj) {
    //       var data = []
    //       var nodes = $('#' + struct_id).jstree('get_selected')
    //       nodes.forEach((item) => {
    //         var selected_item_data = tree.get_json(item, {
    //           no_state:true,
    //           no_id:false,
    //           no_children:false,
    //           no_data:false,
    //           no_li_attr:true,
    //           no_a_attr:true,
    //           flat:false
    //         })
    //         var selected_item_data_array = [selected_item_data]
    //         selected_item_data_flat = selected_item_data_array.to_flat(false)
    //         data = data.concat(selected_item_data_flat)
    //       })
    //       download(JSON.stringify(data))
    //     }
    //   }
    // }
  }
}
