<template>
  <div class="download-container">
    <button @click="downloadExcel" class="btn-download">📥 Download Excel</button>
  </div>
</template>

<script>
import presenter from '../presenters/downloadPresenter'

export default {
  name: 'DownloadButton',
  methods: {
    async downloadExcel() {
      await presenter.handleDownload()
    },
  },
}
</script>

<style scoped>
.download-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 200px; /* biar keliatan ada ruang */
  background: linear-gradient(135deg, #4facfe 0%, #00ca76 100%);
  border-radius: 12px;
  padding: 20px;
}

.btn-download {
  background-color: #ffffff;
  border: none;
  border-radius: 8px;
  padding: 12px 20px;
  font-size: 16px;
  font-weight: bold;
  color: #333;
  cursor: pointer;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.btn-download:hover {
  background-color: #f0f0f0;
  transform: scale(1.05);
}
</style>
