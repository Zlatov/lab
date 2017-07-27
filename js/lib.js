Array.prototype.next = function() {
  return this[this.current++]
}
Array.prototype.prev = function() {
  return this[this.current--]
}
Array.prototype.reset = function() {
  this.current = 0
}
Array.prototype.current = 0
Array.prototype.clone = function() {
  return this.slice(0)
}
// Object.prototype.clone = function() {
//   return Object.assign({}, this)
// }
Array.prototype.spliceArray = function(i, l, a) {
  return Array.prototype.splice.apply(this, [i, l].concat(a))
}
Array.prototype.in_array = function(p_val) {
  for(var i = 0, l = this.length; i < l; i++) {
    if(this[i] == p_val) {
      return true
    }
  }
  return false
}
Array.prototype.clean = function() {
  this.splice(0, this.length)
  return this
}
Array.prototype.unique = function() {
  return this.filter((value, index, self)=>{
    return self.indexOf(value) === index
  })
}
Array.prototype.to_flat = function(change_self=true, options=null) {
  if (options==null) {
    options = {
      id: 'id',
      root_id: '#',
      childrens: 'children',
      parent: 'parent'
    }
  }
  var level = 0
  var flat = []
  var cache = []
  var parent = []
  parent[level] = options.root_id
  cache[level] = this.clone()
  cache[level].reset()
  while (level>=0) {
    var node = cache[level].next()
    if (node != null) {
      node = Object.assign({},node)
      node[options.parent] = parent[level]
      if (
        node[options.childrens]!=null &&
        Object.prototype.toString.call(node[options.childrens]) === '[object Array]' &&
        node[options.childrens].length
      ) {
        level++
        parent[level] = node[options.id]
        cache[level] = node[options.childrens].clone()
        cache[level].reset()
      }
      delete node[options.childrens]
      flat.push(node)
    } else {
      level--
    }
  }
  if (change_self) {
    this.clean()
    this.spliceArray(0, 0, flat)
    return this
  }
  return flat
}

Array.prototype.get_flat_descendants = function(parent_id, change_self=true, options=null) {
  var o = Object.assign({
    id: 'id',
    root_id: '#',
    childrens: 'children',
    parent: 'parent'
  }, options||{})
  var level = 0
  var to_flat = []
  var cache = []
  cache[level] = this.clone()
  cache[level].reset()
  while (level>=0) {
    var node = cache[level].next()
    if (node != null) {

      if (node[o.id]===parent_id) {
        to_flat = (node[o.childrens]||[]).clone()
        break
      }

      if (
        node[o.childrens]!=null &&
        Object.prototype.toString.call(node[o.childrens]) === '[object Array]' &&
        node[o.childrens].length
      ) {
        level++
        cache[level] = node[o.childrens].clone()
        cache[level].reset()
      }
    } else {
      level--
    }
  }
  var flat = to_flat.to_flat()
  if (change_self) {
    this.clean()
    this.spliceArray(0, 0, flat)
    return this
  }
  return flat
}

Array.prototype.to_nested = function(change_self=true, options=null) {
  if (!options) {
    options = {
      rt_id: '#',
      fn_id: 'id',
      fn_pid: 'parent',
      fn_child: 'children'
    }
  }
  var o = options
  var nested = []
  var cache = {}
  // Для каждого элемента
  var l = this.length
  for (var i = 0; i < l; i++) {
    // Если нет родителя элемента, и элемент не корневой,
    // тогда создаем родителя в кэш
    if (this[i][o.fn_pid]!=o.rt_id && cache[this[i][o.fn_pid]]===undefined) {
      var node = {}
      node[o.fn_id] = this[i][o.fn_pid]
      cache[node[o.fn_id]] = node
    }
    // Если элемент уже был создан, значит он был чьим-то РОДИТЕЛЕМ, тогда
    // обновим в нем информацию о его родителе и все остальное
    if (cache[this[i][o.fn_id]]!==undefined) {
      for (var fn in this[i]) {
        cache[this[i][o.fn_id]][fn] = this[i][fn]
      }
      // Если этот элемент не корневой,
      // тогда переместим его в родителя (в кэше)
      if (this[i][o.fn_pid]!=o.rt_id) {
        if (!cache[this[i][o.fn_pid]][o.fn_child] || !cache[this[i][o.fn_pid]][o.fn_child].push) {
          cache[this[i][o.fn_pid]][o.fn_child] = []
        }
        cache[this[i][o.fn_pid]][o.fn_child].push(cache[this[i][o.fn_id]])
      }
      // Если этот элемент корневой,
      // то в возврат
      if (this[i][o.fn_pid]===o.rt_id) {
        nested.push(cache[this[i][o.fn_id]])
      }
    }
    // Иначе, элемент новый, родитель уже создан, добавим в родителя
    else {
      // Создаём и в кэш
      // var node = this[i].clone()
      var node = Object.assign({}, this[i])
      cache[this[i][o.fn_id]] = node
      // Если элемент не корневой - вставляем в родителя беря его из кэш
      if (this[i][o.fn_pid]!=o.rt_id) {
        if (!cache[this[i][o.fn_pid]][o.fn_child] || !cache[this[i][o.fn_pid]][o.fn_child].push) {
          cache[this[i][o.fn_pid]][o.fn_child] = []
        }
        cache[this[i][o.fn_pid]][o.fn_child].push(cache[this[i][o.fn_id]])
      }
      // Если элемент кокренвой, вставляем в возврат
      if (this[i][o.fn_pid]===o.rt_id) {
        nested.push(cache[this[i][o.fn_id]])
      }
    }
  }
  if (change_self) {
    this.clean()
    this.spliceArray(0, 0, nested)
    return this
  }
  return nested
}
