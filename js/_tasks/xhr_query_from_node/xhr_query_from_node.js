// Этот скрипт выполняется нодой как `"type": "module",` (см. файл package.json).
// jQuery тут в пролёте, это не браузер.

// import jQuery from "../../../node_modules/jquery/dist/jquery.min.js"
// console.log('jQuery: ', jQuery)

import fetch from 'node-fetch';


// var response = await fetch('https://mini-light.klej.ru/api/v1/affiliates')
// var data = await response.json()
// console.log('data: ', data)
// process.exit(0)


// var response = await fetch('http://localhost:3111/json', {method: 'POST', body: 'a=1'})
// var data = await response.json()
// console.log(data)


var encoded_params = "filter%5Bnation%5D=ussr&filter%5Btype%5D=&filter%5Brole%5D=&filter%5Btier%5D=5&filter%5Blanguage%5D=ru&filter%5Bpremium%5D=0%2C1"
var decoded_params = decodeURIComponent(encoded_params)
console.log('decoded_params: ', decoded_params)
var decoded_params = "filter[nation]=ussr&filter[type]=&filter[role]=&filter[tier]=6&filter[language]=ru&filter[premium]=0,1"
var response = await fetch('https://tanki.su/wotpbe/tankopedia/api/vehicles/by_filters/', {
  "headers": {
    // "accept": "application/json, text/javascript, */*; q=0.01",
    // "accept-language": "ru,en-US;q=0.9,en;q=0.8",
    // "cache-control": "no-cache",
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    // "pragma": "no-cache"
    // "sec-ch-ua": "\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"120\", \"Google Chrome\";v=\"120\"",
    // "sec-ch-ua-mobile": "?0",
    // "sec-ch-ua-platform": "\"Linux\"",
    // "sec-fetch-dest": "empty",
    // "sec-fetch-mode": "cors",
    // "sec-fetch-site": "same-origin",
    // "x-requested-with": "XMLHttpRequest",
    // "cookie": "uvt=1; csrftoken=YV2hz94F6WhCM7SDBz4WTzWYpOE0fwSN; newbie_session=1699518073302; WGAI=\"eyJsb2dpbm5hbWUiOiAiIiwgInRpbWVzdGFtcCI6IDE2OTk1MTgwNzMsICJjbGFuX25hbWUiOiAiQ1lCRVJUQU5LIE1BTklBQ1MiLCAiaXNfc3RhZmYiOiBmYWxzZSwgImNsYW5fYmFuIjogbnVsbCwgImdhbWVfYmFuIjogbnVsbCwgImNsYW5fdGFnIjogIkNUTSIsICJjbGFuX2NvbG9yIjogIiM4NTRhNDUiLCAiaGFzX2ZyaWVuZHMiOiB0cnVlLCAic3BhX3N0YXRlIjogbnVsbCwgIm5pY2tuYW1lIjogIldPVEFLUyIsICJzcGFfaWQiOiAxMDQ4MjkxLCAiaGFzX2NsYW5tYXRlcyI6IHRydWUsICJiYXR0bGVzX2NvdW50IjogMjk0OTMsICJjbGFuX2lkIjogMTU3MjMsICJpc19wcmVtaXVtX2FjdGl2ZSI6IGZhbHNlfQ==\"; hsi=1; tmr_lvid=011fa0a86090d2c456d8f2bf84d82844; tmr_lvidTS=1699518074065; _ga=GA1.1.295700934.1699518074; _ym_uid=1699518074754539541; _ym_d=1699518074; cm.internal.bs_id=43860e3d-8cca-4099-ace8-1659fe067ccf; cm.internal.spa_id=1048291; cm.internal.realm=ru; sessionid=ek3uwuzc2phj8i1ir9rommwpz2npocmq; hlauth=1; cm.options.user_id=1048291; cm.options.user_name=WOTAKS; hllang=ru; _ym_isad=2; newbie_lifetime=1699518073302-1704640297554; authentication_confirmation_expires_at=1704557998; _ga_M4X9L4D1DD=GS1.1.1704640296.20.1.1704640299.0.0.0; _ga_8BNTLSLSSR=GS1.1.1704640296.19.1.1704640299.0.0.0; _ym_visorc=b; tmr_detect=0%7C1704640302048",
    // "Referer": "https://tanki.su/ru/tankopedia/",
    // "Referrer-Policy": "unsafe-url"
  },
  // body: encoded_params,
  body: Array.from(new URLSearchParams(decoded_params)).map(x => `${encodeURIComponent(x[0])}=${encodeURIComponent(x[1])}`).join("&"),
  method: "POST",
  credentials: "include"
})
var data = await response.json()
console.log(data)
console.log(data.data.data[0])
process.exit(0)
