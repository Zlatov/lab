import $ from "jquery"
global.$ = $
global.jQuery = $

import "bootstrap"

import "ilorem"

import "holderjs"

import "typeahead.js"

import Users from "./js/modules/users/users.js"
window.Users = Users

import "./sass.scss"

// Импорт изображений
import "./images/logo.svg"
import "./images/favicon.svg"

// Импорт json фалов данных в паблик
import "./json/users.json"
import "./json/labeled_users.json"

$(document).ready(function() {

  $('.custom.typeahead').typeahead({
    minLength: 1,
    hint: true,
    highlight: true
  },
  {
    name: 'my-dataset',
    limit: 10,
    source: window.Users.get_list
  }).on('typeahead:selected', function(event, selection) {
    console.log('event: ', event)
    console.log('selection: ', selection)
    console.log('this: ', this)
    // Очищаем после действий с выбранным значением
    $(this).typeahead('val', '')
  })

  $('.labeled.typeahead').typeahead({
    minLength: 1,
    hint: true,
    highlight: true
  },
  {
    name: 'my-dataset',
    limit: 10,
    display: 'label',
    source: window.Users.get_labaled_list,
    // updater: function(item) {
    //   $('hiddenInputElement').val(map[item].option);
    //   return item
    // }
  }).on('typeahead:selected', function(event, selection) {
    console.log('event: ', event)
    console.log('selection: ', selection)
    console.log('this: ', this)
    // Очищаем после действий с выбранным значением
    $(this).typeahead('val', '')
  })

  // Ниже пример из интернета с локальными данными
  var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
      var matches, substringRegex, substrRegex
      // an array that will be populated with substring matches
      matches = []
      // regex used to determine if a string contains the substring `q`
      substrRegex = new RegExp(q, 'i')
      // iterate through the pool of strings and for any string that
      // contains the substring `q`, add it to the `matches` array
      $.each(strs, function(i, str) {
        if (substrRegex.test(str)) {
          matches.push(str)
        }
      })
      cb(matches)
    }
  }
  var states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
    'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii',
    'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
    'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
    'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
    'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
    'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
    'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
    'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
  ]
  $('#the-basics .typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'states',
    source: substringMatcher(states)
  })
})
