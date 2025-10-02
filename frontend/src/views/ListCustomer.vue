<template>
  <div class="flex flex-col min-h-screen font-sans text-gray-800">
    <!-- Header -->
    <!-- <header class="bg-[#000a1a] shadow-md p-5">
      <div class="flex items-center gap-4">
        <img src="/src/assets/logo-removebg.png" alt="Company Logo" class="w-48 h-12 object-contain" />
        <h1 class="text-2xl font-bold text-white text-center w-full">
          Customer PT. Mekar Armada Jaya
        </h1>
      </div>
    </header> -->

    <!-- Main -->
    <main class="flex-1 p-6">
      <!-- <h2 class="text-center text-3xl font-bold mb-8 text-gray-800">
        Select a Portal
      </h2> -->

      <!-- Groups -->
      <div v-for="(group, gIndex) in groups" :key="gIndex">
        <h3 class="text-xl font-semibold text-stone-900 mb-20" style="font-weight: bold;">
          Group {{ gIndex + 1 }}
        </h3>

        <div class="grid grid-cols-[repeat(auto-fill,minmax(300px,1fr))] gap-10 p-4 w-full">
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
            <h3 class="text-lg font-semibold text-gray-700" style="font-weight: 500; margin-top: 20px;">
              {{ portal.name }}
            </h3>
          </div>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <!-- <footer class="bg-gray-800 text-gray-200 text-center p-4 text-sm mt-auto">
      © 2025 Your Company. All rights reserved.
    </footer> -->
  </div>
</template>

<script setup>
const groups = [
  [
    { name: "PT Astra Daihatsu Motor", url: "https://portal.hmmi.com", image: "/src/assets/img/daihatsu.png", w: 250, h: 250 },
    { name: "PT Toyota Manufacturing Indonesia", url: "https://portal.adm.com", image: "/src/assets/img/toyota.png" },
    { name: "PT Adyawinsa Stamping Indonesia", url: "https://portal.adm.com", image: "/src/assets/img/adyawinsa.png" },
    // { name: "ASI HDM", url: "https://portal.adm.com", image: "/src/assets/adyawinsa.png" },
    // { name: "MES", url: "https://portal.adm.com", image: "/src/assets/img/logo.png" },
    { name: "PT Gaya Motor", url: "https://portal.adm.com", image: "/src/assets/img/gayaMotor.png", w: 150, h: 250},
    { name: "PT Nusa Toyotesu", url: "https://portal.tmmin.com", image: "/src/assets/img/nusaToyotesu.png", w: 230, h: 250 },
    // { name: "MES", url: "https://portal.tmmin.com", image: "/images/tmmin.png" },
  ],
  [
    { name: "PT Hyundai Motor Manufacturing Indonesia", url: "https://portal.mkm.com", image: "/src/assets/img/hyundai.png", w: 230, h:250 },
    { name: "PT Mitsubishi Krama Yudha Motors", url: "https://portal.mmki.com", image: "/src/assets/img/mkm.png", w: 220, h:250 },
    { name: "PT Krama Yudha Tiga Berlian Motors", url: "https://portal.mmki.com", image: "/src/assets/img/ktb.png",w: 250, h:250},
    { name: "PT Hanya Karya Bahana", url: "https://portal.mmki.com", image: "/src/assets/img/hkb.png",w: 250, h:250 },
    { name: "PT Honda Prospect Motor", url: "https://portal.mmki.com", image: "/src/assets/img/honda.png",w: 200, h:250 },
    { name: "PT Summit Adyawinsa Indonesia", url: "https://portal.mmki.com", image: "/src/assets/img/summitAdyawinsa.png",w: 200, h:250 },
    { name: "PT Sanwa Manufacturing Indonesia", url: "https://portal.mmki.com", image: "/src/assets/img/sanwa.png",w: 700, h:250 },
    { name: "PT Chandra Nugerah Cipta", url: "https://portal.mmki.com", image: "/src/assets/img/cnc.png" },
    { name: "PT Inti Polymetal", url: "https://portal.mmki.com", image: "/src/assets/img/ipm.png", w: 210, h:250 },
    { name: "PT Mitsubishi Motors Krama Yudha Sales Indonesia", url: "https://portal.mmki.com", image: "/src/assets/img/mitsubishi.png" },
    // { name: "SGS-IPM", url: "https://portal.mmki.com", image: "/images/mmki.png" },
    // { name: "SAI", url: "https://portal.mmki.com", image: "/images/mmki.png" },
    // { name: "SANWA", url: "https://portal.mmki.com", image: "/images/mmki.png" },
    // { name: "CNI", url: "https://portal.mmki.com", image: "/images/mmki.png" },
    // { name: "CNC", url: "https://portal.mmki.com", image: "/images/mmki.png" },
    // { name: "IPM", url: "https://portal.mmki.com", image: "/images/mmki.png" },
  ]
]

function openPortal(url) {
  window.open(url, "_blank")
}
</script>
