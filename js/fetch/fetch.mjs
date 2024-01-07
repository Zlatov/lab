import fetch from 'node-fetch'

console.log('> XHR запрос')
var response = await fetch('http://lab.local/js/fetch/json.json')
var data = await response.json()
console.log('data: ', data)
// process.exit(0)
