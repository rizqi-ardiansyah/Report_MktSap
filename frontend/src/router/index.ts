import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import budgetMatHmmi from '../components/budgetMatHmmi.vue'
import budgetSoHmmi from '../components/budgetSoHmmi.vue'
import ListCustomer from '../views/ListCustomer.vue'
import portalMarketing from '../components/adminLayout.vue'
import Login from '../views/LoginPage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Dashboard',
      component: HomeView,
      meta: { requiresAuth: true }, // 🚀 butuh login
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue'),
      meta: { requiresAuth: true }, // 🚀 butuh login
    },
    {
      path: '/budgetMatHmmi',
      name: 'budgetMatHmmi',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: budgetMatHmmi,
      meta: { requiresAuth: true }, // 🚀 butuh login
    },
    {
      path: '/budgetSoHmmi',
      name: 'budgetSoHmmi',
      component: budgetSoHmmi,
      meta: { requiresAuth: true }, // 🚀 butuh login

    },
    {
      path: '/listCustomer',
      name: 'ListCustomer',
      component: ListCustomer,
      meta: { requiresAuth: true }, // 🚀 butuh login

    },
    {
      path: '/login',
      name: 'LoginPage',
      component: Login,
      // meta: { requiresAuth: true }, // 🚀 butuh login

    },
    {
      path: '/portalMarketing',
      // name: 'portalMarketing',
      component: portalMarketing,
        children: [
        { path: 'listCustomer',
          name: 'ListCustomer',
          component: ListCustomer,
      meta: { requiresAuth: true }, // 🚀 butuh login

        },
        {
          path: 'budgetMatHmmi',
          name: 'budgetMatHmmi',
          component: budgetMatHmmi,
      meta: { requiresAuth: true }, // 🚀 butuh login
        },
        {
          path: 'budgetSoHmmi',
          name: 'budgetSoHmmi',
          component: budgetSoHmmi,
      meta: { requiresAuth: true }, // 🚀 butuh login
        },
        // {
        //   path: 'budgetTmmin',
        //   name: 'budgetTmmin',
        //   component: () => import('../components/budgetTmmin.vue')
        // }
      ],
      meta: { requiresAuth: true }, // 🚀 butuh login
    }
  ],
})

router.beforeEach((to, from, next) => {
  const isAuthenticated = localStorage.getItem("isLoggedIn") === "true"

  if (to.meta.requiresAuth && !isAuthenticated) {
    next("/login") // kalau belum login, redirect ke login
  } else {
    next() // kalau sudah login, lanjut
  }
})


export default router
