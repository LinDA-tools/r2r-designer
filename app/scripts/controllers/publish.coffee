'use strict'

angular.module 'app'
  .controller 'PublishCtrl', ($scope, _, Rdb, Rdf, Sml) ->

    $scope.rdb = Rdb
    $scope.rdf = Rdf
    $scope.sml = Sml

    $scope.publish = () ->
      console.log 'publishing'
      mapping =
        tables: $scope.rdb.selectedTables()
        columns: $scope.rdb.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypes

      console.log $scope.sml.toSml mapping
