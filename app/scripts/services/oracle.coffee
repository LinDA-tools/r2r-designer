'use strict'

angular.module 'app'
  .factory 'Oracle', ($http, Jsedn) ->

    host = 'http://localhost:3000'
    oracleAdapter = host + '/api/v1/oracle'

    # getSuggestedEntities = (url, params) ->
    #   $http.get url, params: params
    #     .then (res) ->
    #       suggestions = []
    #       mydata = Jsedn.toJS Jsedn.parse res.data
    #       (item) ->
    #         suggestions.push
    #           uri: item.uri
    #           prefixedName: item.uriPrefixed
    #           localName: item.uriPrefixed.slice (item.vocabularyPrefix.length + 1) item.uriPrefixed.length
    #           prefix: item.vocabularyPrefix + ':'
    #           score: item.score.toPrecision 3
    #           group: 'suggested'
    #       mydata

    #       suggestions
    {
      # getSubjectClasses: (q, column) ->
      #   getSubjectEntities oracleAdapter + '/classes',
      #     table: table
      #     column: column

      # getSuggestedProperties: (table, column) ->
      #   getSuggestedEntities oracleAdapter + '/properties',
      #     table: table
      #     column: column

      ask: (table, columns) ->
        if table? && columns?
          console.log table
          console.log columns
          $http.post oracleAdapter, data: { "table": table, "columns": columns }
            .then (res) ->
              console.log res.data
    }

