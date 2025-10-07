<template>
  <div class="flex h-screen bg-gray-100">
    <!-- Sidebar -->
    <aside
      :class="[
        'bg-gradient-to-b from-white to-blue-400 text-black shadow-lg transition-all duration-300',
        sidebarOpen ? 'w-64' : 'w-0 overflow-hidden','print:hidden'
      ]"
    >
      <div v-if="sidebarOpen" class="flex flex-col h-full">
        <!-- Logo -->
        <div class="flex items-center gap-3 px-6 py-4 border-b border-blue-600">
          <img src="@/assets/img/logoArmada.png" alt="Logo" class="w-40 h-8 object-contain" />
        </div>

        <!-- Navigation -->
        <nav class="flex-1 p-4 space-y-1 divide-y divide-sky-600">
          <!-- level 1 -->
          <div v-for="(item, i) in menu" :key="i">
            <!-- item dengan children (misal: Report) -->
            <div v-if="item.children">
              <button
                @click="toggleDropdown(item.name)"
                :class="[
                  'w-full flex items-center justify-between px-4 py-2 rounded-lg transition hover:text-white',
                  currentMenu === item.name ? 'bg-sky-700 text-white' : 'hover:bg-sky-600'
                ]"
              >
                <div class="flex items-center gap-3">
                  <component v-if="item.icon" :is="item.icon" class="w-5 h-5" />
                  <span class="text-sm font-bold">{{ item.name }}</span>
                </div>
                <span>{{ openDropdown.includes(item.name) ? '▲' : '▼' }}</span>
              </button>

              <!-- level 2 (children of item) -->
              <div v-if="openDropdown.includes(item.name)" class="ml-6 mt-1 space-y-1">
                <div v-for="(child, ci) in item.children" :key="ci">
                  <!-- jika child memiliki children (misal: HMMI) -> tampilkan toggle sub -->
                  <div v-if="child.children">
                    <button
                      @click="toggleSubDropdown(item.name, child.name)"
                      :class="[
                        'w-full flex items-center justify-between px-4 py-2 rounded-lg transition text-sm font-bold hover:text-white',
                        currentMenu === child.name ? 'bg-sky-700 text-white font-bold' : 'hover:bg-sky-600'
                      ]"
                    >
                      <span class="truncate">{{ child.name }}</span>
                      <span>{{ openSubDropdown.includes(`${item.name}:${child.name}`) ? '▲' : '▼' }}</span>
                    </button>

                    <!-- level 3 (grandchildren) -->
                    <div
                      v-if="openSubDropdown.includes(`${item.name}:${child.name}`)"
                      class="ml-6 mt-1 space-y-1" style="margin-left: 20px;"
                    >
                      <button
                        v-for="(g, gi) in child.children"
                        :key="gi"
                        @click="goTo(g.path, g.name)"
                        :class="[
                          'w-full text-left px-3 py-2 text-sm rounded-lg transition hover:text-white',
                          currentMenu === g.name ? 'bg-sky-700 text-white' : 'hover:bg-sky-600'
                        ]"
                      >
                        {{ g.name }}
                      </button>
                    </div>
                  </div>

                  <!-- jika child adalah leaf (misal: ADM) -->
                  <div v-else>
                    <button
                      @click="goTo(child.path, child.name)"
                      :class="[
                        'w-full text-left px-3 py-2 text-sm rounded-lg transition',
                        currentMenu === child.name ? 'bg-sky-700 text-white' : 'hover:bg-sky-500'
                      ]"
                    >
                      {{ child.name }}
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <!-- item tanpa children (level 1 leaf) -->
            <div v-else>
              <button
                @click="setMenu(item.name, item.path)"
                :class="[
                  'w-full flex items-center gap-3 px-4 py-2 rounded-lg transition hover:bg-sky-600 hover:text-white ',
                  currentMenu === item.name ? 'bg-sky-700 text-white' : 'hover:bg-sky-600'
                ]"
              >
                <component v-if="item.icon" :is="item.icon" class="w-5 h-5" />
                <span class="text-sm font-medium">{{ item.name }}</span>
              </button>
            </div>
          </div>
        </nav>
      </div>
    </aside>

    <!-- Main content -->
    <div class="flex-1 flex flex-col transition-all duration-300">
      <!-- Header -->
      <header class="bg-white shadow flex items-center justify-between px-6 py-3 print:hidden">
        <div class="flex items-center gap-4">
          <!-- Toggle button -->
          <button @click="sidebarOpen = !sidebarOpen" class="p-2 rounded hover:bg-gray-200">
            <Menu class="w-6 h-6 text-gray-700" />
          </button>
          <h2 class="text-lg font-bold text-black">{{ currentMenu }}</h2>
        </div>
        <div class="flex items-center gap-4 print:hidden">
          <input
            type="text"
            placeholder="Search..."
            class="px-3 py-2 border rounded-lg text-sm focus:outline-none focus:ring focus:ring-blue-300"
          />
          <button @click="logout" class="px-4 py-2 bg-sky-600 text-white text-sm rounded-lg hover:bg-sky-900 print:hidden">
            Logout
          </button>
        </div>
      </header>

      <!-- Content -->
      <main class="flex-1 p-6 overflow-y-auto"
      :class="{ 'pt-0': currentMenu === 'Budget Material HMMI' || currentMenu === 'Budget Sales Amount HMMI' }">
        <!-- Contoh landing Dashboard -->
        <!-- <div v-if="currentMenu === 'Dashboard'">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">
            Welcome to New Portal for Team Marketing
          </h3>
          <p class="text-gray-600 mb-6">Select a portal or use the sidebar to navigate.</p>
        </div> -->

         <!-- <div v-if="currentMenu === 'Account'">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">
            This is portal for account
          </h3>
          <p class="text-gray-600 mb-6">Select a portal or use the sidebar to navigate.</p>
        </div> -->

         <div v-if="currentMenu === 'Documentation'">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">
            This is portal for documentation
          </h3>
          <p class="text-gray-600 mb-6">Select a portal or use the sidebar to navigate.</p>
        </div>

        <div v-else-if="currentMenu === 'Report' || currentMenu === 'HMMI' || currentMenu === 'ADM'">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">
            This is portal for report
          </h3>
          <p class="text-gray-600 mb-6">Select a portal or use the sidebar to navigate.</p>
        </div>


         <div v-else-if="currentMenu === 'Others'">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">
            This is portal for others
          </h3>
          <p class="text-gray-600 mb-6">Select a portal or use the sidebar to navigate.</p>
        </div>

        <router-view v-else />
      </main>

      <!-- Footer -->
      <footer class="bg-white shadow px-6 py-3 text-center text-gray-500 text-sm print:hidden">
        © 2025 New Armada. All rights reserved.
      </footer>
    </div>
  </div>
