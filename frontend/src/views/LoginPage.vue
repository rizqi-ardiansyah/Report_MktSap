<template>
  <div class="flex min-h-screen">
    <!-- Left Side (Login Form) -->
   <div class="w-full md:w-1/3 flex flex-col bg-gradient-to-b from-gray-50 via-sky-100 to-sky-300 p-8 rounded-lg shadow-lg">
  <!-- isi login -->

      <!-- Logo -->
      <div class="flex items-center mb-10">
        <img
          src="../assets/img/logoArmada.png"
          alt="Company Logo"
          class="h-8 w-auto mr-3"
        />
      </div>

      <!-- Login Form -->
      <div class="flex-1 flex items-center justify-center">
        <div class="max-w-md w-full">
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
              <input
                v-model="username"
                type="text"
                placeholder="your-email@gmail.com"
                class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg"
              />
            </div>

            <!-- Password -->
            <div>
              <label class="block text-sm mb-1 mt-4">Password</label>
              <input
                v-model="password"
                type="password"
                placeholder="Your Password"
                class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-lg"
              />
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
  <button
    type="submit"
    class="flex-1 bg-sky-600 hover:bg-sky-900 text-white py-2 rounded-lg font-semibold shadow-md"
  >
    Log In
  </button>

  <button
    type="button"
    @click="goRegister"
    class="flex-1 bg-sky-600 hover:bg-sky-900 text-white py-2 rounded-lg font-semibold shadow-md"
  >
    Register
  </button>
</div>
          </form>
        </div>
      </div>
    </div>

    <!-- Right Side (Image) -->
    <div class="hidden md:block md:flex-1">
      <img
        src="../assets/img/NewArmada.jpeg"
        alt="Login Background"
        class="w-full h-full object-cover"
      />
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue"
import { useRouter } from "vue-router"

const router = useRouter()
const username = ref("")
const password = ref("")
const remember = ref(false)

function handleLogin() {
  if (username.value === "admin" && password.value === "1234") {
    localStorage.setItem("auth", "true")
    router.push("/portalMarketing")
  } else {
    alert("Invalid credentials")
  }
}
</script>
