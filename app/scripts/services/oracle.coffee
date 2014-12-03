'use strict'

angular.module 'app'
  .factory 'Oracle', ($http, _, Config) ->

    oracleApi = Config.backend + '/api/v1/oracle'

    zipColumnTags = (columns, tags) ->
      _.map columns, (i) -> { name: i, tag: tags[i] or i }

    {
      ask: (table, tableTag, columns, columnTags) ->
        console.log table
        console.log tableTag
        console.log columns
        console.log columnTags
        if table? and columns?
          $http.post oracleApi, {
            table: {
              name: table,
              tag: tableTag or table
            },
            columns: zipColumnTags columns, columnTags
          }
            .then (res) ->
              console.log res
              res.data
    }
