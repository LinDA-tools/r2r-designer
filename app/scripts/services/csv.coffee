'use strict'

angular.module 'app'
  .factory 'Csv', ($http, $upload, _, Config) ->

    csvAdapter = Config.backend + '/api/v1/csv'

    csvData = []
    uploads = 0
    
    tables = []
    tableColumns = {}
    selectedTables = []
    selectedColumns = {}
    
    {
      csvFile: null
      uploads: () -> uploads

      tables: () -> tables
      tableColumns: () -> tableColumns
      selectedTables: () -> selectedTables
      selectedColumns: () -> selectedColumns
      data: () -> _.drop csvData, 1
      
      isSelectedColumn: (table, column) -> _.contains selectedColumns[table], column

      toggleSelectedColumn: (table, column) ->
        if tableColumns[table]?
          if _.contains selectedColumns[table], column
            selectedColumns[table] = _.without selectedColumns[table], column
          else
            if selectedColumns[table]?
              selectedColumns[table].push column
            else
              selectedColumns[table] = [column]

      submitCsvFile: (file, progress) ->
        progress.submitting = true
        $upload.upload
          url: csvAdapter + '/upload'
          method: 'POST'
          file: file
          fileName: file.name
        .progress (evt) ->
          progress.value = parseInt 100.0 * evt.loaded / evt.total
          if evt.loaded == evt.total
            progress.submitting = false
            uploads++

      getColumns: () -> _.first csvData

      getCsvData: () ->
        $http.get csvAdapter + '/data'
             .then (res) ->
               csvData = res.data
    }

