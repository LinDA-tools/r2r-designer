'use strict'

angular.module 'app'
  .factory 'Rdb', ($http, _) ->

    host = 'http://localhost:3000'
    dbAdapter = host + '/api/v1/db'

    {
      # datasource: {}
      datasource: {
          'name' : 'Northwind Postgres Database'
          'subprotocol' : 'postgresql'
          'subname' : 'mydb'
          'username' : 'postgres'
          'password' : ''
        }
    
      selectedTables: []
      selectedColumns: {}
      # selectedTables: ["products","employees"]
      # selectedColumns: {"categories":["CategoryID","CategoryName","Description"],"products":["ProductID","ProductName"],"employees":["FirstName","LastName"]}

      registerDatabase: (dbSpec) ->
        $http.post dbAdapter + '/register', {},
          params:
            subname: dbSpec.subname
            subprotocol: dbSpec.subprotocol
            username: dbSpec.username
            password: dbSpec.password

      getTables: ->
        $http.get dbAdapter + '/tables'
             .then (res) -> res.data

      getTableColumns: ->
        $http.get dbAdapter + '/table-columns'
             .then (res) ->
               res.data
    }
