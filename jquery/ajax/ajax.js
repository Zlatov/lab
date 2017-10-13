$.ajax({
  type: 'get',
  url: 'https://sign-forum.ru/api/v1/api.php?action=getLastPosts',
  cache: false,
  beforeSend: function() {
  },
  error: function(jqXHR, textStatus, errorThrown) {
  },
  success: function(data, textStatus, jqXHR) {
  }
})

var form = $('form')[0]
var form_data = new FormData(form)
form_data.append('array', JSON.stringify([1,2,3]))
$.ajax({
  type: 'post',
  url: 'ajax.php',
  data: form_data,
  data_custom: {form: form}
  // contentType: 'multipart/form-data',
  contentType: false,
  processData: false,
  dataType: 'json',
  cache: false,
  error: function(jqXHR, textStatus, errorThrown) {
    console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
  },
  success: function(data, textStatus, jqXHR) {
    console.log('data, textStatus, jqXHR: ', data, textStatus, jqXHR)
    console.log('this.data_custom.form: ', this.data_custom.form)
  }
})

// Параметры ajax
jQuery.ajax({

  // accepts:map(зависит от DataType)

  // async: [Boolean]
  async: true,
  async: false,

  // beforeSend(jqXHR, settings):function
  beforeSend: function(jqXHR, settings) {
  }

  // cache: boolean(true. Для 'script' и 'jsonp' — false)
  cache: true,
  cache: false,

  // complete(jqXHR, textStatus):function, array
  // contents:map

  // contentType: [String] ('multipart/form-data'|'application/x-www-form-urlencoded')
  // При отправлении запроса на сервер, данные передаются в формате, указанном в contentType
  contentType: 'application/x-www-form-urlencoded',
  contentType: 'multipart/form-data',

  // context:object
  // В качестве контекста можно задать DOM-элемент, который должен 
  // каким-либо образом сигнализировать о завершении запроса
  // ```
  //   success: function(data, textStatus, jqXHR) {
  //     $(this).remove()
  //   }
  // ```
  // однако тогда теряется изначальный контекст this в котором присутствуют изначальные настройки запроса, например
  // this.url, this.custom_data ...
  context: $input

  // converters:map({"* text":window.String, "text html":true, "text json":jQuery.parseJSON, "text xml":jQuery.parseXML})
  // crossDomain:boolean(false при запросах на тот же домен, true в случае запросах в чужую доменную зону)
  // data:object,string
  // dataFilter(data, type):function

  // dataType:string(определяется автоматически (xml, json, script, или html))
  // Тип данных, в котором ожидается получить ответ от сервера. Если он не задан, jQuery попытается определить его автоматически
  dataType: 'json',

  // error(jqXHR, textStatus, errorThrown):function,array
  // global:boolean(true)
  // headers:map({})
  // ifModified:boolean(false)
  // isLocal:boolean(в зависимости от текущего протокола)
  // jsonp:string,false
  // jsonpCallback:string,function
  // mimeType:string
  // password:string

  // processData:boolean(true)
  // По умолчанию, все передаваемые на сервер данные, предварительно преобразуются в строку 
  // (url-формата: fName1=value1&fName2=value2&...) соответствующую 
  // "application/x-www-form-urlencoded". Если вам необходимо отправить данные, которые нельзя 
  // подвергать подобной обработке (например документ-DOM), то следует отключить опцию processData.
  processData: true,

  // scriptCharset:string
  // statusCode:map({})
  // success(data, textStatus, jqXHR):function,array
  // timeout:integer
  // traditional:boolean(false)
  // type:string("GET")
  // url:string(адрес текущей страницы)
  // username:string
  // xhr:function(ActiveXObject в IE, XMLHttpRequest в других браузерах)
  // xhrFields:map
})
