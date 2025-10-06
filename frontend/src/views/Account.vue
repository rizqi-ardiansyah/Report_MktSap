<template>
  <div class="p-6">
    <div class="flex items-center justify-between mb-6">
      <h1 class="text-2xl font-bold">Account Management</h1>

      <div class="flex items-center gap-3">
        <input
          v-model="q"
          type="search"
          placeholder="Search portal or username..."
          class="px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-sky-500"
        />
        <button
          @click="openCreate()"
          class="bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded-md shadow"
        >
          + Create
        </button>
      </div>
    </div>

    <div class="overflow-x-auto bg-white rounded-lg shadow">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50 text-center font-poppins font-normal">
          <tr>
            <th class="px-4 py-3 text-sm text-gray-700">No</th>
            <th class="px-4 py-3 text-sm text-gray-700">Portal</th>
            <th class="px-4 py-3 text-sm text-gray-700">Username</th>
            <th class="px-4 py-3 text-sm text-gray-700">Password</th>
            <th class="px-4 py-3 text-sm text-gray-700">Created By / At</th>
            <th class="px-4 py-3 text-sm text-gray-700">Updated By / At</th>
            <th class="px-4 py-3 text-sm text-gray-700">Actions</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-100">
          <tr v-for="(acc, idx) in filteredAccounts" :key="acc.id">
            <td class="px-4 py-3 text-sm text-gray-700">{{ idx + 1 }}</td>
            <td class="px-4 py-3 text-sm text-gray-700">{{ acc.portal }}</td>
            <td class="px-4 py-3 text-sm text-gray-700">{{ acc.username }}</td>
            <td class="px-4 py-3 text-sm text-gray-700">
              <div class="flex items-center gap-2">
                <span class="select-all" v-if="visiblePasswordId === acc.id">{{ acc.password }}</span>
                <span v-else>●●●●●●●●</span>
                <button
                  @click.stop="toggleShowPassword(acc.id)"
                  class="text-sm text-sky-600 hover:underline"
                  title="Show / hide password"
                >
                  {{ visiblePasswordId === acc.id ? "Hide" : "Show" }}
                </button>
              </div>
            </td>

            <td class="px-4 py-3 text-sm text-gray-700">
              <div>
                <div class="font-semibold">{{ acc.createdBy || "-" }}</div>
                <div class="text-xs text-gray-500">{{ formatDate(acc.createdAt) }}</div>
              </div>
            </td>

            <td class="px-4 py-3 text-sm text-gray-700">
              <div>
                <div class="font-semibold">{{ acc.updatedBy || "-" }}</div>
                <div class="text-xs text-gray-500">{{ formatDate(acc.updatedAt) }}</div>
              </div>
            </td>

            <td class="px-4 py-3 text-sm text-gray-700">
              <div class="flex gap-2">
                <button
                  @click.stop="openEdit(acc)"
                  class="px-3 py-1 bg-amber-500 hover:bg-amber-600 text-white rounded"
                >
                  Edit
                </button>
                <button
                  @click.stop="confirmDelete(acc)"
                  class="px-3 py-1 bg-red-600 hover:bg-red-700 text-white rounded"
                >
                  Delete
                </button>
                <button
                  v-if="acc.url"
                  @click.stop="openPortal(acc.url)"
                  class="px-3 py-1 bg-sky-600 hover:bg-sky-700 text-white rounded"
                >
                  Open
                </button>
              </div>
            </td>
          </tr>

          <tr v-if="filteredAccounts.length === 0">
            <td colspan="7" class="px-4 py-6 text-center text-gray-500">No accounts found.</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal Create/Edit -->
    <transition name="fade">
      <div
        v-if="showModal"
        class="fixed inset-0 flex items-center justify-center bg-black/30 z-50 p-4"
      >
        <div class="bg-white rounded-xl max-w-xl w-full p-6 shadow-lg border">
          <h3 class="text-lg font-semibold mb-4">{{ editMode ? "Edit Account" : "Create Account" }}</h3>

          <div class="grid grid-cols-1 gap-3">
            <label class="text-sm">Portal (name)</label>
            <input v-model="form.portal" type="text" class="w-full p-2 border rounded" placeholder="PT Example" />

            <label class="text-sm">Portal URL (optional)</label>
            <input v-model="form.url" type="url" class="w-full p-2 border rounded" placeholder="https://..." />

            <label class="text-sm">Username</label>
            <input v-model="form.username" type="text" class="w-full p-2 border rounded" />

            <label class="text-sm">Password</label>
            <div class="relative">
              <input
                :type="formShowPassword ? 'text' : 'password'"
                v-model="form.password"
                class="w-full p-2 border rounded pr-28"
              />
              <button
                type="button"
                @click="formShowPassword = !formShowPassword"
                class="absolute right-2 top-1/2 -translate-y-1/2 bg-gray-100 hover:bg-gray-200 px-3 py-1 rounded"
              >
                {{ formShowPassword ? "Hide" : "Show" }}
              </button>
            </div>

            <div class="flex gap-2 items-center mt-2">
              <label class="text-sm">Created By:</label>
              <div class="text-sm text-gray-600">{{ editMode ? (form.createdBy || "-") : currentEditor }}</div>
            </div>

            <div class="flex gap-2 mt-4">
              <button @click="save()" class="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white rounded">
                {{ editMode ? "Update" : "Create" }}
              </button>
              <button @click="closeModal()" class="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded">
                Cancel
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- Delete Confirm -->
    <transition name="fade">
      <div v-if="deleteTarget" class="fixed inset-0 flex items-center justify-center bg-black/30 z-50 p-4">
        <div class="bg-white rounded-lg p-6 shadow">
          <h4 class="font-semibold mb-4">Delete account</h4>
          <p class="text-sm text-gray-700 mb-4">Are you sure you want to delete <strong>{{ deleteTarget.portal }}</strong>?</p>
          <div class="flex gap-3">
            <button @click="doDelete()" class="px-4 py-2 bg-red-600 text-white rounded">Yes, delete</button>
            <button @click="cancelDelete()" class="px-4 py-2 bg-gray-300 rounded">Cancel</button>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue"

