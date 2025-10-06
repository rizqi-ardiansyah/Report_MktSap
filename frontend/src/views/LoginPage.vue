<template>
  <div class="flex min-h-screen">
    <!-- Left Side (Login Form) -->
    <div
      class="w-full md:w-1/3 flex flex-col bg-gradient-to-b from-gray-50 via-sky-100 to-sky-300 p-8 rounded-lg shadow-lg">
      <!-- isi login -->

      <!-- Logo -->
      <div class="flex items-center mb-10">
        <img src="../assets/img/logoArmada.png" alt="Company Logo" class="h-8 w-auto mr-3" />
      </div>

      <!-- Login Form -->
      <div class="flex-1 flex items-center justify-center">
        <div class="max-w-md w-full">
          <!-- Login -->
          <div v-if="!isRegister">
            <h2 class="text-3xl font-bold font-poppins mb-2">
              Login to Portal Marketing
            </h2>
            <p class="text-gray-500 mb-4">
              Portal ini diperuntukkan khusus untuk tim Marketing PT. Mekar Armada Jaya
            </p>

            <form @submit.prevent="handleLogin" class="space-y">
              <!-- Username -->
              <div>
                <label class="block text-sm mb-1">Username</label>
                <input v-model="username" type="text" placeholder="Your Username"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg" />
              </div>

              <!-- Password -->
              <div class="relative mt-4">
                <label class="block text-sm mb-1">Password</label>
                <input
                  :type="showLoginPassword ? 'text' : 'password'"
                  v-model="password"
                  placeholder="Your Password"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg pr-10"
                />
                <button
                  type="button"
                  @click="showLoginPassword = !showLoginPassword"
                  class="absolute inset-y-11 right-0 pr-3 flex items-center text-gray-600"
                >
                  <i :class="showLoginPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
                </button>
              </div>

              <!-- Remember + Forgot -->
              <div class="flex items-center justify-between text-sm mt-4">
                <label class="flex items-center gap-2">
                  <input type="checkbox" v-model="remember" class="accent-blue-600" />
                  <span>Remember me</span>
                </label>
                <a href="#" class="text-blue-600 hover:underline">Forgot Password</a>
              </div>

              <!-- Submit + Register -->
              <div class="flex gap-4 mt-4">
                <button type="submit"
                  class="flex-1 bg-sky-600 hover:bg-sky-900 text-white py-2 rounded-lg font-semibold shadow-md">
                  Log In
                </button>

                <button type="button" @click="isRegister = true"
                  class="flex-1 bg-red-600 hover:bg-red-900 text-white py-2 rounded-lg font-semibold shadow-md">
                  Register
                </button>
              </div>
            </form>
          </div>

          <!-- REGISTER -->
          <div v-else>
            <h2 class="text-3xl font-bold font-poppins mb-2">Register Account</h2>
            <p class="text-gray-500 mb-4">
              Hanya tim Marketing dengan kode privat yang valid yang dapat membuat akun.
            </p>

            <form @submit.prevent="handleRegister" class="space-y-4">
              <div>
                <label class="block text-sm mb-1">Nama Lengkap</label>
                <input v-model="namaLengkap" type="text" placeholder="Masukkan Nama Lengkap"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg" />
              </div>

              <div>
                <label class="block text-sm mb-1">No NIK Pegawai</label>
                <input v-model="noId" type="text" placeholder="Masukkan NIK Pegawai"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg" />
              </div>

              <div>
                <label class="block text-sm mb-1">Username</label>
                <input v-model="regUsername" type="text" placeholder="Buat Username"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg" />
              </div>

              <!-- Password -->
              <div class="relative">
                <label class="block text-sm mb-1">Password</label>
                <input
                  :type="showRegPassword ? 'text' : 'password'"
                  v-model="regPassword"
                  placeholder="Buat Password"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg pr-10"
                />
                <button
                  type="button"
                  @click="showRegPassword = !showRegPassword"
                  class="absolute inset-y-11 right-0 pr-3 flex items-center text-gray-600"
                >
                  <i :class="showRegPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
                </button>
              </div>

              <!-- Re-enter Password -->
              <div class="relative">
                <label class="block text-sm mb-1">Re-enter Password</label>
                <input
                  :type="showRegRePassword ? 'text' : 'password'"
                  v-model="regRePassword"
                  placeholder="Ketik ulang Password"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg pr-10"
                />
                <button
                  type="button"
                  @click="showRegRePassword = !showRegRePassword"
                  class="absolute inset-y-11 right-0 pr-3 flex items-center text-gray-600"
                >
                  <i :class="showRegRePassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
                </button>
              </div>

              <div>
                <label class="block text-sm mb-1">Kode Privat Tim Marketing</label>
                <input v-model="kodePrivat" type="password" placeholder="Masukkan Kode Privat"
                  class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500 shadow-lg" />
              </div>

              <!-- Buttons -->
              <div class="flex gap-4 mt-4">
                <button type="submit"
                  class="flex-1 bg-sky-600 hover:bg-sky-900 text-white py-2 rounded-lg font-semibold shadow-md text-lg">
                  Register
                </button>

                <button type="button" @click="isRegister = false"
                  class="flex-1 bg-gray-400 hover:bg-gray-600 text-white py-2 rounded-lg font-semibold shadow-md text-lg">
                  Back to Login
                </button>
              </div>
            </form>
          </div>

        </div>
      </div>
    </div>

    <!-- Right Side (Image) -->
    <div class="hidden md:block md:flex-1">
      <img src="../assets/img/NewArmada.jpeg" alt="Login Background" class="w-full h-full object-cover" />
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue"
import { useRouter } from "vue-router"

