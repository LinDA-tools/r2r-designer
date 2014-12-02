'use strict'

angular.module 'app'
  .controller 'CsvReconcileCtrl', ($scope, _, Oracle, Csv, Rdf) ->

    $scope.csv = Csv
    $scope.rdf = Rdf

    $scope.loading = false

    $scope.table = ''
    $scope.tableTag = {}

    $scope.columns = []
    $scope.columnTags = {}

    $scope.$watch 'csv.csvFile', (val) ->
      if val?
        $scope.table = val.name

    $scope.$watch 'table', (val) ->
      if val?
        $scope.columns = $scope.csv.selectedColumns()[val]

    $scope.ask = (table, columns) ->
      $scope.loading = true
      Oracle.ask table, $scope.tableTag[table], columns, $scope.columnTags
        .then (promise) ->
          $scope.loading = false
          $scope.rdf.suggestions[table] = promise

    $scope.getColumnSuggestions = (table, column) ->
      if $scope.rdf.suggestions? and $scope.rdf.suggestions[table] and $scope.rdf.suggestions[table].columns?
        (_.first (_.filter $scope.rdf.suggestions[table].columns, (i) -> i.name == column)).recommend

    $scope.selectClass = (table, _class) ->
      if table? and _class?
        if _.contains $scope.rdf.selectedClasses[table], _class
          $scope.rdf.selectedClasses[table] = _.without $scope.rdf.selectedClasses[table], _class
        else
          selected = $scope.rdf.selectedClasses[table] or []
          selected.push _class
          $scope.rdf.selectedClasses[table] = selected

    $scope.selectProperty = (table, column, property) ->
      if table? and column? and property?
        currentTable = $scope.rdf.selectedProperties[table] or {}
        if currentTable[column] == property
          currentTable[column] = null
        else
          currentTable[column] = property
        $scope.rdf.selectedProperties[table] = currentTable

    $scope.isSelectedClass = (table, _class) ->
      _.contains $scope.rdf.selectedClasses[table], _class

    $scope.isSelectedProperty = (table, column, property) ->
      currentTable = $scope.rdf.selectedProperties[table]
      currentTable and (currentTable[column] == property)
