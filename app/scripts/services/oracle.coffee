'use strict'

angular.module 'app'
  .factory 'Oracle', ($http, Jsedn) ->

    host = 'http://localhost:3000'
    oracleApi = host + '/api/v1/oracle'

    {
      ask: (table, columns) ->
        if table? and columns?
          $http.post oracleApi, {name: table, columns: columns}
            .then (res) ->
              res.data
    }
