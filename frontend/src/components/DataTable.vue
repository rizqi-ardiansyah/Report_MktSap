<template>
  <div class="a4-page">
    <!-- Report Header -->
    <div class="report-header">
      <div class="logo">
        <!-- replace with your logo path in /public -->
        <img src="../assets/logo.png" alt="Company Logo" />
      </div>
      <div class="header-info">
        <p><strong>TITLE</strong> : BUDGET PEMBELIAN MATERIAL & CKD SEPTEMBER 2025</p>
        <p><strong>PROJECT</strong> : SU2ID & KS</p>
        <p><strong>CUSTOMER</strong> : PT HMMI</p>
      </div>
      <div class="rev-date">
        <p><strong>REV.</strong> 00</p>
        <p>24 September 2025</p>
      </div>
    </div>


    <!-- <h2 class="text-xl font-bold mb-2">Data Budget</h2> -->
    <table class="report-table" border="1" id="budget-table">
      <thead>
        <tr>
          <th style="background-color: white;" colspan="23"></th>
          <th style="background-color: white;">22 Sep 2025</th>
        </tr>
        <tr>
          <th rowspan="4" style="width:10px; text-align:center;">No</th>
          <th rowspan="4">Model</th>
          <th rowspan="4" colspan="2">Material/CKD</th>
          <th rowspan="4">Σ Item V <br>to V / <br>Gpart</th>
          <!-- Bulan -->
          <th colspan="19" style="font-size: 14px; font-weight: bold;">Budget Material & CKD</th>
        </tr>
        <tr>
          <th colspan="3">Aug-25</th>
          <th colspan="3">Aug-25</th>
          <th rowspan="3">Diff</th>
          <th colspan="3">Sep-25</th>
          <th colspan="3">Oct-25</th>
          <th colspan="3">Nov-25</th>
          <th colspan="3">Dec-25</th>
        </tr>
        <tr>
          <th colspan="3">Forecast</th>
          <th colspan="3">Actual</th>
          <th colspan="3">Forecast</th>
          <th colspan="3">Forecast</th>
          <th colspan="3">Forecast</th>
          <th colspan="3">Forecast</th>
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
            <td>{{ formatNumber(row.n0_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n0_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n0_amount_forecast) }}</td>
            <td>{{ formatNumber(row.n0_pcs_act) }}</td>
            <td>{{ formatNumber(row.n0_kg_act) }}</td>
            <td>{{ formatNumber(row.n0_amount_act) }}</td>
            <td>{{ formatNumber(row.difference) }}</td>
            <td>{{ formatNumber(row.n_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n_amount_forecast) }}</td>
            <td>{{ formatNumber(row.n1_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n1_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n1_amount_forecast)}}</td>
            <td>{{ formatNumber(row.n2_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n2_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n2_amount_forecast) }}</td>
            <td>{{ formatNumber(row.n3_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n3_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n3_amount_forecast) }}</td>
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

              <!-- Baris CKD PCS -->
              <td>PCS</td>

              <!-- Merge kolom CKD PCS dan Transport -->
              <td :rowspan="2">{{ sumCKD(row.nokol, row.model, 'n0_pcs_forecast') }}</td>

              <td v-if="isSameCKD(row.nokol, row.model, 'n0_kg_forecast')" :rowspan="2">
                {{ formatNumber(row.n0_kg_forecast) }}
              </td>
              <td v-else>
                {{ formatNumber(row.n0_kg_forecast) }}
              </td>
              <td>
                {{ formatNumber(row.n0_amount_forecast) }}
              </td>


              <td :rowspan="2">{{ sumCKD(row.nokol, row.model, 'n0_pcs_act') }}</td>

              <td v-if="isSameCKD(row.nokol, row.model, 'n0_kg_act')" :rowspan="2">
                {{ formatNumber(row.n0_kg_act) }}
              </td>
              <td v-else>
                {{ formatNumber(row.n0_kg_act)}}
              </td>
              <td>
                {{ formatNumber(row.n0_amount_act) }}
              </td>

              <td>{{ formatNumber(row.difference) }}</td>


              <td :rowspan="2">{{ sumCKD(row.nokol, row.model, 'n_pcs_forecast') }}</td>

              <td v-if="isSameCKD(row.nokol, row.model, 'n_kg_forecast')" :rowspan="2">
                {{formatNumber( row.n_kg_forecast) }}
              </td>
              <td v-else>
                {{formatNumber( row.n_kg_forecast) }}
              </td>
              <td>
                {{ formatNumber(row.n_amount_forecast) }}
              </td>

              <td :rowspan="2">{{ sumCKD(row.nokol, row.model, 'n1_pcs_forecast') }}</td>

              <td v-if="isSameCKD(row.nokol, row.model, 'n1_kg_forecast')" :rowspan="2">
                {{ formatNumber(row.n1_kg_forecast) }}
              </td>
              <td v-else>
                {{ formatNumber(row.n1_kg_forecast) }}
              </td>
              <td>
                {{ formatNumber(row.n1_amount_forecast) }}
              </td>

              <td :rowspan="2">{{ sumCKD(row.nokol, row.model, 'n2_pcs_forecast') }}</td>

              <td v-if="isSameCKD(row.nokol, row.model, 'n2_kg_forecast')" :rowspan="2">
                {{ formatNumber(row.n2_kg_forecast) }}
              </td>
              <td v-else>
                {{ formatNumber(row.n2_kg_forecast) }}
              </td>
              <td>
                {{ formatNumber(row.n2_amount_forecast) }}
              </td>

              <td :rowspan="2">{{ sumCKD(row.nokol, row.model, 'n3_pcs_forecast') }}</td>

              <td v-if="isSameCKD(row.nokol, row.model, 'n3_kg_forecast')" :rowspan="2">
                {{ formatNumber(row.n3_kg_forecast) }}
              </td>
              <td v-else>
                {{ formatNumber(row.n3_kg_forecast) }}
              </td>
              <td>
                {{ formatNumber(row.n3_amount_forecast) }}
              </td>
            </tr>
          </template>
          <template v-else-if="row.name === 'CKD Transport'">
            <!-- Baris CKD - Transport -->
            <tr>
              <td>Transport</td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_kg_forecast')">
                {{ formatNumber(row.n0_kg_forecast) }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_amount_forecast')">
                {{ formatNumber(row.n0_amount_forecast) }}
              </td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_kg_act')">
                {{ formatNumber(row.n0_kg_act) }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n0_amount_act')">
                {{ formatNumber(row.n0_amount_act_) }}
              </td>

              <td>{{ row.difference }}</td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n_kg_forecast')">
                {{ formatNumber(row.n_kg_forecast) }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n_amount_forecast')">
                {{ formatNumber(row.n_amount_forecast) }}
              </td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n1_kg_forecast')">
                {{ formatNumber(row.n1_kg_forecast)}}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n1_amount_forecast')">
                {{ formatNumber(row.n1_amount_forecast) }}
              </td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n2_kg_forecast')">
                {{ formatNumber(row.n2_kg_forecast) }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n2_amount_forecast')">
                {{ formatNumber(row.n2_amount_forecast) }}
              </td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n3_kg_forecast')">
                {{ formatNumber(row.n3_kg_forecast) }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n3_amount_forecast')">
                {{ formatNumber(row.n3_amount_forecast) }}
              </td>

            </tr>
          </template>
        </template>
        <tr>
          <td colspan="4">Total</td>
          <td>{{ totalColumns.total_item }}</td>
          <td>{{ totalColumns.n0_pcs_forecast }}</td>
          <td>{{ totalColumns.n0_kg_forecast }}</td>
          <td>{{ totalColumns.n0_amount_forecast }}</td>
          <td>{{ totalColumns.n0_pcs_act }}</td>
          <td>{{ totalColumns.n0_kg_act }}</td>
          <td>{{ totalColumns.n0_amount_act }}</td>
          <td>{{ formatNumber(totalDiff)}}</td> <!-- kolom Diff bisa dikosongi atau hitung sendiri -->
          <td>{{ totalColumns.n_pcs_forecast }}</td>
          <td>{{ totalColumns.n_kg_forecast }}</td>
          <td>{{ totalColumns.n_amount_forecast }}</td>
          <td>{{ totalColumns.n1_pcs_forecast }}</td>
          <td>{{ totalColumns.n1_kg_forecast }}</td>
          <td>{{ totalColumns.n1_amount_forecast }}</td>
          <td>{{ totalColumns.n2_pcs_forecast }}</td>
          <td>{{ totalColumns.n2_kg_forecast }}</td>
          <td>{{ totalColumns.n2_amount_forecast }}</td>
          <td>{{ totalColumns.n3_pcs_forecast }}</td>
          <td>{{ totalColumns.n3_kg_forecast }}</td>
          <td>{{ totalColumns.n3_amount_forecast }}</td>
        </tr>
      </tbody>
    </table>
      <br><br>
     <button @click="exportExcel" class="mb-4 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">
      Download Excel
    </button><br><br>
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
    sumCKD(no, model, field) {
      const group = this.budget_mat.filter(
        r => r.nokol === no && r.model === model && (r.name === "CKD PCS" || r.name === "CKD Transport")
      );

      // jumlahkan field dari PCS + Transport
      return group.reduce((total, r) => {
        return total + (parseFloat(r[field]) || 0);
      }, 0);
    },

    formatNumber(value) {
      if (value == null || value === "") return "";
      const num = Number(value);
      return num.toFixed(3).replace(/\.?0+$/, "");
    },
    sumMaterial(row) {
      const pcs = parseFloat(row.total_item) || 0;
      const transport = parseFloat(row.total_item) || 0;
      return this.formatNumber(pcs + transport);
    },
    exportExcel() {
      const table = document.getElementById("budget-table");
      const wb = XLSX.utils.table_to_book(table, { sheet: "Budget" });

      // langsung download
      XLSX.writeFile(wb, "budget.xlsx");
    }
  },

  computed: {
    totalColumns() {
      const totals = {
        total_item: 0,
        n0_pcs_forecast: 0,
        n0_kg_forecast: 0,
        n0_amount_forecast: 0,
        n0_pcs_act: 0,
        n0_kg_act: 0,
        n0_amount_act: 0,
        n_pcs_forecast: 0,
        n_kg_forecast: 0,
        n_amount_forecast: 0,
        n1_pcs_forecast: 0,
        n1_kg_forecast: 0,
        n1_amount_forecast: 0,
        n2_pcs_forecast: 0,
        n2_kg_forecast: 0,
        n2_amount_forecast: 0,
        n3_pcs_forecast: 0,
        n3_kg_forecast: 0,
        n3_amount_forecast: 0
      };

      this.budget_mat.forEach(row => {
        for (let key in totals) {
          totals[key] += parseFloat(row[key]) || 0;
        }
      });

      for (let key in totals) {
      totals[key] = Math.round(totals[key]); // bisa ganti ke Math.floor / Math.ceil sesuai kebutuhan
    }
      return totals;
    },

    totalDiff(){
      const {n0_amount_act, n0_amount_forecast} = this.totalColumns;

      if(!n0_amount_forecast){
        return 0;
      }

      return (n0_amount_act-n0_amount_forecast)/n0_amount_act;
    }
  }

};
</script>
