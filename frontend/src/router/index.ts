import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import budgetMatHmmi from '../components/budgetMatHmmi.vue'
import budgetSoHmmi from '../components/budgetSoHmmi.vue'
import ListCustomer from '../views/ListCustomer.vue'
import portalMarketing from '../components/adminLayout.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue'),
    },
    {
      path: '/budgetMatHmmi',
      name: 'budgetHmmi',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: budgetMatHmmi,
    },
    {
      path: '/budgetSoHmmi',
      name: 'budgetSoHmmi',
      component: budgetSoHmmi,

    },
    {
      path: '/listCustomer',
      name: 'ListCustomer',
      component: ListCustomer,

    },
    {
      path: '/portalMarketing',
      name: 'portalMarketing',
      component: portalMarketing,

    }
  ],
})

export default router
