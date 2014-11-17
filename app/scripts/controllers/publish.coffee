'use strict'

angular.module 'app'
  .controller 'PublishCtrl', ($scope, $timeout, _, Rdb, Rdf, Sml) ->

    $scope.rdb = Rdb
    $scope.rdf = Rdf
    $scope.sml = Sml

    $scope.publishing = false
    $scope.success = false

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

      $timeout () ->
        console.log 'publishing'
        $scope.publishing = false
        $scope.success = true
        $scope.mapping = $scope.sml.toSml mapping
        console.log $scope.mapping
