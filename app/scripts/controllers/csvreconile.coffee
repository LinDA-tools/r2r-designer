'use strict'

angular.module 'app'
  .controller 'CsvReconcileCtrl', ($scope, _, Oracle, Csv, Rdf) ->

    $scope.csv = Csv
    $scope.rdf = Rdf

    $scope.loading = false

    $scope.subjectTag = {}

    $scope.columnTags = {}

    $scope.ask = (subject, columns) ->
      $scope.loading = true
      Oracle.ask subjects, $scope.subjectTag, columns, $scope.columnTags
        .then (promise) ->
          $scope.loading = false
          $scope.rdf.suggestions[filename] = promise

    # $scope.getColumnSuggestions = (table, column) ->
    #   if $scope.rdf.suggestions? and $scope.rdf.suggestions[table] and $scope.rdf.suggestions[table].columns?
    #     (_.first (_.filter $scope.rdf.suggestions[table].columns, (i) -> i.name == column)).recommend

    # $scope.selectClass = (table, _class) ->
    #   if table? and _class?
    #     if _.contains $scope.rdf.selectedClasses[table], _class
    #       $scope.rdf.selectedClasses[table] = _.without $scope.rdf.selectedClasses[table], _class
    #     else
    #       selected = $scope.rdf.selectedClasses[table] or []
    #       selected.push _class
    #       $scope.rdf.selectedClasses[table] = selected

    # $scope.selectProperty = (table, column, property) ->
    #   if table? and column? and property?
    #     currentTable = $scope.rdf.selectedProperties[table] or {}
    #     if currentTable[column] == property
    #       currentTable[column] = null
    #     else
    #       currentTable[column] = property
    #     $scope.rdf.selectedProperties[table] = currentTable

    # $scope.isSelectedClass = (table, _class) ->
    #   _.contains $scope.rdf.selectedClasses[table], _class

    # $scope.isSelectedProperty = (table, column, property) ->
    #   currentTable = $scope.rdf.selectedProperties[table]
    #   currentTable and (currentTable[column] == property)
