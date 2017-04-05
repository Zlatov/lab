// function asyncEvent() {
//   var dfd = jQuery.Deferred();
 
//   // Resolve after a random interval
//   setTimeout(function() {
//     dfd.resolve( "hurray" );
//   }, Math.floor( 400 + Math.random() * 2000 ) );
 
//   // Reject after a random interval
//   setTimeout(function() {
//     dfd.reject( "sorry" );
//   }, Math.floor( 400 + Math.random() * 2000 ) );
 
//   // Show a "working..." message every half-second
//   setTimeout(function working() {
//     if ( dfd.state() === "pending" ) {
//       dfd.notify( "working... " );
//       setTimeout( working, 500 );
//     }
//   }, 1 );
 
//   // Return the Promise so caller can't change the Deferred
//   return dfd.promise();
// }
 
// Attach a done, fail, and progress handler for the asyncEvent
// $.when( asyncEvent() ).then(
//   function( status ) {
//     alert( status + ", things are going well" );
//   },
//   function( status ) {
//     alert( status + ", you fail this time" );
//   },
//   function( status ) {
//     $( "body" ).append( status );
//   }
// );



window.get_panel = (id=null) => {
  if (id!=null) {
    var panel = $('#'+ id)
  } else {
    var panel = $('#panel')
  }
  panel.state = function(state=null, mycallback=null) {
    if (state!=null) {
      var panel = $(this)
      // console.log(panel)
      if (state) {
        panel.data('state', '1')
        panel.css('opacity', '.4')
        panel.css('pointer-events', 'none')
      } else {
        panel.data('state', '0')
        panel.css('opacity', '1')
        panel.css('pointer-events', 'auto')
      }
    }
    if (mycallback!=null) {
      mycallback()
    }
    var ret = panel.data('state')
    if (ret==null) {
      return 0
    } else {
      return (ret==='1')?1:0
    }
  }
  return panel
}

window.data_show = (data,panel) => {
  data.forEach(function(item,index) {
    panel.html(JSON.stringify(item))
  })
}

// function step1() {
//   for (var i = 0; i <= 100; i++) {
//     console.log('s1', i)
//     if (i===100) {
//       $('p').css({'color':'red'})
//     }
//   }
// }
// function step2() {
//   console.log($('p').css('color'))
//   if ($('p').css('color') === 'rgb(255, 0, 0)') {
//     for (var i = 0; i <= 100; i++) {
//       console.log('s2', i)
//       if (i===100) {
//         $('p').css({'color':'green'})
//       }
//     }
//   } else {
//     console.log('no')
//   }
// }

// step1()
// step2()

panel = get_panel()

// panel.state(1, function() {
//   panel.html('asdf')
// })

// Возвращает обещание сразу, решение обещания наступает через 1000
promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    panel.state(1)
    resolve(true);
  }, 1000);
})


promise.then(resolve => { // при решениии обещания создается новое обещание
  var promise = new Promise(function(resolve) {
    // которое решается сразу
    resolve(true)
  })
  console.log(resolve)
  // а это выполняется через 10000
  setTimeout(() => {
    data_show(data,panel)
  }, 10000);
  // и возвращается сразу
  return promise
}).then(resolve => {
  console.log(resolve)
  return new Promise(function(resolve) {
    setTimeout(()=>{
      data_show(data,panel)
      resolve('2000')
    }, 2000)
  })
}).then(resolve => {
  console.log(resolve)
})

// panel.state(1)

// data_show(data,panel)

// panel.state(0)

anime = $('#anime')
anime.animate({fontSize:'5em'},2000).promise().then((somvar)=>{
  console.log(somvar)
  anime.html('1')
  somvar.animate({fontSize:'1em'},2000)
  return somvar.promise()
}).then((somee)=>{
  anime.html('2')
  somee.animate({height:'100px'},2000)
  return somee.promise()
}).then((somevar2)=>{
  anime.html('3')
  console.log(somevar2)
  anime.animate({width:'30px'},2000)
})


panel2 = get_panel('panel2')

// panel2.state(1)

setTimeout(()=>{


  new Promise(resolve1=>{
    panel2.state(1)
    resolve1()
  }).then(nahera=>{
    console.log('nahera: ', nahera)
    return new Promise(resolve2=>{
      data_show(data,panel2)
      resolve2()
    })
  }).then(nahera2=>{
    console.log('nahera2: ', nahera2)
    return new Promise(resolve3=>{
      panel2.state(0)
      resolve3('nahera?')
    })
  }).then(nahera3=>{
    console.log('nahera3: ', nahera3)
    return new Promise(resolve4=>{
      setTimeout(()=>{
        panel2.state(1)
        resolve4()
      },1000)
    })
  }).then(nahera4=>{
    return new Promise(resolve4=>{
      setTimeout(()=>{
        panel2.html('просто')
      },500)
      setTimeout(()=>{
        panel2.html('изменяем')
      },1000)
      setTimeout(()=>{
        panel2.html('HTML')
      },1500)
      setTimeout(()=>{
        resolve4()
      },2000)
    })
  }).then(nahera4=>{
    panel2.state(0)
  })


}, 2000)

/**
 * Выводы
 * 
 * ОБЕЩАНИЕ - это объект (new Promise), при создании которого (new Promise())
 * мы передаем в качестве аргумента метод (new Promise(ggg=>{})),
 * который будем называть РЕШЕНИЕм.
 * 
 * В качестве аргументов РЕШЕНИЯ передаются одна или две функции (new Promise((ooo,ttt)=>{})).
 * Внутри РЕШЕНИЯ мы должны разрешить проблему в каком состоянии мы вернем РЕШЕНИЕ,
 * обычно это состояние успешного завершения ( new Promise((ooo,ttt)=>{ooo()}) )
 * 
 * Внутри решения можно использовать как синхронные функции так и асинхронные:
 * 
 * new Promise((ooo,ttt)=>{
 *   var x = 1 + 1 // синхр
 *   someJquertObjec.css({color:"red"}) // синхр
 *   ooo()
 * })
 *
 * В случа асинхронных функций, необходимо передать им функции управления ОБЕЩАНИЕМ (resolve и reject)
 * и при получении ими результата вызвать (resolve() или reject())
 *
 * В случае "тяжелых" операций над DOM, при последовательных вызовах таких операций результат будет виден
 * по завершению всех функций, поэтому для отображения промежуточных манипуляций можно "выбить" синхронный процесс
 * в асинхронный:
 *
 * new Promise(r=>{
 *   setTimeout(()=>{
 *     oneOperation()
 *     r()
 *   },0)
 * }).then(result=>{
 *   return new Promise(r=>{
 *     setTimeout(()=>{
 *       secontOperation()
 *       r()
 *     },0)
 *   })
 * }).then(result=>{
 *   thirdOperation()
 * })
 */

