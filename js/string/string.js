// Разбить в массив
console.log('> Разбить в массив')
var str = "How are you doing today?";
var res = str.split(" ");
console.log('res: ', res)

// Заменить
console.log('----------------------------------------')
console.log('> Заменить')
console.log( '.A.'.replace(/A/g, '!'))


// slice - возвращает новую строку извлекая часть строки.
console.log('----------------------------------------')
console.log('> slice')
var a = '0123456789'
var b = a.slice(2)
console.log('a: ', a) // 0123456789
console.log('b: ', b) // 23456789

// Сгенерировать regex из стринги
console.log('----------------------------------------')
console.log('> Сгенерировать regex из стринги')
console.log('GODzilla'.replace( new RegExp('god', 'i'), '' ) )

// Фильтр пользовательского ввода для создания регулярного выражения
console.log('----------------------------------------')
console.log('> Фильтр пользовательского ввода для создания регулярного выражения')
a = 'ds\\^f[sd'
b = a.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
console.log('a: ', a)
console.log('b: ', b)

console.log('----------------------------------------')
console.log('substring')
console.log('\'Цвет кармана\'.substring(0,4): ', 'Цвет кармана'.substring(0,4))


console.log('----------------------------------------')
console.log('> Преобразование в int')
console.log( '0', parseInt('0')          )
console.log( '+0', parseInt('+0')         )
console.log( '-0', parseInt('-0')         )
console.log( '+000', parseInt('+000')       )
console.log( '-1', parseInt('-1')         )
console.log( '00001', parseInt('00001')      )
console.log( '-00001', parseInt('-00001')     )
console.log( '+00001', parseInt('+00001')     )
console.log( '101.1', parseInt('101.1')      )
console.log( '0.1', parseInt('0.1')        )
console.log( '-0.1', parseInt('-0.1')       )
console.log( '-0000.100', parseInt('-0000.100')  )

console.log( 'Number(\'-0000.100\')', Number('-0000.100')  )
