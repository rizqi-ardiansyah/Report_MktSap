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
        <h3 class="text-xl font-semibold text-stone-900" :class="{ 'mt-5': gIndex > 0 }" style="font-weight: bold;">
          Group {{ gIndex + 1 }}
        </h3>

        <div class="grid grid-cols-[repeat(auto-fill,minmax(280px,1fr))] gap-8 p-4 w-full">
          <div
            v-for="portal in group"
            :key="portal.name"
            class="bg-white rounded-xl p-6 text-center cursor-pointer shadow-md hover:shadow-xl transition-transform duration-300 hover:-translate-y-2 flex flex-col justify-center h-56"
            @click="handleClick(portal)"
          >
            <div class="flex items-center justify-center h-28 mb-3">
              <img
                :src="portal.image"
                :alt="portal.name"
                class="w-full h-full object-contain"
                :style="portal.w && portal.h ? `width:${portal.w}px;height:${portal.h}px;` : ''"
              />
            </div>
            <h3 class="text-lg font-semibold text-gray-700">
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

    <!-- Popup Modal -->
    <transition name="fade">
      <div
        v-if="selectedPortal"
       class="fixed inset-0 bg-white bg-opacity-40 backdrop-blur-sm flex items-center justify-center z-50 px-4 transition-opacity duration-300"
      style="background-color: rgba(255, 255, 255, 0.7);">
        <div class="bg-white bg-opacity-90 rounded-2xl shadow-2xl max-w-md w-full p-6 border border-gray-200">
          <h2 class="text-xl font-bold mb-10 text-center" style="margin-bottom: 10px;">
            Pilih Portal untuk {{ selectedPortal.name }}
          </h2>

          <div class="flex flex-col gap-2">
            <button
              v-for="(link, index) in selectedPortal.links"
              :key="index"
              class="bg-sky-600 hover:bg-sky-900 text-white py-2 px-5 rounded-lg transition-all duration-200"
              @click="goToLink(link.url)"
            >
              {{ link.label }}
            </button>
          </div>

          <button
            class="mt-6 w-full bg-gray-400 hover:bg-gray-500 text-white py-2 px-4 rounded-lg transition-all duration-200"
            @click="closePopup" style="margin-top: 20px;"
          >
            Batal
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref } from "vue"

const selectedPortal = ref(null)

const groups = [
  [
    {
      name: "PT Astra Daihatsu Motor",
      image: "/src/assets/img/daihatsu.png",
      w: 250, h: 250,
      links: [
        { label: "Portal Forecasting", url: "https://forecast.daihatsu.astra.co.id"},
        { label: "Portal Ordering & Billing", url: "https://assyst.daihatsu.astra.co.id/"},
        { label: "Portal GR", url: "https://adm-delvi.daihatsu.astra.co.id/Delvi/" }
      ]
    },
    { name: "PT Toyota Manufacturing Indonesia", url: "https://portal.toyota.co.id/", image: "/src/assets/img/toyota.png" },
    { name: "PT Adyawinsa Stamping Indonesia", url: "https://mail.newarmada.co.id/?app=mail#search?query=from%3Aadyawinsa", image: "/src/assets/img/adyawinsa.png" },
    { name: "PT Gaya Motor", url: "https://portal.adm.com", image: "/src/assets/img/gayaMotor.png", w: 150, h: 250},
    { name: "PT Fuji Technica Indonesia", url: "https://portal.adm.com", image: "/src/assets/img/fuji-technica.png", w: 350, h: 250},
    { name: "PT Nusa Toyotesu", url: "https://portal.tmmin.com", image: "/src/assets/img/nusaToyotesu.png", w: 230, h: 250 },
  ],
  [
    {
      name: "PT Hyundai Motor Manufacturing Indonesia",
      image: "/src/assets/img/hyundai.png",
      w: 230, h:250,
      links: [
        { label: "Portal Information", url: "https://sp.hmmi.co.id/irj/portal/sp" },
        { label: "Portal Billing", url: "https://partner.hyundai.com/gscm/" }
      ]
    },
    { name: "PT Mitsubishi Krama Yudha Motors", url: "https://e2e.ptmkm.co.id/login", image: "/src/assets/img/mkm.png", w: 220, h:250 },
    { name: "PT Mitsubishi Motor Kramayudha Indonesia", url: "https://e2e.ptmkm.co.id/login", image: "/src/assets/img/mitsubishi.png" },
    { name: "PT Krama Yudha Tiga Berlian Motors", url: "https://portal.mmki.com", image: "/src/assets/img/ktb.png",w: 250, h:250},
    { name: "PT Hanya Karya Bahana", url: "https://portal.mmki.com", image: "/src/assets/img/hkb.png",w: 250, h:250 },
    { name: "PT Honda Prospect Motor", url: "https://www.hpm.co.id:19757/login.aspx", image: "/src/assets/img/honda.png",w: 200, h:250 },
    { name: "PT Suzuki Indomobil Motor",
      image: "/src/assets/img/suzuki.png",w: 160, h:250,
      links: [
        { label: "Portal Information", url: "https://scs.suzuki.co.id/Login.aspx"},
        { label: "Portal Bidding", url: "https://e-proc.suzuki.co.id/main/auth/login"},
        { label: "Portal Ordering & Billing", url: "https://stn.suzuki.co.id/pur_portal/ICSLogin/" }
      ],
    },
    { name: "PT Summit Adyawinsa Indonesia", url: "https://vendor.summitadyawinsa.co.id/", image: "/src/assets/img/summitAdyawinsa.png",w: 200, h:250 },
    { name: "PT Sanwa Manufacturing Indonesia", url: "https://portal.mmki.com", image: "/src/assets/img/sanwa.png",w: 700, h:250 },
    { name: "PT Chandra Nugerah Cipta", url: "https://portal.mmki.com", image: "/src/assets/img/cnc.png" },
    { name: "PT Inti Polymetal", url: "https://portal.mmki.com", image: "/src/assets/img/ipm.png", w: 210, h:250 },
    { name: "PT Mitsubishi Motors Krama Yudha Sales Indonesia", url: "https://portal.mmki.com", image: "/src/assets/img/mitsubishi.png" },
  ]
]

function openPortal(url) {
  window.open(url, "_blank")
}

function handleClick(portal) {
  if (portal.links && portal.links.length > 1) {
    selectedPortal.value = portal
  } else {
    openPortal(portal.url)
  }
}

function closePopup() {
  selectedPortal.value = null
}

function goToLink(url) {
  window.open(url, "_blank")
  closePopup()
}
</script>

<style>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}
</style>
