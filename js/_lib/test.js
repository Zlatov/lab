function test_split_with_line_breaks() {
  var a = '                1 22 333 4444 55555 666666 7777777 88888888                '
  var b = a.trim().split_with_line_breaks(8)
  console.log('a: ', a)
  console.log('b: ', b)
}

test_split_with_line_breaks()
