'use strict'

angular.module 'app'
  .factory 'Rdb', ($http, _) ->

    host = 'http://localhost:3000'
    dbAdapter = host + '/api/v1/db'

    tables = []
    tableColumns = {}
    selectedTables = []
    selectedColumns = {}
    
    tables = ["products","employees"]
    tableColumns = {"categories":["CategoryID","CategoryName","Description"],"products":["ProductID","ProductName"],"employees":["FirstName","LastName"]}
    selectedTables = ["products","employees"]
    selectedColumns = {"categories":["CategoryID","CategoryName","Description"],"products":["ProductID","ProductName"],"employees":["FirstName","LastName"]}

    {
      # datasource: {}
      datasource: {
          'host' : 'localhost'
          'driver' : 'org.postgresql.ds.PGSimpleDataSource'
          'name' : 'mydb'
          'username' : 'postgres'
          'password' : ''
        }
      
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
             .then (res) ->
               tables = res.data

      getTableColumns: ->
        $http.get dbAdapter + '/table-columns'
             .then (res) ->
               tableColumns = res.data

      getColumn: (table, column) ->
        $http.get dbAdapter + '/column',
          params:
            table: table
            name: column
    }
