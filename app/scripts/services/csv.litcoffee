# The CSV service

Holds shared state for the CSV transformation.

    'use strict'

    angular.module 'r2rDesignerApp'
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
            if table? and csvData[table]?
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

          selectAllColumns: (table) ->
            if table?
              selectedColumns[table] = _.first csvData[table]
          
          deselectAllColumns: (table) ->
            if table?
              selectedColumns[table] = []

          submitCsvFile: (file) ->
            csvFile =
              name: file.name
            $upload.upload
              url: csvAdapter + '/upload'
              method: 'POST'
              file: file
              fileName: file.name

          getCsvData: () ->
            $http.get csvAdapter + '/data'
                 .then (res) ->
                   if csvFile.name?
                     table = csvFile.name
                     tables = [table]
                     selectedTables = tables
                     csvData[table] = res.data
        }
