// presenters/downloadPresenter.js
import sapModel from '../models/sapModel'

export default {
  async handleDownload() {
    try {
      const fileBlob = await sapModel.getExcelFile()

      // bikin link download
      const url = window.URL.createObjectURL(fileBlob)
      const a = document.createElement('a')
      a.href = url
      a.download = 'data-sap.xlsx'
      a.click()
      window.URL.revokeObjectURL(url)
    } catch (error) {
      console.error('Gagal download file:', error)
    }
  },
}
