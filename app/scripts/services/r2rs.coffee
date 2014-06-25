'use strict'


angular.module 'app'
  .factory 'R2rs', ($http, Jsedn) ->

    host = 'http://localhost:3000'
    dbAdapter = host + '/api/v1/db'
    lovAdapter = host + '/api/v1/lov'
    recommenderAdapter = host + '/api/v1/recommender'

    rowValuesToArray = (keys, row) ->
      (i) -> row[i] key for key in keys

    getSuggestedEntities = (url, params) ->
      $http.get url, params: params
        .then (res) ->
          suggestions = []
          mydata = Jsedn.toJS Jsedn.parse res.data
          (item) ->
            suggestions.push
              uri: item.uri
              prefixedName: item.uriPrefixed
              localName: item.uriPrefixed.slice (item.vocabularyPrefix.length + 1) item.uriPrefixed.length
              prefix: item.vocabularyPrefix + ':'
              score: item.score.toPrecision 3
              group: 'suggested'
          mydata

          suggestions

    getTables: ->
      $http.get dbAdapter + '/tables'
           .then (res) -> Jsedn.toJS Jsedn.parse res.data

    getColumnsMap: (table) ->
      $http.get dbAdapter + '/columns',
        params:
          table: table
      .then (res) ->
        Jsedn.toJS Jsedn.parse res.data

    getTableData: (table, columnsMap) ->
      $http.get dbAdapter + '/table',
        params:
          name: table
      .then (res) ->
        columnKeys = (i) -> i[0] for i in columnsMap
        columnNames = (i) -> i[1] for i in columnsMap
        mydata = Jsedn.toJS Jsedn.parse res.data

          columns: columnNames,
          data: (i) -> rowValuesToArray columnKeys, i for i in mydata

    getSubjectsForTemplate: (table, baseUri, template) ->
      triples = []

      $http.get dbAdapter + '/subjects',
        params:
          table: table
          template: encodeURI baseUri + template
      .then (res) ->
        mydata = Jsedn.toJS Jsedn.parse res.data
        (i) -> triples.push [i, 'rdf:type', 'rdfs:resource'] for i in mydata

        triples
     
    getSuggestedLOVClasses: (table, column) ->
      getSuggestedEntities lovAdapter + '/classes',
        table: table
        column: column

    getSuggestedLOVProperties: (table, column) ->
      getSuggestedEntities lovAdapter + '/properties',
        table: table
        column: column

    getSuggestedDBPediaTypes: (table, template) ->
      $http.get recommenderAdapter + '/types',
        params:
          table: table
          template: encodeURI template
      .then (res) ->
        suggestions = []
        mydata = Jsedn.toJS Jsedn.parse res.data
        (i) -> suggestions.push
          prefixedName: i.uri
          group: 'suggested'
        mydata

        suggestions

    registerDatabase: (dbSpec) ->
      $http.get dbAdapter + '/config/register',
        params:
          subname: dbSpec.subname
          subprotocol: dbSpec.subprotocol
          username: dbSpec.username
          password: dbSpec.password
