<template>
  <div class="p-4">
    <button @click="exportExcel"
      class="mb-4 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">
      Download Excel
    </button><br><br>
    <!-- <h2 class="text-xl font-bold mb-2">Data Budget</h2> -->
    <table border="1" cellpadding="6" id="budget-table">
      <thead>
        <tr>
          <th rowspan="3">No</th>
          <th rowspan="3">Model</th>
          <th rowspan="3" colspan="2">Material/CKD</th>
          <th rowspan="3">Σ Item</th>
          <!-- Bulan -->
          <th colspan="20">Budget Material & CKD</th>
        </tr>
        <tr>
          <th colspan="3">Aug-25 (Forecast)</th>
          <th colspan="3">Aug-25 (Actual)</th>
          <th rowspan="2">Diff</th>
          <th colspan="3">Sep-25 (Forecast)</th>
          <th colspan="3">Oct-25 (Forecast)</th>
          <th colspan="3">Nov-25 (Forecast)</th>
          <th colspan="3">Dec-25 (Forecast)</th>
        </tr>
        <tr>
          <!-- Sub kolom -->
          <th>PCS</th>
          <th>KG</th>
          <th>Amount</th>
          <th>PCS</th>
          <th>KG</th>
          <th>Amount</th>
          <th>PCS</th>
          <th>KG</th>
          <th>Amount</th>
          <th>PCS</th>
          <th>KG</th>
          <th>Amount</th>
          <th>PCS</th>
          <th>KG</th>
          <th>Amount</th>
          <th>PCS</th>
          <th>KG</th>
          <th>Amount</th>
        </tr>
      </thead>
       <tbody>
        <template v-for="(row, index) in budget_mat" :key="row.id">
          <!-- Jika Material biasa -->
          <tr v-if="row.name === 'Material'">
            <td v-if="shouldShowNo(index)" :rowspan="rowspanNo(row.nokol)">
              {{ row.nokol }}
            </td>
            <td v-if="shouldShowModel(index)" :rowspan="rowspanModel(row.nokol, row.model)">
              {{ row.model }}
            </td>
            <td colspan="2">Material</td>
            <!-- Σ Item (merge) -->
            <td v-if="shouldShowTotalItem(index)" :rowspan="3">
              {{ row.total_item }}
            </td>
            <!-- <td>{{ row.total_item }}</td> -->
            <td>{{ row.n0_pcs_forecast }}</td>
            <td>{{ row.n0_kg_forecast }}</td>
            <td>{{ row.n0_amount_forecast }}</td>
            <td>{{ row.n0_pcs_act }}</td>
            <td>{{ row.n0_kg_act }}</td>
            <td>{{ row.n0_amount_act }}</td>
            <td>{{ row.difference }}</td>
            <td>{{ row.n_pcs_forecast }}</td>
            <td>{{ row.n_kg_forecast }}</td>
            <td>{{ row.n_amount_forecast }}</td>
            <td>{{ row.n1_pcs_forecast }}</td>
            <td>{{ row.n1_kg_forecast }}</td>
            <td>{{ row.n1_amount_forecast }}</td>
            <td>{{ row.n2_pcs_forecast }}</td>
            <td>{{ row.n2_kg_forecast }}</td>
            <td>{{ row.n2_amount_forecast }}</td>
            <td>{{ row.n3_pcs_forecast }}</td>
            <td>{{ row.n3_kg_forecast }}</td>
            <td>{{ row.n3_amount_forecast }}</td>
          </tr>

          <!-- Jika CKD → buat 2 baris -->
          <template v-else-if="row.name === 'CKD PCS'">
            <!-- Baris CKD - PCS -->
             <tr>
              <td v-if="shouldShowNo(index)" :rowspan="2">
                {{ row.nokol }}
              </td>
              <td v-if="shouldShowModel(index)" :rowspan="2">
                {{ row.model }}
              </td>
              <td rowspan="2">CKD</td>
              <td>PCS</td>
              <!-- <td>{{ row.total_item }}</td> -->
              <td v-if="isSameCKD(row.nokol, row.model, 'n0_pcs_forecast')" :rowspan="2">
                {{ row.n0_pcs_forecast }}
              </td>
              <td v-else>
                {{ row.n0_pcs_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n0_kg_forecast')" :rowspan="2">
                {{ row.n0_kg_forecast }}
              </td>
              <td v-else>
                {{ row.n0_kg_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n0_amount_forecast')" :rowspan="2">
                {{ row.n0_amount_forecast }}
              </td>
              <td v-else>
                {{ row.n0_amount_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n0_pcs_act')" :rowspan="2">
                {{ row.n0_pcs_act}}
              </td>
              <td v-else>
                {{ row.n0_pcs_act }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n0_kg_act')" :rowspan="2">
                {{ row.n0_kg_act}}
              </td>
              <td v-else>
                {{ row.n0_kg_act }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n0_amount_act')" :rowspan="2">
                {{ row.n0_amount_act }}
              </td>
              <td v-else>
                {{ row.n0_amount_act }}
              </td>
              <!-- <td>{{ row.n0_pcs_forecast }}</td> -->
              <!-- <td>{{ row.n0_kg_forecast }}</td> -->
              <!-- <td>{{ row.n0_amount_forecast }}</td> -->
              <!-- <td>{{ row.n0_pcs_act }}</td>
              <td>{{ row.n0_kg_act }}</td>
              <td>{{ row.n0_amount_act }}</td> -->
              <td>{{ row.difference }}</td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n_pcs_forecast')" :rowspan="2">
                {{ row.n_pcs_forecast}}
              </td>
              <td v-else>
                {{ row.n_pcs_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n_kg_forecast')" :rowspan="2">
                {{ row.n_kg_forecast}}
              </td>
              <td v-else>
                {{ row.n_kg_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n_amount_forecast')" :rowspan="2">
                {{ row.n_amount_forecast }}
              </td>
              <td v-else>
                {{ row.n_amount_forecast }}
              </td>
              <!-- <td>{{ row.n_pcs_forecast }}</td>
              <td>{{ row.n_kg_forecast }}</td>
              <td>{{ row.n_amount_forecast }}</td> -->
              <td v-if="isSameCKD(row.nokol, row.model, 'n1_pcs_forecast')" :rowspan="2">
                {{ row.n1_pcs_forecast}}
              </td>
              <td v-else>
                {{ row.n1_pcs_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n1_kg_forecast')" :rowspan="2">
                {{ row.n1_kg_forecast}}
              </td>
              <td v-else>
                {{ row.n1_kg_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n1_amount_forecast')" :rowspan="2">
                {{ row.n1_amount_forecast }}
              </td>
              <td v-else>
                {{ row.n1_amount_forecast}}
              </td>
              <!-- <td>{{ row.n1_pcs_forecast }}</td>
              <td>{{ row.n1_kg_forecast }}</td>
              <td>{{ row.n1_amount_forecast }}</td> -->
              <td v-if="isSameCKD(row.nokol, row.model, 'n2_pcs_forecast')" :rowspan="2">
                {{ row.n2_pcs_forecast}}
              </td>
              <td v-else>
                {{ row.n2_pcs_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n2_kg_forecast')" :rowspan="2">
                {{ row.n2_kg_forecast}}
              </td>
              <td v-else>
                {{ row.n2_kg_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n2_amount_forecast')" :rowspan="2">
                {{ row.n2_amount_forecast }}
              </td>
              <td v-else>
                {{ row.n2_amount_forecast}}
              </td>
              <!-- <td>{{ row.n2_pcs_forecast }}</td>
              <td>{{ row.n2_kg_forecast }}</td>
              <td>{{ row.n2_amount_forecast }}</td> -->
              <td v-if="isSameCKD(row.nokol, row.model, 'n3_pcs_forecast')" :rowspan="2">
                {{ row.n3_pcs_forecast}}
              </td>
              <td v-else>
                {{ row.n3_pcs_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n3_kg_forecast')" :rowspan="2">
                {{ row.n3_kg_forecast}}
              </td>
              <td v-else>
                {{ row.n3_kg_forecast }}
              </td>
              <td v-if="isSameCKD(row.nokol, row.model, 'n3_amount_forecast')" :rowspan="2">
                {{ row.n3_amount_forecast }}
              </td>
              <td v-else>
                {{ row.n3_amount_forecast}}
              </td>
              <!-- <td>{{ row.n3_pcs_forecast }}</td>
              <td>{{ row.n3_kg_forecast }}</td>
              <td>{{ row.n3_amount_forecast }}</td> -->
            </tr>
          </template>
          <template v-else-if="row.name === 'CKD Transport'">
            <!-- Baris CKD - Transport -->
            <tr>
              <td>Transport</td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_pcs_forecast')">
                {{ row.n0_pcs_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_kg_forecast')">
                {{ row.n0_kg_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_amount_forecast')">
                {{ row.n0_amount_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_pcs_act')">
                {{ row.n0_pcs_act }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_kg_act')">
                {{ row.n0_kg_act }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_amount_act')">
                {{ row.n0_amount_act}}
              </td>
              <td>{{ row.difference }}</td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n_pcs_forecast')">
                {{ row.n_pcs_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n_kg_forecast')">
                {{ row.n_kg_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n_amount_forecast')">
                {{ row.n_amount_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n1_pcs_forecast')">
                {{ row.n1_pcs_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n1_kg_forecast')">
                {{ row.n1_kg_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n1_amount_forecast')">
                {{ row.n1_amount_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n2_pcs_forecast')">
                {{ row.n2_pcs_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n2_kg_forecast')">
                {{ row.n2_kg_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n2_amount_forecast')">
                {{ row.n2_amount_forecast }}
              </td>
               <td v-if="!isSameCKD(row.nokol, row.model, 'n3_pcs_forecast')">
                {{ row.n3_pcs_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n3_kg_forecast')">
                {{ row.n3_kg_forecast }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n3_amount_forecast')">
                {{ row.n3_amount_forecast }}
              </td>

            </tr>
          </template>

        </template>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";
import * as XLSX from "xlsx";

export default {
  data() {
    return {
      budget_mat: []
    };
  },
  mounted() {
    axios.get("http://localhost:5000/api/data").then(res => {
      this.budget_mat = res.data;
    });
  },

  methods: {
    // hitung rowspan untuk No
    rowspanNo(no) {
      return this.budget_mat.filter(r => r.nokol === no).length;
    },
    // hitung rowspan untuk Model dalam 1 No
    rowspanModel(no, model) {
      return this.budget_mat.filter(r => r.nokol === no && r.model === model).length;
    },
    // tampilkan No hanya di baris pertama dari group
    shouldShowNo(index) {
      if (index === 0) return true;
      return this.budget_mat[index].nokol !== this.budget_mat[index - 1].nokol;
    },
    // tampilkan Model hanya di baris pertama dari group
    shouldShowModel(index) {
      if (index === 0) return true;
      return this.budget_mat[index].model !== this.budget_mat[index - 1].model;
    },
    shouldShowTotalItem(index) {
    if (index === 0) return true;
    return this.budget_mat[index].total_item !== this.budget_mat[index - 1].total_item;
    },
    isSameCKD(no, model, field) {
    const group = this.budget_mat.filter(r => r.nokol === no && r.model === model && (r.name === "CKD PCS" || r.name === "CKD Transport"));
    if (group.length === 2) {
      return group[0][field] === group[1][field];
    }
    return false;
    },
    exportExcel() {
      const table = document.getElementById("budget-table");
      const wb = XLSX.utils.table_to_book(table, { sheet: "Budget" });

      // langsung download
      XLSX.writeFile(wb, "budget.xlsx");
    }
  }
};
</script>
