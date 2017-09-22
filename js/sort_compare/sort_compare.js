"use strict"

var a = '0,375'
var b = '1,23'
var c = '10'

var arr = ['0,41', '1,24', '1,22', '0,92', '1,23', '0,375', '1', '1,52', '0,61', '1,27']

var ab = a.localeCompare(b, 'ru', {numeric: true, sensitivity: 'base'})
var bc = b.localeCompare(c, 'ru', {numeric: true, sensitivity: 'base'})
console.log('ab: ', ab)
console.log('bc: ', bc)

var collator = new Intl.Collator('ru', {numeric: true, sensitivity: 'base'})
console.log('arr: ', arr)
arr.sort(collator.compare)
console.log('arr: ', arr)
