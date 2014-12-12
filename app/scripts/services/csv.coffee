'use strict'

angular.module 'app'
  .factory 'Csv', ($http, $upload, _, Config) ->

    csvAdapter = Config.backend + '/api/v1/csv'

    csvData = {}
    tables = []
    tableColumns = {}
    selectedTables = []
    selectedColumns = {}
    csvFile = {}
    
    {
      csvFile: () -> csvFile
      tables: () -> tables
      columns: (table) ->
        if table and csvData[table]?
          _.first csvData[table]
        else
          []
      data: (table) ->
        if table and csvData[table]?
          _.drop csvData[table], 1
        else
          []
      selectedTables: () -> selectedTables
      selectedColumns: () -> selectedColumns
      isSelectedColumn: (table, column) -> _.contains selectedColumns[table], column
      toggleSelectedColumn: (table, column) ->
        if _.contains selectedColumns[table], column
          selectedColumns[table] = _.without selectedColumns[table], column
        else
          if selectedColumns[table]?
            selectedColumns[table].push column
          else
            selectedColumns[table] = [column]

      submitCsvFile: (file, progress) ->
        csvFile =
          name: file.name
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

      getCsvData: () ->
        $http.get csvAdapter + '/data'
             .then (res) ->
               if csvFile.name?
                 table = csvFile.name
                 tables = [table]
                 selectedTables = tables
                 csvData[table] = res.data
    }
