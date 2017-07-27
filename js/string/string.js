// Разбить в массив
var str = "How are you doing today?";
var res = str.split(" ");
console.log('res: ', res)

// Заменить
console.log( '.A.'.replace(/A/g, '!'))
// Сгенерировать regex из стринги
console.log('GODzilla'.replace( new RegExp('god', 'i'), '' ) )

console.log('substring')
console.log('\'Цвет кармана\'.substring(0,4): ', 'Цвет кармана'.substring(0,4))


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
