"use strict"

function welcome(object_name) {
  if (NODE_ENV == "development") {
    console.log('object_name: ', object_name)
    console.log('process.env.USER: ', process.env.USER)
  }
  console.log("Welcome, " + object_name + "!")
}

module.exports = welcome
