<template>
  <div class="p-6 bg-gray-50 min-h-screen">
    <h2 class="text-2xl font-bold mb-4 text-gray-800 text-center">Tracking Parsel</h2>

    <!-- Filter Tahun -->
    <div class="flex justify-between items-center mb-4">
      <div>
        <label class="mr-2 font-medium text-gray-700">Pilih Tahun:</label>
        <select v-model="selectedYear" class="border px-3 py-2 rounded-md">
          <option v-for="year in Object.keys(yearColumns)" :key="year" :value="year">
            {{ year }}
          </option>
        </select>
      </div>

      <!-- Tombol Tambah -->
      <button
        @click="openCreateModal"
        class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-md"
      >
        + Tambah Data
      </button>
    </div>

    <!-- Tabel Data -->
    <div class="overflow-x-auto bg-white rounded-lg shadow">
      <table class="min-w-full border border-gray-300">
        <thead class="bg-blue-300 text-center">
          <tr>
            <th class="border p-2">No</th>
            <th class="border p-2">Customer</th>
            <th class="border p-2">Nama</th>
            <th class="border p-2">Jabatan</th>
            <th class="border p-2">Alamat</th>
            <th class="border p-2">Telepon</th>

            <!-- Kolom Dinamis Berdasarkan Tahun -->
            <th
              v-for="col in yearColumns[selectedYear]"
              :key="col.key"
              class="border p-2"
            >
              {{ col.label }}
            </th>

            <th class="border p-2">Aksi</th>
          </tr>
        </thead>

        <tbody>
          <tr
            v-for="(item, index) in parselData"
            :key="item.id"
            class="text-center hover:bg-gray-100 transition"
          >
            <td class="border p-2">{{ index + 1 }}</td>
            <td class="border p-2">{{ item.customer }}</td>
            <td class="border p-2">{{ item.nama }}</td>
            <td class="border p-2">{{ item.jabatan }}</td>
            <td class="border p-2">{{ item.alamat }}</td>
            <td class="border p-2">{{ item.telepon }}</td>

            <!-- Input dinamis berdasarkan key -->
            <td
              v-for="col in yearColumns[selectedYear]"
              :key="col.key"
              class="border p-2"
            >
              <input type="checkbox" v-model="item[col.key]" @change="saveLocalData" />
            </td>

            <td class="border p-2">
              <div class="flex justify-center space-x-2">
                <button
                  @click="showDetail(item)"
                  class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded-md"
                >
                  Detail
                </button>
                <button
                  @click="openEditModal(item)"
                  class="bg-yellow-400 hover:bg-yellow-500 text-white px-3 py-1 rounded-md"
                >
                  Edit
                </button>
                <button
                  @click="deleteItem(item.id)"
                  class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-md"
                >
                  Hapus
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal Detail -->
    <div
      v-if="detailModal"
      class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-96 shadow-lg">
        <h3 class="text-lg font-semibold mb-4">Detail Data</h3>
        <p><b>Customer:</b> {{ selectedItem.customer }}</p>
        <p><b>Nama:</b> {{ selectedItem.nama }}</p>
        <p><b>Jabatan:</b> {{ selectedItem.jabatan }}</p>
        <p><b>Alamat:</b> {{ selectedItem.alamat }}</p>
        <p><b>Telepon:</b> {{ selectedItem.telepon }}</p>
        <div class="text-right mt-4">
          <button
            @click="detailModal = false"
            class="bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-md"
          >
            Tutup
          </button>
        </div>
      </div>
    </div>

    <!-- Modal Edit -->
    <div
      v-if="editModal"
      class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-lg p-6 w-96 shadow-lg">
        <h3 class="text-lg font-semibold mb-4">Edit Data</h3>

        <div class="space-y-3">
          <div>
            <label class="block text-sm font-medium text-gray-700">Customer</label>
            <input
              v-model="editForm.customer"
              class="w-full border rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700">Nama</label>
            <input
              v-model="editForm.nama"
              class="w-full border rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700">Jabatan</label>
            <input
              v-model="editForm.jabatan"
              class="w-full border rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700">Alamat</label>
            <textarea
              v-model="editForm.alamat"
              rows="2"
              class="w-full border rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400"
            ></textarea>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700">Telepon</label>
            <input
              v-model="editForm.telepon"
              class="w-full border rounded-md px-3 py-2 focus:ring-2 focus:ring-blue-400"
            />
          </div>

          <div class="flex justify-end space-x-2 pt-4">
            <button
              @click="editModal = false"
              class="bg-gray-400 hover:bg-gray-500 text-white px-4 py-2 rounded-md"
            >
              Batal
            </button>
            <button
              @click="saveEdit"
              class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md"
            >
              Simpan
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import Swal from "sweetalert2";

