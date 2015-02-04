'use strict'

angular.module 'r2rDesignerApp'
  .controller 'RdbPublishCtrl', ($scope, $timeout, $window, _, Rdb, Rdf, Sml, Transform) ->

    $scope.rdb = Rdb
    $scope.rdf = Rdf
    $scope.sml = Sml
    $scope.transform = Transform

    $scope.publishing = false
    $scope.published = false
    $scope.success = false

    $scope.dump = (table) ->
      mapping =
        source: 'rdb'
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypeSelection

      w = $window.open ''
      $scope.currentMapping = $scope.sml.toSml mapping, table
      $scope.transform.dumpdb $scope.currentMapping
        .then (url) ->
          w.location = url
      
    $scope.mapping = (table) ->
      mapping =
        source: 'rdb'
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypeSelection
      
      $scope.currentMapping = $scope.sml.toSml mapping, table
      w = $window.open ''
      w.document.open()
      w.document.write '<pre>' + $scope.safe_tags_replace($scope.currentMapping) + '</pre>'
      w.document.close()

    $scope.publish = (to) ->
      $scope.publishing = true
      mapping =
        source: 'rdb'
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypeSelection

      $scope.currentMapping = $scope.sml.toSml mapping

      $scope.transform.publish to, $scope.currentMapping
        .success (data) ->
          $scope.publishing = false
          $scope.published = true
          $scope.success = true
        .error (data) ->
          console.log 'error: could not connect to server'
          $scope.publishing = false
          $scope.published = true
          $scope.success = false
