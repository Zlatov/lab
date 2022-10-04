function xhr_get(url) {
  return $.ajax({
    url: url,
    type: 'get',
    dataType: 'json',
    beforeSend: showLoadingImgFn
  })
  .always(function() {
    // remove loading image maybe
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    // handle request failures
    console.log('jqXHR.responseJSON: ', jqXHR.responseJSON)
    console.log('jqXHR.responseText: ', jqXHR.responseText)
  })
  .done(function(data, textStatus, jqXHR) {
  })
}

xhr_get('/index').done(function(data) {
  // do stuff with index data
});

xhr_get('/id').done(function(data) {
  // do stuff with id data
}).fail(function() {
  asd
});

$.ajax({
  type: "get",
  url: "https://sign-forum.ru/api/v1/api.php?action=getLastPosts",
  cache: false,
  // Передадим данные запроса в объект jqXHR для получения их в .then(…) и .fail(…)
  beforeSend: function(jqXHR) {
    jqXHR.custom_data = {id: data.id}
    return true
  },
  error: function(jqXHR, textStatus, errorThrown) {
  },
  success: function(data, textStatus, jqXHR) {
  }
})

var form = $("form")[0]
var form_data = new FormData(form)
form_data.append("array", JSON.stringify([1,2,3]))
$.ajax({
  type: "post",
  url: "ajax.php",
  data: form_data,
  custom_data: {form: form},
  // contentType: "multipart/form-data",
  contentType: false,
  processData: false,
  dataType: "json",
  cache: false,
  error: function(jqXHR, textStatus, errorThrown) {
    console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
  },
  success: function(data, textStatus, jqXHR) {
    console.log('data, textStatus, jqXHR: ', data, textStatus, jqXHR)
    console.log('this.custom_data.form: ', this.custom_data.form)
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
  contentType: "application/x-www-form-urlencoded",
  contentType: "multipart/form-data",

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

  // timeout: [Number] (10000)
  // Время ожидания ответа от сервера.
  // Задается в в миллисекундах. Если это время будет превышено, запрос будет завершен с ошибкой и произойдет событие error, которое будет иметь статус "timeout".
  timeout: 30000

  // traditional:boolean(false)
  // type:string("GET")
  // url:string(адрес текущей страницы)
  // username:string
  // xhr:function(ActiveXObject в IE, XMLHttpRequest в других браузерах)
  // xhrFields:map
})