</template>

<script setup>
import Swal from "sweetalert2";
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import {
  CircleUserIcon,
  CarIcon,
  FileTextIcon,
  HouseIcon,
  FileCheckIcon,
  Menu
} from 'lucide-vue-next'

// states
const sidebarOpen = ref(true)
const currentMenu = ref('Dashboard')

// open arrays: top-level and second-level (parent:child)
const openDropdown = ref([])         // contoh: ['Report']
const openSubDropdown = ref([])      // contoh: ['Report:HMMI']

const router = useRouter()

// struktur menu: Report -> HMMI -> (Budget Material, Budget Sales Amount)
const menu = [
  { name: 'Dashboard', icon: HouseIcon, path: '/dashboard'},
  { name: 'Customer', icon: CarIcon, path: '/listCustomer'},
  { name: 'Account', icon: CircleUserIcon, path: '/account' },
  {
    name: 'Report',
    icon: FileCheckIcon,
    children: [
      {
        name: 'HMMI',
        // HMMI punya submenu level 3
        children: [
          { name: 'Budget Material HMMI', path: '/budgetMatHmmi' },
          { name: 'Budget Sales Amount HMMI', path: '/budgetSoHmmi' }
        ]
      },
      // ADM dan TMMIN adalah direct links (level 2 leaf)
      { name: 'ADM',
        children: [
          { name: 'Budget Materials', path: '/budgetMatHmmi' },
          { name: 'Budget Sales Amounts', path: '/budgetSoHmmi' }
        ]
       },
      // { name: 'TMMIN', path: '/budgetTmmin' }
    ]
  },
  { name: 'Others', icon: Menu,
    children: [
      {
        name: 'Tracking Parsel',
        path: '/trackParsel'
      },
      // { name: 'TMMIN', path: '/budgetTmmin' }
    ]
  }
]

// helper: navigasi
function goTo(path, name = null) {
  if (name) currentMenu.value = name
  if (path) router.push(path).catch(() => {}) // ignore navigation duplicate errors
}

// set menu top-level (untuk item tanpa children)
function setMenu(name, path = null) {
  currentMenu.value = name
  if (path) router.push(path).catch(() => {})
}

// toggle open top-level dropdown (Report, dsb.)
function toggleDropdown(name) {
  const idx = openDropdown.value.indexOf(name)
  if (idx > -1) {
    // close and also close any sub-dropdowns that belong to this parent
    openDropdown.value.splice(idx, 1)
    openSubDropdown.value = openSubDropdown.value.filter(k => !k.startsWith(name + ':'))
  } else {
    openDropdown.value.push(name)
  }
  // set header to parent name when toggled open
  currentMenu.value = name
}

// toggle second-level dropdown (parentName:childName), misal Report:HMMI
function toggleSubDropdown(parentName, childName) {
  const key = `${parentName}:${childName}`
  const idx = openSubDropdown.value.indexOf(key)
  if (idx > -1) {
    openSubDropdown.value.splice(idx, 1)
  } else {
    openSubDropdown.value.push(key)
    // optionally ensure parent is opened
    if (!openDropdown.value.includes(parentName)) openDropdown.value.push(parentName)
  }
  currentMenu.value = childName
}

function logout() {
   Swal.fire({
    title: "Yakin ingin logout?",
    text: "Anda akan keluar dari sistem.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Ya, logout",
    cancelButtonText: "Batal",
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
  }).then((result) => {
    if (result.isConfirmed) {
      localStorage.removeItem("auth");
      router.push("/login");
      Swal.fire("Berhasil Logout", "Anda telah keluar dari sistem.", "success");
    }
  });
}
</script>
