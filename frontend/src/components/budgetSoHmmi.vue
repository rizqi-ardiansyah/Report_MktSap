<style scoped>
.rev {
  margin-top: 45px;
}

.report-container {
  height: 780px;
  ;
  width: 100%;
}

.report-table {
  margin-top: 15px;
  font-size: 11px;
}
</style>

<template>
  <!-- Filter control outside A4 page -->
    <div class="filter-bar">
    <label for="month">Choose Start Month:</label>
    <input type="month" id="month" v-model="selectedMonth" @change="applyFilter" />

    <label for="reportType">Report Type:</label>
    <select id="reportType" v-model="selectedReportType" @change="applyFilter">
      <option value="Original">Original</option>
      <option value="">Balancing</option>
    </select>

    <label for="version">Version:</label>
    <select id="version" v-model="selectedVersion" @change="applyFilter">
      <option value="00">00</option>
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
    </select>
  </div>

  <div id="printArea" class="a4-page">
    <!-- For Make Border -->
    <div class="report-container">
      <!-- Report Header -->
      <div class="report-header">
        <div class="logo">
          <!-- replace with your logo path in /public -->
          <img src="../assets/logo.png" alt="Company Logo" />
        </div>
        <div class="header-info">
          <div class="row">
            <span class="label bold">TITLE</span>
            <span class="value bold" contenteditable="true">: BUDGET PEMBELIAN MATERIAL & CKD VS SALES ORDER SEPTEMBER
              2025</span>
          </div>
          <div class="row">
            <span class="label bold">PROJECT</span>
            <span class="value bold" contenteditable="true">: SU2ID & KS</span>
          </div>
          <div class="row">
            <span class="label bold">CUSTOMER</span>
            <span class="value bold" contenteditable="true">: PT HMMI</span>
          </div>
        </div>
        <div class="rev" id="rev">
          <p style="font-weight: bold;" contenteditable="true">{{ selectedReportType }} REV. {{ selectedVersion }}</p>
        </div>
      </div>

      <!-- Layout Main Table -->
      <table class="report-table" id="budget-table">
        <thead>
          <!-- <tr>
              <th style="background-color: white; border: none;" colspan="17"></th>
              <th colspan="3" style="background-color: white; font-style: italic;">{{ formattedDate }}</th>
            </tr> -->
          <tr>
            <th rowspan="4" style="width:10px; text-align:center;">No</th>
            <th rowspan="4">Model</th>
            <th rowspan="4" colspan="2">Material / CKD</th>
            <th rowspan="4">Σ Item <br> V to V / <br>Gpart</th>
            <!-- Bulan -->
            <th colspan="15" style="font-size: 13px; font-weight: bold;">BUDGET MATERIAL & CKD VS SO</th>
          </tr>
          <tr>
            <th colspan="3">Aug-25</th>
            <th colspan="3">Sep-25</th>
            <th colspan="3">Oct-25</th>
            <th colspan="3">Nov-25</th>
            <th colspan="3">Dec-25</th>
          </tr>
          <tr>
            <th colspan="3">ACTUAL</th>
            <th colspan="12">FORECAST</th>
          </tr>
          <tr class="thAct">
            <!-- Sub kolom -->
            <th>Amount <br> Mats <br> (x1000)</th>
            <th>Amount Sales <br> SO (x1000)</th>
            <th>% <br> Material <br>/ Sales</th>
            <th>Amount <br> Mats <br> (x1000)</th>
            <th>Amount Sales <br> SO (x1000)</th>
            <th>% <br> Material <br>/ Sales</th>
            <th>Amount <br> Mats <br> (x1000)</th>
            <th>Amount Sales <br> SO (x1000)</th>
            <th>% <br> Material <br>/ Sales</th>
            <th>Amount <br> Mats <br> (x1000)</th>
            <th>Amount Sales <br> SO (x1000)</th>
            <th>% <br> Material <br>/ Sales</th>
            <th>Amount <br> Mats <br> (x1000)</th>
            <th>Amount Sales <br> SO (x1000)</th>
            <th>% <br> Material <br>/ Sales</th>
          </tr>
        </thead>
        <tbody>
          <template v-for="(row, index) in budget_mat" :key="row.id">
            <!-- Jika Material biasa -->
            <tr v-if="row.name === 'Material'">
              <td v-if="shouldShowNo(index)" :rowspan="rowspanNo(row.nokol)" class="bold">
                {{ row.nokol }}
              </td>
              <td v-if="shouldShowModel(index)" :rowspan="rowspanModel(row.nokol, row.model)" class="bold">
                {{ row.model }}
              </td>
              <td colspan="2" class="bold">Material</td>
              <!-- Σ Item (merge) -->
              <td v-if="shouldShowTotalItem(index)" :rowspan="3">
                {{ row.total_item }}
              </td>
              <td>{{ formatNumber(row.n0_amount_act) }}</td>
              <td rowspan="3">{{ formatNumber(row.n0_amountSales) }}</td>
              <td>{{ percentageMaterial(row, "n0_amount_act", "n0_amountSales") }}</td>

              <td>{{ formatNumber(row.n_amount_forecast) }}</td>
              <td rowspan="3">{{ formatNumber(row.n_amountSales) }}</td>
              <td>{{ percentageMaterial(row, "n_amount_forecast", "n_amountSales") }}</td>

              <td>{{ formatNumber(row.n1_amount_forecast) }}</td>
              <td rowspan="3">{{ formatNumber(row.n1_amountSales) }}</td>
              <td>{{ percentageMaterial(row, "n1_amount_forecast", "n1_amountSales") }}</td>

              <td>{{ formatNumber(row.n2_amount_forecast) }}</td>
              <td rowspan="3">{{ formatNumber(row.n2_amountSales) }}</td>
              <td>{{ percentageMaterial(row, "n2_amount_forecast", "n2_amountSales") }}</td>

              <td>{{ formatNumber(row.n3_amount_forecast) }}</td>
              <td rowspan="3">{{ formatNumber(row.n3_amountSales) }}</td>
              <td>{{ percentageMaterial(row, "n3_amount_forecast", "n3_amountSales") }}</td>
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
                <td rowspan="2" class="bold">CKD</td>

                <!-- Baris CKD PCS -->
                <td class="bold">PCS</td>

                <!-- Merge kolom CKD PCS dan Transport -->
                <td :rowspan="2">{{ formatNumber(sumCKD(row.nokol, row.model, 'n0_amount_act')) }}</td>
                <td :rowspan="2">{{ percentageCKD(row.nokol, row.model, 'n0_amount_act', 'n0_amountSales') }}</td>

                <td :rowspan="2">{{ formatNumber(sumCKD(row.nokol, row.model, 'n_amount_forecast')) }}</td>
                <td :rowspan="2">{{ percentageCKD(row.nokol, row.model, 'n_amount_forecast', 'n_amountSales') }}</td>

                <td :rowspan="2">{{ formatNumber(sumCKD(row.nokol, row.model, 'n1_amount_forecast')) }}</td>
                <td :rowspan="2">{{ percentageCKD(row.nokol, row.model, 'n1_amount_forecast', 'n1_amountSales') }}</td>

                <td :rowspan="2">{{ formatNumber(sumCKD(row.nokol, row.model, 'n2_amount_forecast')) }}</td>
                <td :rowspan="2">{{ percentageCKD(row.nokol, row.model, 'n2_amount_forecast', 'n2_amountSales') }}</td>

                <td :rowspan="2">{{ formatNumber(sumCKD(row.nokol, row.model, 'n3_amount_forecast')) }}</td>
                <td :rowspan="2">{{ percentageCKD(row.nokol, row.model, 'n3_amount_forecast', 'n3_amountSales') }}</td>
              </tr>
            </template>
            <template v-else-if="row.name === 'CKD Transport'">
              <!-- Baris CKD - Transport -->
              <tr>
                <td class="bold">Transport</td>
              </tr>
            </template>
          </template>
          <tr class="total">
            <td colspan="4">Total</td>
            <td>{{ totalColumns.total_item }}</td>
            <td>{{ formatNumber(sumAllAmountMats("n0_amount_act")) }}</td>
            <td>{{ formatNumber(sumAllAmountSales("n0_amountSales")) }}</td>
            <td>{{ totalPercentSales("n0_amount_act", "n0_amountSales") }}</td>

            <td>{{ formatNumber(sumAllAmountMats("n_amount_forecast")) }}</td>
            <td>{{ formatNumber(sumAllAmountSales("n_amountSales")) }}</td>
            <td>{{ totalPercentSales("n_amount_forecast", "n_amountSales") }}</td>

            <td>{{ formatNumber(sumAllAmountMats("n1_amount_forecast")) }}</td>
            <td>{{ formatNumber(sumAllAmountSales("n1_amountSales")) }}</td>
            <td>{{ totalPercentSales("n1_amount_forecast", "n1_amountSales") }}</td>

            <td>{{ formatNumber(sumAllAmountMats("n2_amount_forecast")) }}</td>
            <td>{{ formatNumber(sumAllAmountSales("n2_amountSales")) }}</td>
            <td>{{ totalPercentSales("n2_amount_forecast", "n2_amountSales") }}</td>

            <td>{{ formatNumber(sumAllAmountMats("n3_amount_forecast")) }}</td>
            <td>{{ formatNumber(sumAllAmountSales("n3_amountSales")) }}</td>
            <td>{{ totalPercentSales("n3_amount_forecast", "n3_amountSales") }}</td>
          </tr>
        </tbody>
      </table>

      <div class="left-side">
        <!-- Notes Section -->
        <div class="notes-section">
          <div class="notes-content">
            <p><strong>Note:</strong></p>
            <ul>
              <li contenteditable="true">Budget Material Sep 2025 menggunakan Material Price periode Jul - Sep 2025.
              </li>
              <li contenteditable="true">Budget Sep 2025 sudah termasuk Spare Part.</li>
              <li contenteditable="true">Budget Transport merupakan Budget Transport CKD Import.</li>
              <li contenteditable="true">Diff. Budget MDFO vs Act Aug’25 terabsorb pada qty budget Sep’25.</li>
              <li contenteditable="true">Qty 1st Week Sep’25 masuk ke dalam budget Aug-25.</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="print-button">
    <button @click="printA4">
      <img src="../assets/printer.png" alt="Print" class="icon" />
      Print
    </button>
  </div>
