'use strict'

angular.module 'app'
  .factory 'Rdb', ($http, _) ->

    host = 'http://localhost:3000'
    dbAdapter = host + '/api/v1/db'

    {
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
