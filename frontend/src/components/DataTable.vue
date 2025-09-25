<template>
  <div class="a4-page">
    <!-- Report Header -->
    <div class="report-header">
      <div class="logo">
        <!-- replace with your logo path in /public -->
        <img src="../assets/logo.png" alt="Company Logo" />
      </div>
      <div class="header-info">
        <div class="row">
          <span class="label bold">TITLE</span>
          <span class="value bold">: BUDGET PEMBELIAN MATERIAL & CKD SEPTEMBER 2025</span>
        </div>
        <div class="row">
          <span class="label bold">PROJECT</span>
          <span class="value bold">: SU2ID & KS</span>
        </div>
        <div class="row">
          <span class="label bold">CUSTOMER</span>
          <span class="value bold">: PT HMMI</span>
        </div>
      </div>
      <div class="rev">
        <p style="font-weight: bold;">REV. 00</p>
      </div>
    </div>


    <!-- <h2 class="text-xl font-bold mb-2">Data Budget</h2> -->
    <table class="report-table" id="budget-table">
      <thead>
        <tr>
          <th style="background-color: white; border: none;" colspan="21"></th>
          <th colspan="3" style="background-color: white; font-style: italic;">{{ formattedDate }}</th>
        </tr>
        <tr>
          <th rowspan="4" style="width:10px; text-align:center;">No</th>
          <th rowspan="4">Model</th>
          <th rowspan="4" colspan="2">Material/CKD</th>
          <th rowspan="4">Σ Item <br> V to V / <br>Gpart</th>
          <!-- Bulan -->
          <th colspan="19" style="font-size: 14px; font-weight: bold;">BUDGET MATERIAL & CKD</th>
        </tr>
        <tr>
          <th colspan="6">Aug-25</th>
          <th rowspan="3">DIFF</th>
          <th colspan="3">Sep-25</th>
          <th colspan="3">Oct-25</th>
          <th colspan="3">Nov-25</th>
          <th colspan="3">Dec-25</th>
        </tr>
        <tr>
          <th colspan="3">FORECAST</th>
          <th colspan="3">ACTUAL</th>
          <th colspan="3">FORECAST</th>
          <th colspan="3">FORECAST</th>
          <th colspan="3">FORECAST</th>
          <th colspan="3">FORECAST</th>
        </tr>
        <tr>
          <!-- Sub kolom -->
          <th class="italic">PCS</th>
          <th class="italic">KG</th>
          <th class="italic">AMOUNT <br>(x1000)</th>
          <th class="italic">PCS</th>
          <th class="italic">KG</th>
          <th class="italic">AMOUNT <br>(x1000)</th>
          <th class="italic">PCS</th>
          <th class="italic">KG</th>
          <th class="italic">AMOUNT <br>(x1000)</th>
          <th class="italic">PCS</th>
          <th class="italic">KG</th>
          <th class="italic">AMOUNT <br>(x1000)</th>
          <th class="italic">PCS</th>
          <th class="italic">KG</th>
          <th class="italic">AMOUNT <br>(x1000)</th>
          <th class="italic">PCS</th>
          <th class="italic">KG</th>
          <th class="italic">AMOUNT <br>(x1000)</th>
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
            <td>{{ formatNumber(row.n0_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n0_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n0_amount_forecast) }}</td>
            <td>{{ formatNumber(row.n0_pcs_act) }}</td>
            <td>{{ formatNumber(row.n0_kg_act) }}</td>
            <td>{{ formatNumber(row.n0_amount_act) }}</td>

            <td style="color: red;">{{ formatNumber(row.difference) }}%</td>

            <td>{{ formatNumber(row.n_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n_amount_forecast) }}</td>
            <td>{{ formatNumber(row.n1_pcs_forecast) }}</td>
            <td>{{ formatNumber(row.n1_kg_forecast) }}</td>
            <td>{{ formatNumber(row.n1_amount_forecast) }}</td>
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
              <td rowspan="2" class="bold">CKD</td>

              <!-- Baris CKD PCS -->
              <td class="bold">PCS</td>

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
                {{ formatNumber(row.n0_kg_act) }}
              </td>
              <td>
                {{ formatNumber(row.n0_amount_act) }}
              </td>

              <td style="color: red;">{{ formatNumber(row.difference) }}%</td>


              <td :rowspan="2">{{ sumCKD(row.nokol, row.model, 'n_pcs_forecast') }}</td>

              <td v-if="isSameCKD(row.nokol, row.model, 'n_kg_forecast')" :rowspan="2">
                {{ formatNumber(row.n_kg_forecast) }}
              </td>
              <td v-else>
                {{ formatNumber(row.n_kg_forecast) }}
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
              <td class="bold">Transport</td>

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

              <td style="color: red">{{ row.difference }}%</td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n_kg_forecast')">
                {{ formatNumber(row.n_kg_forecast) }}
              </td>
              <td v-if="!isSameCKD(row.nokol, row.model, 'n_amount_forecast')">
                {{ formatNumber(row.n_amount_forecast) }}
              </td>

              <td v-if="!isSameCKD(row.nokol, row.model, 'n1_kg_forecast')">
                {{ formatNumber(row.n1_kg_forecast) }}
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
          <td class="bold" colspan="4">Total</td>
          <td class="bold">{{ totalColumns.total_item }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n0_pcs_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n0_kg_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n0_amount_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n0_pcs_act) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n0_kg_act) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n0_amount_act) }}</td>
          <td style="color: red; font-weight: bold;">{{ totalDiff.toFixed(2) }}%</td>
          <td class="bold">{{ formatNumber(totalColumns.n_pcs_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n_kg_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n_amount_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n1_pcs_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n1_kg_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n1_amount_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n2_pcs_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n2_kg_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n2_amount_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n3_pcs_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n3_kg_forecast) }}</td>
          <td class="bold">{{ formatNumber(totalColumns.n3_amount_forecast) }}</td>
        </tr>
      </tbody>
    </table>
    <!-- <br><br>
    <button @click="exportExcel" class="mb-4 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">
      Download Excel
    </button><br><br> -->

    <!-- Notes Section -->
    <div class="notes-section">
      <div class="notes-content">
      <p><strong>Note:</strong></p>
      <ul>
        <li>Budget Material Sep 2025 menggunakan Material Price periode Jul - Sep 2025.</li>
        <li>Budget Sep 2025 sudah termasuk Spare Part.</li>
        <li>Budget Transport merupakan Budget Transport CKD Import.</li>
        <li>Diff. Budget MDFO vs Act Aug’25 terabsorb pada qty budget Sep’25.</li>
        <li>Qty 1st Week Sep’25 masuk ke dalam budget Aug-25.</li>
      </ul>
      </div>
    </div>

    <!-- Signature Section -->
    <div class="signature-section">



      <table class="signature-table">
        <thead>
          <tr>
            <th>Menyetujui</th>
            <th>Mengetahui</th>
            <th colspan="2">Diperiksa</th>
            <th>Dibuat</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td style="height: 60px;"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <!-- <td></td> -->
            <td class="bold">Rudy B. Darmawan</td>
            <td class="bold">Aditya Herliawan</td>
            <td class="bold">Erick Maryansyah</td>
            <td class="bold">Imam Khudori</td>
            <td class="bold">Gema Ramadhan P.</td>
          </tr>
          <tr>
            <td><span class="role">Deputy Executive Officer<br>Commercial</span></td>
            <td><span class="role">Dept. Head<br>Marketing</span></td>
            <td><span class="role">Asst. Dept. Head<br>Marketing</span></td>
            <td><span class="role">Asst. Dept. Head<br>Marketing</span></td>
            <td><span class="role">Staff<br>Marketing</span></td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>
</template>

<script>
import axios from "axios";
import * as XLSX from "xlsx";

export default {
  data() {
    return {
      budget_mat: [],
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
        return this.formatNumber(total + (parseFloat(r[field]) || 0));
      }, 0);
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
    exportExcel() {
      const table = document.getElementById("budget-table");
      const wb = XLSX.utils.table_to_book(table, { sheet: "Budget" });

      // langsung download
      XLSX.writeFile(wb, "budget.xlsx");
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

      for (let key in totals) {
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
    }
  }

};
</script>
