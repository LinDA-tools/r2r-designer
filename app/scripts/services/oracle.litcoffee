# The Oracle service

Adapter for the r2r-designer oracle.

    'use strict'

    angular.module 'r2rDesignerApp'
      .factory 'Oracle', ($http, _, Config) ->

        oracleApi = Config.backend + '/api/v1/oracle'

        zipColumnTags = (columns, tags) ->
          _.map columns, (i) -> { name: i, tag: tags[i] or i }

        {
          ask: (table, tableTag, columns, columnTags) ->
            $http.post oracleApi, {
              table: {
                name: table,
                tag: tableTag or table
              },
              columns: zipColumnTags columns, columnTags
            }
        }
