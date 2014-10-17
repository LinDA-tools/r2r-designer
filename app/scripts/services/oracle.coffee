'use strict'

angular.module 'app'
  .factory 'Oracle', ($http, _) ->

    host = 'http://localhost:3000'
    oracleApi = host + '/api/v1/oracle'

    zipColumnTags = (columns, tags) ->
      _.map columns, (i) -> { name: i, tag: tags[i] or i }

    {
      ask: (table, tableTag, columns, columnTags) ->
        if table? and columns?
          $http.post oracleApi, {
            table: {
              name: table,
              tag: tableTag or table
            },
            columns: zipColumnTags columns, columnTags
          }
            .then (res) ->
              res.data
    }