const selectedYear = ref("2024");

// 🔹 Daftar kolom per tahun (kunci tunggal)
const yearColumns = {
  2023: [
    { key: "kueImlek2023", label: "Kue Imlek 2023" },
    { key: "parcelLebaran2023", label: "Parsel Lebaran 2023" },
    { key: "parcelBuah2023", label: "Parsel Buah 2023" },
    { key: "parcelNatal2023", label: "Parsel Natal 2023" },
  ],
  2024: [
    { key: "kueImlek2024", label: "Kue Imlek 2024" },
    { key: "parcelLebaran2024", label: "Parsel Lebaran 2024" },
    { key: "parcelBuah2024", label: "Parsel Buah 2024" },
    { key: "parcelNatal2024", label: "Parsel Natal 2024" },
  ],
  2025: [
    { key: "kueImlek2025", label: "Kue Imlek 2025" },
    { key: "parcelLebaran2025", label: "Parsel Lebaran 2025" },
    { key: "parcelBuah2025", label: "Parsel Buah 2025" },
    { key: "parcelNatal2025", label: "Parsel Natal 2025" },
  ],
};

// 🔹 Data Lokal
const parselData = ref([]);

const loadLocalData = () => {
  const stored = localStorage.getItem("parselData");
  if (stored) {
    parselData.value = JSON.parse(stored);
  } else {
    parselData.value = [
      {
        id: 1,
        customer: "PT Adyawinsa Stamping Indonesia",
        nama: "Budi Santoso",
        jabatan: "Manager Produksi",
        alamat: "Jl. Melati No. 10, Bekasi",
        telepon: "081234567890",
        kueImlek2023: false,
        parcelLebaran2023: true,
        parcelBuah2023: true,
        parcelNatal2023: false,
        kueBulan2024: true,
        kueNatal2024: false,
        hadiah2025: false,
        souvenir2025: false,
      },
    ];
  }
};

const saveLocalData = () => {
  localStorage.setItem("parselData", JSON.stringify(parselData.value));
};

// 🔹 DETAIL
const detailModal = ref(false);
const selectedItem = ref({});

const showDetail = (item) => {
  selectedItem.value = { ...item };
  detailModal.value = true;
};

// 🔹 EDIT
const editModal = ref(false);
const editForm = ref({});
let editingId = null;

const openEditModal = (item) => {
  editForm.value = { ...item };
  editingId = item.id;
  editModal.value = true;
};

const saveEdit = () => {
  const index = parselData.value.findIndex((x) => x.id === editingId);
  if (index !== -1) {
    parselData.value[index] = { ...editForm.value };
    saveLocalData();
    editModal.value = false;

    Swal.fire({
      icon: "success",
      title: "Berhasil",
      text: "Data berhasil diperbarui!",
      timer: 1500,
      showConfirmButton: false,
    });
  }
};

// 🔹 DELETE pakai SweetAlert2
const deleteItem = async (id) => {
  const result = await Swal.fire({
    title: "Yakin ingin menghapus?",
    text: "Data yang dihapus tidak dapat dikembalikan!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#d33",
    cancelButtonColor: "#3085d6",
    confirmButtonText: "Ya, hapus!",
    cancelButtonText: "Batal",
  });

  if (result.isConfirmed) {
    parselData.value = parselData.value.filter((x) => x.id !== id);
    saveLocalData();

    Swal.fire({
      icon: "success",
      title: "Terhapus!",
      text: "Data berhasil dihapus.",
      timer: 1500,
      showConfirmButton: false,
    });
  }
};

// 🔹 CREATE
const openCreateModal = () => {
  Swal.fire({
    title: "Fitur Tambah Data",
    text: "Fitur ini masih dalam pengembangan (mockup lokal).",
    icon: "info",
    confirmButtonText: "OK",
  });
};

onMounted(loadLocalData);
watch(parselData, saveLocalData, { deep: true });
</script>

