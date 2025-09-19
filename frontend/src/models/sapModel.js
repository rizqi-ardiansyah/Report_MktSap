// models/sapModel.js
export default {
  async getExcelFile() {
    // TODO: ganti dengan koneksi SAP
    // sekarang dummy data berupa blob excel
    const dummyData = new Blob(['id,nama\n1,Andi\n2,Budi'], {
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    })
    return dummyData
  },
}
