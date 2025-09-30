<template>
  <div class="flex flex-col min-h-screen bg-gradient-to-br from-gray-100 to-gray-200 font-sans text-gray-800">
    <!-- Header -->
    <header class="bg-[#000a1a] shadow-md p-5">
      <div class="flex items-center gap-4">
        <img src="/src/assets/logo-removebg.png" alt="Company Logo" class="w-48 h-12 object-contain" />
        <h1 class="text-2xl font-bold text-white text-center w-full">
          Customer PT. Mekar Armada Jaya
        </h1>
      </div>
    </header>

    <!-- Main -->
    <main class="flex-1 p-6">
      <h2 class="text-center text-3xl font-bold mb-8 text-gray-800">
        Select a Portal
      </h2>

      <!-- Groups -->
      <div v-for="(group, gIndex) in groups" :key="gIndex" class="mb-10">
        <h3 class="text-xl font-semibold text-gray-700 mb-4">
          Group {{ gIndex + 1 }}
        </h3>

        <div class="grid grid-cols-[repeat(auto-fill,minmax(220px,1fr))] gap-10 p-4 w-full">
          <div
            v-for="portal in group"
            :key="portal.name"
            class="bg-white rounded-xl p-6 text-center cursor-pointer shadow-md hover:shadow-xl transition-transform duration-300 hover:-translate-y-2 flex flex-col justify-center h-56"
            @click="openPortal(portal.url)"
          >
            <div class="flex items-center justify-center h-28 mb-3">
              <img
                :src="portal.image"
                :alt="portal.name"
                class="w-full h-full object-contain"
                :style="portal.w && portal.h ? `width:${portal.w}px;height:${portal.h}px;` : ''"
              />
            </div>
            <h3 class="text-lg font-semibold text-gray-700 mt-auto">
              {{ portal.name }}
            </h3>
          </div>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-800 text-gray-200 text-center p-4 text-sm mt-auto">
      © 2025 Your Company. All rights reserved.
    </footer>
  </div>
</template>

<script setup>
const groups = [
  [
    { name: "ADM Ordering", url: "https://portal.hmmi.com", image: "/src/assets/daihatsu.png", w: 250, h: 250 },
    { name: "ADM Billing", url: "https://portal.hmmi.com", image: "/src/assets/daihatsu.png", w: 250, h: 250 },
    { name: "TMMIN", url: "https://portal.adm.com", image: "/src/assets/logo.png" },
    { name: "ASI FT", url: "https://portal.adm.com", image: "/src/assets/logo.png" },
    { name: "ASI HDM", url: "https://portal.adm.com", image: "/src/assets/logo.png" },
    { name: "MES", url: "https://portal.adm.com", image: "/src/assets/logo.png" },
    { name: "Gaya Motor", url: "https://portal.adm.com", image: "/src/assets/logo.png" },
    { name: "NTC", url: "https://portal.tmmin.com", image: "/images/tmmin.png" },
  ],
  [
    { name: "MKM", url: "https://portal.mkm.com", image: "/images/mkm.png" },
    { name: "MMKI", url: "https://portal.mmki.com", image: "/images/mmki.png" }
  ]
]

function openPortal(url) {
  window.open(url, "_blank")
}
</script>
