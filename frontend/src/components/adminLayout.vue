<template>
  <div class="flex h-screen bg-gray-100">
    <!-- Sidebar -->
    <aside
      :class="[
        'bg-gradient-to-b from-stone-900 to-blue-800 text-white shadow-lg transition-all duration-300',
        sidebarOpen ? 'w-64' : 'w-0 overflow-hidden'
      ]"
    >
      <div v-if="sidebarOpen" class="flex flex-col h-full">
        <!-- Logo -->
        <div class="flex items-center gap-3 px-6 py-4 border-b border-blue-600">
          <img src="@/assets/logoArmada.png" alt="Logo" class="w-40 h-8 object-contain" />
        </div>

        <!-- Navigation -->
        <nav class="flex-1 p-4 space-y-2 divide-y divide-sky-600">
          <button
            v-for="(item, i) in menu"
            :key="i"
            @click="currentMenu = item.name"
            class="w-full flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-sky-600 transition"
          >
            <component :is="item.icon" class="w-5 h-5" />
            <span class="text-sm font-medium">{{ item.name }}</span>
          </button>
        </nav>
      </div>
    </aside>

   <!-- Main content -->
<div
  :class="[
    'flex flex-col transition-all duration-300',
    sidebarOpen ? 'w-[calc(100%-16rem)]' : 'w-full'
  ]"
>
  <!-- Header -->
  <header class="bg-white shadow flex items-center justify-between px-6 py-3">
    <div class="flex items-center gap-4">
      <!-- Toggle button -->
      <button @click="sidebarOpen = !sidebarOpen" class="p-2 rounded hover:bg-gray-200">
        <Menu class="w-6 h-6 text-gray-700" />
      </button>
      <h2 class="text-lg font-bold text-black">{{ currentMenu }}</h2>
    </div>
    <div class="flex items-center gap-4">
      <input
        type="text"
        placeholder="Search..."
        class="px-3 py-2 border rounded-lg text-sm focus:outline-none focus:ring focus:ring-blue-300"
      />
      <button
        class="px-4 py-2 bg-blue-600 text-white text-sm rounded-lg hover:bg-blue-700"
      >
        Logout
      </button>
    </div>
  </header>

  <!-- Content -->
  <main class="flex-1 p-6 overflow-y-auto">
    <!-- Dashboard -->
    <div v-if="currentMenu === 'Dashboard'">
      <h3 class="text-2xl font-bold text-gray-800 mb-4">
        Welcome to New Portal for Team Marketing
      </h3>
      <p class="text-gray-600 mb-6">
        Select a portal or use the sidebar to navigate.
      </p>
    </div>

    <!-- Report -->
    <div v-if="currentMenu === 'Report'" class="space-y-4">
      <!-- <h3 class="text-xl font-bold text-gray-800 mb-4">Choose Report</h3> -->
      <div class="flex gap-4">
        <button
          @click="goTo('/budgetMatHmmi')"
          class="px-6 py-3 bg-blue-900 text-white rounded-lg hover:bg-blue-700"
        >
          Budget Mat HMMI
        </button>
        <button
          @click="goTo('/budgetS0Hmmi')"
          class="px-6 py-3 bg-blue-900 text-white rounded-lg hover:bg-blue-700"
        >
          Budget Sales Amount HMMI
        </button>
      </div>
    </div>
  </main>

  <!-- Footer -->
  <footer class="bg-white shadow px-6 py-3 text-center text-gray-500 text-sm">
    © 2025 New Armada. All rights reserved.
  </footer>
</div>

  </div>
</template>

<script setup>
import { useRouter } from "vue-router"
import { ref } from "vue"
import { CircleUserIcon, CarIcon, FileTextIcon, HouseIcon, FileCheckIcon, Menu } from "lucide-vue-next"

const sidebarOpen = ref(true)
const currentMenu = ref("Dashboard")
const router = useRouter()

const menu = [
  { name: "Dashboard", icon: HouseIcon },
  { name: "Customer", icon: CarIcon },
  { name: "Account", icon: CircleUserIcon },
  { name: "Documentation", icon: FileTextIcon },
  { name: "Report", icon: FileCheckIcon},
  { name: "Others", icon: Menu },
]

function goTo(path) {
  router.push(path) // navigate to route
}

</script>
