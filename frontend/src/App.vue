<template>
  <!-- <div id="app"> -->
    <!-- <h2>Download Data SAP</h2>
    <DownloadButton /> -->
    <DataTable />
  <!-- </div> -->
</template>

<!-- <script>
import DownloadButton from './views/DownloadButton.vue'

export default {
  components: {
    DownloadButton,
  },
}
</script> -->

<script>
import DataTable from "./components/DataTable.vue";

export default {
  name: "App",
  components: {
    DataTable
  }
};
</script>
