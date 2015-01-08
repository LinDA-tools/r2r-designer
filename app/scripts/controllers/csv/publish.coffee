'use strict'

angular.module 'r2rDesignerApp'
  .controller 'CsvPublishCtrl', ($scope, $timeout, $window, _, Csv, Rdf, Sml, Transform) ->

    $scope.csv = Csv
    $scope.rdf = Rdf
    $scope.sml = Sml
    $scope.transform = Transform

    $scope.publishing = false
    $scope.published = false
    $scope.success = false

    $scope.dump = (table) ->
      mapping =
        source: 'csv'
        tables: $scope.csv.selectedTables()
        columns: $scope.csv.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypeSelection

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

    $scope.mapping = () ->
      mapping =
        source: 'csv'
        tables: $scope.csv.selectedTables()
        columns: $scope.csv.selectedColumns()
        baseUri: $scope.rdf.baseUri
        subjectTemplate: $scope.rdf.subjectTemplate
        classes: $scope.rdf.selectedClasses
        properties: $scope.rdf.selectedProperties
        literals: $scope.rdf.propertyLiteralSelection
        literalTypes: $scope.rdf.propertyLiteralTypeSelection
      
      $scope.currentMapping = $scope.sml.toSml mapping
      w = $window.open ''
      w.document.open()
      w.document.write '<pre>' + $scope.safe_tags_replace($scope.currentMapping) + '</pre>'
      w.document.close()

    $scope.publish = (to) ->
      $scope.publishing = true
      mapping =
        source: 'csv'
        tables: $scope.csv.selectedTables()
        columns: $scope.csv.selectedColumns()
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
        .error () ->
          console.log 'error: could not connect to server'
          $scope.publishing = false
          $scope.published = true
          $scope.success = false