</template>

<script>
import axios from "axios";
import * as XLSX from "xlsx";

export default {
    data() {
    return {
      budget_mat: [],
      selectedMonth: "",         // month filter
      selectedReportType: "", // default
      selectedVersion: "00",     // default
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
        r =>
          r.nokol === no &&
          r.model === model &&
          (r.name === "CKD PCS" || r.name === "CKD Transport")
      );

      // sum PCS + Transport, keep number while summing
      const total = group.reduce((sum, r) => {
        return sum + (parseFloat(r[field]) || 0);
      }, 0);

      // only format once after summing
      return total;
    },

    formatNumber(value) {
      if (!value) return "0";
      // Ensure it's a number
      value = Number(value);
      // Convert to string and insert dot every 3 digits
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    },

    sumMaterial(row) {
      const pcs = parseFloat(row.total_item) || 0;
      const transport = parseFloat(row.total_item) || 0;
      return this.formatNumber(pcs + transport);
    },

    sumAllAmountMats(field) {
      const group = this.budget_mat.filter(r =>
        ["SU2ID", "KS", "SU2ID FL", "KS-FL"].includes(r.model)
      );

      const total = group.reduce((sum, r) => {
        return sum + (parseFloat(r[field]) || 0);
      }, 0);

      return total;
    },

    sumAllAmountSales(field) {
      const group = this.budget_mat.filter(r =>
        ["SU2ID", "KS", "SU2ID FL", "KS-FL"].includes(r.model)
      );

      const total = group.reduce((sum, r) => {
        return sum + (parseFloat(r[field]) || 0);
      }, 0);

      return total;
    },

    sumAllMaterialPercent(field) {
      const group = this.budget_mat.filter(r =>
        ["SU2ID", "KS", "SU2ID FL", "KS-FL"].includes(r.model)
      );

      const total = group.reduce((sum, r) => {
        return sum + (parseFloat(r[field]) || 0);
      }, 0);

      return total;
    },

    percentageMaterial(row, field1, field2) {
      const total = parseFloat(row[field2]) || 0;
      if (!total) return "0%";
      const value = parseFloat(row[field1]) || 0;
      return ((value / total) * 100).toFixed(0) + "%";
    },

    percentageCKD(no, model, field, field2) {
      const row = this.budget_mat.find(r => r.nokol === no && r.model === model);
      const total = parseFloat(row?.[field2]) || 0;
      return ((this.sumCKD(no, model, field) / total) * 100).toFixed(0) + "%";
    },

    totalPercentSales(field1, field2) {
      const totalMats = this.sumAllAmountMats(field1);
      const totalSales = this.sumAllAmountSales(field2);

      const totalPercent = ((totalMats / totalSales) * 100).toFixed(0) + "%";
      return totalPercent;
    },

    printA4() {
      window.print();
    }
  },

  computed: {
    formattedDate() {
      const today = new Date();
      return today.toLocaleDateString("en-GB", {
        day: "numeric",
        month: "long",
        year: "numeric"
      });
    },

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

      for (const key in totals) {
        totals[key] = Math.round(totals[key]); // bisa ganti ke Math.floor / Math.ceil sesuai kebutuhan
      }
      return totals;
    },

    totalDiff() {
      const { n0_amount_act, n0_amount_forecast } = this.totalColumns;

      if (!n0_amount_forecast) {
        return 0;
      }

      const diff = (n0_amount_act - n0_amount_forecast) / n0_amount_act;
      return diff * 100;
    },
  }
};
</script>
