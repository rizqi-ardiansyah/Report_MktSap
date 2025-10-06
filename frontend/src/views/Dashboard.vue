<template>
  <div class="p-6">
    <!-- <h2 class="text-2xl font-bold text-gray-800 mb-6">Marketing Report Overview</h2> -->

    <!-- Grid Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-9">
      <div
        v-for="(card, index) in cards"
        :key="card.title"
        class="relative rounded-2xl shadow-md bg-gradient-to-b from-white to-blue-50 hover:shadow-xl  border border-gray-200"
      >
        <!-- Header -->
        <div class="bg-sky-700 text-white text-center text-sm font-semibold py-2 rounded-t-2xl">
          {{ card.header }}
        </div>

        <!-- Body -->
        <div class="flex flex-col items-center justify-center p-4">
          <img
            :src="card.image"
            alt="preview"
            class="rounded-md w-full h-90 object-cover mb-3"
          />
          <p class="text-lg font-semibold text-gray-700 text-center">{{ card.title }}</p>

          <!-- Dropdown Button -->
          <div class="relative mt-3">
            <button
              v-if="!card.title.toLowerCase().includes('by customer')"
              @click="toggleDropdown(index)"
              class="bg-sky-700 text-white px-4 py-2 rounded-md hover:bg-sky-900 transition flex items-center font-poppins"
            >
              PILIH PERIODE
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-4 w-4 ml-2"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </button>

            <!-- Jika 'by customer', tampilkan tombol OPEN -->
<button
  v-else
  @click="openReport(index)"
  class="bg-sky-700 text-white px-4 py-2 rounded-md hover:bg-sky-900 transition font-poppins"
>
  OPEN
</button>

            <!-- Dropdown Menu -->
            <div
              v-if="activeDropdown === index"
              class="absolute left-0 mt-2 w-40 bg-white border border-gray-200 rounded-md shadow-xl z-10"
            >
              <button
                v-for="(option, optIndex) in card.options"
                :key="optIndex"
                @click="openLink(option.url)"
                class="block w-full text-left px-4 py-2 text-gray-700 hover:bg-blue-100"
              >
                {{ option.label }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: "Dashboard",
  data() {
    return {
      activeDropdown: null,
      cards: [
        {
          title: "Report Delivery All Customer",
          header: "DELIVERY REPORT",
          image: "/src/assets/img/delivAllCust.png",
          options: [
 { label: "DAILY", url: "http://192.168.10.67/inventory-dashboard/report-delivery-customer/DAILY" },
            { label: "MONTHLY", url: "http://192.168.10.67/inventory-dashboard/report-delivery-customer/MONTHLY" },
          ],
        },
        {
          title: "Report DN Kembali All Customer",
          header: "DN RETURN REPORT",
          image: "/src/assets/img/dnBackAllCust.png",
          options: [
            { label: "DAILY", url: "http://192.168.10.67/inventory-dashboard/report-delivery-kembali-customer/DAILY" },
            { label: "MONTHLY", url: "http://192.168.10.67/inventory-dashboard/report-delivery-kembali-customer/MONTHLY" },
          ],
        },
        {
          title: "Volume Order Daily",
          header: "ORDER DAILY",
          image: "/src/assets/img/orderAllCust.png",
          options: [
            { label: "DAILY", url: "http://192.168.10.67/inventory-dashboard/report-order-daily" },
            { label: "MONTHLY", url: "http://192.168.10.67/inventory-dashboard/report-order-monthly" },
          ],
        },
        {
          title: "Volume Order Monthly by Customer",
          header: "ORDER BY CUSTOMER",
          image: "/src/assets/img/orderByCust.png",
          url: "http://192.168.10.67/inventory-dashboard/report-order-monthly/customer"
        },
      ],
    };
  },
  methods: {
    toggleDropdown(index) {
      this.activeDropdown = this.activeDropdown === index ? null : index;
    },
    openLink(url) {
      window.open(url, "_blank");
      this.activeDropdown = null;
    },
     openReport(index) {
    const card = this.cards[index]
    window.open(card.url, '_blank')
  }
  },
};
</script>

<style scoped>
/* Tambahan halus agar dropdown lebih lembut */
button {
  font-size: 0.875rem;
}
</style>
