import {createRouter, createWebHistory} from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      component: () => import('@/views/Manager.vue'),
      redirect: '/home',
      children: [
        { path: 'person', component: () => import('@/views/manager/Person.vue')},
        { path: 'password', component: () => import('@/views/manager/Password.vue')},
        { path: 'home', component: () => import('@/views/manager/Home.vue')},
        { path: 'admin', component: () => import('@/views/manager/Admin.vue')},
        { path: 'notice', component: () => import('@/views/manager/Notice.vue')},
        { path: 'artifact', component: () => import('@/views/manager/Artifact.vue')},
        { path: 'qa', component: () => import('@/views/manager/Qa.vue')},
        { path: 'goodsStock', component: () => import('@/views/manager/GoodsStock.vue')},
        { path: 'user', component: () => import('@/views/manager/User.vue')},
        { path: 'buy', component: () => import('@/views/manager/Buy.vue')},
        { path: 'orders', component: () => import('@/views/manager/Orders.vue')},
        { path: 'supplier', component: () => import('@/views/manager/Supplier.vue')},
        { path: 'relog', component: () => import('@/views/manager/relog.vue')},
        { path: 'goodreceive', component: () => import('@/views/manager/GoodsReceive.vue')},
        { path: 'receive', component: () => import('@/views/manager/receive.vue')},
        { path: 'returns', component: () => import('@/views/manager/Ordersreturn.vue')},
      ]
    },
    { path: '/login', component: () => import('@/views/Login.vue')},
    { path: '/register', component: () => import('@/views/Register.vue')},
  ]
})

export default router