const router = useRouter()

// State login
const username = ref("")
const password = ref("")
const remember = ref(false)
const isRegister = ref(false)
const showLoginPassword = ref(false)

// State register
const namaLengkap = ref("")
const noId = ref("")
const regUsername = ref("")
const regPassword = ref("")
const regRePassword = ref("")
const kodePrivat = ref("")
const showRegPassword = ref(false)
const showRegRePassword = ref(false)

// Kode privat tetap (hanya diketahui tim marketing)
const PRIVATE_CODE = "mkt2025"

// Handle Login
function handleLogin() {
  const savedUser = JSON.parse(localStorage.getItem("newUser"))

   // Akun default
  const defaultUser = {
    username: "admin",
    password: "1234",
    nama: "Default Admin"
  }

  // Cek apakah cocok dengan user hasil register
  const isRegisteredUserValid =
    savedUser &&
    username.value === savedUser.username &&
    password.value === savedUser.password

  // Cek apakah cocok dengan akun default
  const isDefaultUserValid =
    username.value === defaultUser.username &&
    password.value === defaultUser.password

  if (isRegisteredUserValid || isDefaultUserValid) {
    const namaUser = isRegisteredUserValid ? savedUser.nama : defaultUser.nama
    alert(`Selamat datang, ${namaUser}!`)
    localStorage.setItem("auth", "true")
    router.push("/portalMarketing")
  } else {
    alert("Username atau password salah!")
  }
}

// Handle Register
function handleRegister() {
  if (
    !namaLengkap.value ||
    !noId.value ||
    !regUsername.value ||
    !regPassword.value ||
    !regRePassword.value ||
    !kodePrivat.value
  ) {
    alert("Semua kolom harus diisi!")
    return
  }

  if (regPassword.value !== regRePassword.value) {
    alert("Password tidak sama!")
    return
  }

  if (kodePrivat.value !== PRIVATE_CODE) {
    alert("Kode privat salah!")
    return
  }

  const userData = {
    nama: namaLengkap.value,
    noId: noId.value,
    username: regUsername.value,
    password: regPassword.value
  }

  localStorage.setItem("newUser", JSON.stringify(userData))
  alert("Registrasi berhasil! Silakan login dengan akun baru.")
  isRegister.value = false
}
</script>
