'use strict'

angular.module 'r2rDesignerApp'
  .controller 'PublishCtrl', ($scope, $timeout, $window, _, Rdb, Csv, Rdf, Sml, Transform) ->

    $scope.rdb = Rdb
    $scope.csv = Csv
    $scope.rdf = Rdf
    $scope.sml = Sml
    $scope.transform = Transform

    $scope.publishing = false
    $scope.published = false
    $scope.success = false

    $scope.dumpdb = (table) ->
      mapping =
        source: 'rdb'
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes

      w = $window.open ''
      $scope.currentMapping = $scope.sml.toSml mapping, table
      $scope.transform.dumpdb $scope.currentMapping
        .then (url) ->
          w.location = url

    $scope.dumpcsv = (table) ->
      mapping =
        source: 'csv'
        tables: $scope.csv.selectedTables()
        columns: $scope.csv.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes

      w = $window.open ''
      $scope.currentMapping = $scope.sml.toSml mapping, table
      $scope.transform.dumpcsv $scope.currentMapping
        .then (url) ->
          w.location = url

    $scope.safe_tags_replace = (str) ->
      tagsToReplace =
        '&': '&amp;'
        '<': '&lt;'
        '>': '&gt;'

      replaceTag = (tag) ->
        tagsToReplace[tag] or tag

      str.replace /[&<>]/g, replaceTag
      
    $scope.mappingdb = (table) ->
      mapping =
        source: 'rdb'
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes
      
      $scope.currentMapping = $scope.sml.toSml mapping, table
      w = $window.open ''
      w.document.open()
      w.document.write '<pre>' + $scope.safe_tags_replace($scope.currentMapping) + '</pre>'
      w.document.close()

    $scope.mappingcsv = () ->
      mapping =
        source: 'csv'
        tables: $scope.csv.selectedTables()
        columns: $scope.csv.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes
      
      $scope.currentMapping = $scope.sml.toSml mapping
      console.log $scope.currentMapping
      w = $window.open ''
      w.document.open()
      w.document.write '<pre>' + $scope.safe_tags_replace($scope.currentMapping) + '</pre>'
      w.document.close()

    $scope.publish = (to) ->
      $scope.publishing = true
      if to == 'openrdf'
        mapping =
          source: 'csv'
          tables: $scope.csv.selectedTables()
          columns: $scope.csv.selectedColumns()
          baseUri: $scope.rdf.baseUri
          subjectTemplate: $scope.rdf.subjectTemplate
          classes: $scope.rdf.selectedClasses
          properties: $scope.rdf.selectedProperties
          literals: $scope.rdf.propertyLiteralSelection
          literalTypes: $scope.rdf.propertyLiteralTypes
      else
        mapping =
          source: 'rdb'
          tables: $scope.rdb.selectedTables()
          columns: $scope.rdb.selectedColumns()
          baseUri: $scope.rdf.baseUri
          subjectTemplate: $scope.rdf.subjectTemplate
          classes: $scope.rdf.selectedClasses
          properties: $scope.rdf.selectedProperties
          literals: $scope.rdf.propertyLiteralSelection
          literalTypes: $scope.rdf.propertyLiteralTypes

      $scope.currentMapping = $scope.sml.toSml mapping

      $scope.transform.publish to, $scope.currentMapping
        .success (data) ->
          console.log 'success'
          $scope.publishing = false
          $scope.published = true
          $scope.success = true
        .error (data) ->
          console.log 'error'
          $scope.publishing = false
          $scope.published = true
          $scope.success = false
