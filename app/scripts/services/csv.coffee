'use strict'

angular.module 'app'
  .factory 'Csv', ($http, $upload, _) ->

    host = 'http://localhost:3000'
    csvAdapter = host + '/api/v1/csv'

    csvData = []
    selectedCsvColumns = []

    {
      isSelectedCsvColumn: (column) -> _.contains selectedCsvColumns, column

      toggleSelectedCsvColumn: (column) ->
        if _.contains selectedCsvColumns, column
          selectedCsvColumns = _.without selectedCsvColumns, column
        else
          if selectedCsvColumns?
            selectedCsvColumns.push column
          else
            selectedCsvColumns = [column]

      submitCsvFile: (file, progress) ->
        $upload.upload
          url: csvAdapter + '/upload'
          method: 'POST'
          file: file
        .progress (evt) ->
          progress.value = parseInt 100.0 * evt.loaded / evt.total

      columns: () -> _.first csvData
      data: () -> _.drop csvData, 1
      selectedColumns: () -> selectedCsvColumns

      getCsvData: () ->
        $http.get csvAdapter + '/data'
             .then (res) ->
               csvData = res.data
    }

