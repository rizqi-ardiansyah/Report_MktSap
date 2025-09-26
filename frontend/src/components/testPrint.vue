<template>
  <div>
    <!-- Button (not printed) -->
    <button class="print-button" @click="printPage">
      🖨️ Print
    </button>

    <!-- Only this will be printed -->
    <div class="a4-pages">
      <h1>My Report</h1>
      <p>This content will be printed only on one A4 page.</p>
      <p>If it's too long, the rest will be cut off (no page 2).</p>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    printPage() {
      window.print()
    }
  }
}
</script>

<style>
.a4-pages {
    width: 210mm;
    height: 297mm;     /* A4 height */
    margin: 0 auto;
    padding: 10mm;
    box-sizing: border-box;
    overflow: hidden;  /* 🚀 cut anything longer than A4 */
    page-break-after: avoid;
  }
@media print {
  body {
    margin: 0;
    padding: 0;
  }

  .a4-pages {
    width: 210mm;
    height: 297mm;     /* A4 height */
    margin: 0 auto;
    padding: 10mm;
    box-sizing: border-box;
    overflow: hidden;  /* 🚀 cut anything longer than A4 */
    page-break-after: avoid;
  }

  .print-button {
    display: none !important; /* hide button */
  }
}
</style>
