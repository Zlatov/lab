window.router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/vue/_tasks/access_children_component/router1.html',
      component: window.component1
    },
    {
      path: '/vue/_tasks/access_children_component/router2.html',
      component: window.component2
    }
  ]
})
