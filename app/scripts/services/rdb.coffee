'use strict'

angular.module 'r2rDesignerApp'
  .factory 'Rdb', ($http, _, Config) ->

    dbAdapter = Config.backend + '/api/v1/db'

    tables = []
    tableColumns = {}
    selectedTables = []
    selectedColumns = {}
    
    {
      datasource:
        host: 'localhost'
        driver: 'org.postgresql.ds.PGSimpleDataSource'
        name: 'mydb'
        username: 'postgres'
        password: ''
      
      tables: () -> tables
      tableColumns: () -> tableColumns
      selectedTables: () -> selectedTables
      selectedColumns: () -> selectedColumns

      isSelectedTable: (table) -> _.contains selectedTables, table
      isSelectedColumn: (table, column) -> _.contains selectedColumns[table], column

      toggleSelectTable: (table) ->
        if _.contains selectedTables, table
          selectedTables = _.without selectedTables, table
        else
          selectedTables.push table

      toggleSelectColumn: (table, column) ->
        if tableColumns[table]?
          if _.contains selectedColumns[table], column
            selectedColumns[table] = _.without selectedColumns[table], column
          else
            if selectedColumns[table]?
              selectedColumns[table].push column
            else
              selectedColumns[table] = [column]

      checkDatabase: (dbSpec) ->
        $http.post dbAdapter + '/test', {},
          params:
            driver: dbSpec.driver
            host: dbSpec.host
            name: dbSpec.name
            username: dbSpec.username
            password: dbSpec.password

      registerDatabase: (dbSpec) ->
        $http.post dbAdapter + '/register', {},
          params:
            driver: dbSpec.driver
            host: dbSpec.host
            name: dbSpec.name
            username: dbSpec.username
            password: dbSpec.password

      getTables: ->
        $http.get dbAdapter + '/tables'
             .success (data) ->
               tables = data
             .error () ->
               console.log 'error: could not connect to server'

      getTableColumns: ->
        $http.get dbAdapter + '/table-columns'
             .success (data) ->
               tableColumns = data
             .error () ->
               console.log 'error: could not connect to server'

      getColumn: (table, column) ->
        $http.get dbAdapter + '/column',
          params:
            table: table
            name: column
    }
