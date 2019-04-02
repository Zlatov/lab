"use strict"

window.Vue.use(window['VueRouter'])

window.PersonalInfo = {
  data: function() {
    return {}
  },
  template: `
    <h2>PersonalInfo</h2>
  `,
}
window.CompanyRegistration = {
  data: function() {
    return {}
  },
  template: `
    <h2>CompanyRegistration</h2>
  `,
}

var router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/vue/_tasks/router/PersonalInfo.html',
      component: window.PersonalInfo,
    },
    {
      path: '/vue/_tasks/router/CompanyRegistration.html',
      component: window.CompanyRegistration,
    },
  ]
})

window.ComponentSwitcher = new Vue({
  data: function() {
    return {
      cs_var: "asd"
    }
  },
  router: window.router,
}).$mount('#component-switcher')
