var encode = encodeURIComponent('zenonline.ru/cgi-bin/articles/client.cgi?action=load_articleslist&amp;phil_id=1&amp;year=2011&amp;month=9')
var decode = decodeURIComponent('zenonline.ru%2Fcgi-bin%2Farticles%2Fclient.cgi%3Faction%3Dload_articleslist%26amp%3Bphil_id%3D1%26amp%3Byear%3D2011%26amp%3Bmonth%3D9')

console.log('encode: ', encode)
console.log('decode: ', decode)