// localStorage key
const STORAGE_KEY = "portalAccounts_v1"

// form + UI states
const accounts = ref([])
const q = ref("")
const showModal = ref(false)
const editMode = ref(false)
const form = ref({
  id: null,
  portal: "",
  url: "",
  username: "",
  password: "",
  createdBy: null,
  createdAt: null,
  updatedBy: null,
  updatedAt: null
})
const formShowPassword = ref(false)
const visiblePasswordId = ref(null)
const deleteTarget = ref(null)

// helper: get current editor name from localStorage (newUser / authUser / fallback Admin)
function currentEditorName() {
  try {
    const raw = localStorage.getItem("newUser") || localStorage.getItem("authUser") || localStorage.getItem("user")
    if (raw) {
      const parsed = JSON.parse(raw)
      // if stored as object with nama field
      if (parsed && parsed.nama) return parsed.nama
      // if stored as simple username string:
      if (typeof parsed === "string") return parsed
    }
  } catch (e) { /* ignore */ }
  // fallback to stored simple keys
  const simple = localStorage.getItem("currentUsername") || localStorage.getItem("username")
  if (simple) return simple
  return "Admin"
}

const currentEditor = currentEditorName()

// load / save
function loadAccounts() {
  const raw = localStorage.getItem(STORAGE_KEY)
  if (!raw) {
    // initialize with empty or sample data
    accounts.value = []
    saveAccounts()
    return
  }
  try {
    accounts.value = JSON.parse(raw) || []
  } catch (e) {
    accounts.value = []
  }
}

function saveAccounts() {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(accounts.value))
}

// utility
function uid() {
  return Date.now().toString(36) + Math.random().toString(36).slice(2, 8)
}

function formatDate(iso) {
  if (!iso) return "-"
  try {
    const d = new Date(iso)
    return d.toLocaleString()
  } catch (e) {
    return iso
  }
}

// computed filtered list
const filteredAccounts = computed(() => {
  const qv = q.value.trim().toLowerCase()
  if (!qv) return accounts.value
  return accounts.value.filter(a =>
    (a.portal || "").toLowerCase().includes(qv) ||
    (a.username || "").toLowerCase().includes(qv) ||
    (a.url || "").toLowerCase().includes(qv)
  )
})

// CRUD handlers
function openCreate() {
  editMode.value = false
  form.value = {
    id: null,
    portal: "",
    url: "",
    username: "",
    password: "",
    createdBy: null,
    createdAt: null,
    updatedBy: null,
    updatedAt: null
  }
  formShowPassword.value = false
  showModal.value = true
}

function openEdit(acc) {
  editMode.value = true
  // clone object to avoid two-way binding issues
  form.value = { ...acc }
  formShowPassword.value = false
  showModal.value = true
}

function closeModal() {
  showModal.value = false
}

function save() {
  // validation
  if (!form.value.portal || !form.value.username) {
    alert("Portal name and username are required.")
    return
  }

  const now = new Date().toISOString()
  const editor = currentEditorName()

  if (editMode.value && form.value.id) {
    // update
    const i = accounts.value.findIndex(x => x.id === form.value.id)
    if (i !== -1) {
      accounts.value[i] = {
        ...accounts.value[i],
        portal: form.value.portal,
        url: form.value.url || "",
        username: form.value.username,
        password: form.value.password,
        updatedBy: editor,
        updatedAt: now
      }
      saveAccounts()
      closeModal()
      return
    } else {
      alert("Record not found.")
      return
    }
  }

  // create
  const newItem = {
    id: uid(),
    portal: form.value.portal,
    url: form.value.url || "",
    username: form.value.username,
    password: form.value.password,
    createdBy: editor,
    createdAt: now,
    updatedBy: null,
    updatedAt: null
  }
  accounts.value.unshift(newItem)
  saveAccounts()
  closeModal()
}

// delete flow
function confirmDelete(acc) {
  deleteTarget.value = acc
}

function cancelDelete() {
  deleteTarget.value = null
}

function doDelete() {
  if (!deleteTarget.value) return
  accounts.value = accounts.value.filter(x => x.id !== deleteTarget.value.id)
  saveAccounts()
  deleteTarget.value = null
}

// open portal url
function openPortal(url) {
  if (!url) return
  window.open(url, "_blank")
}

// toggle password visibility per row
function toggleShowPassword(id) {
  visiblePasswordId.value = visiblePasswordId.value === id ? null : id
}

// lifecycle
onMounted(() => {
  loadAccounts()
})
</script>

<style scoped>
/* small fade for modals */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
