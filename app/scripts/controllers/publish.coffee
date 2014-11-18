'use strict'

angular.module 'app'
  .controller 'PublishCtrl', ($scope, $timeout, $window, _, Rdb, Rdf, Sml, Transform) ->

    $scope.rdb = Rdb
    $scope.rdf = Rdf
    $scope.sml = Sml
    $scope.transform = Transform

    $scope.publishing = false
    $scope.success = false

    $scope.dump = () ->
      mapping =
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes

      w = $window.open ''
      $scope.mapping = $scope.sml.toSml mapping
      $scope.transform.getDumpUrl $scope.mapping
        .then (url) ->
          w.location = url

    $scope.mapping = () ->
      mapping =
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes

      $scope.mapping = $scope.sml.toSml mapping
      w = $window.open ''
      w.document.open()
      w.document.write '<pre>' + $scope.mapping + '</pre>'
      w.document.close()

    $scope.publish = () ->
      $scope.publishing = true
      mapping =
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes

      $scope.publishing = false
      $scope.success = true
      $scope.mapping = $scope.sml.toSml mapping
      # $scope.transform.publish $scope.mapping
