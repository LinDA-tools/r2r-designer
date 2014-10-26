'use strict'

angular.module 'app'
  .controller 'refineCtrl', ($scope, _, Rdb, Rdf) ->

    $scope.rdb = Rdb
    $scope.rdf = Rdf

    $scope.table = ''
    $scope.columns = []

    $scope.selectedColumns = []
    $scope.subjectTemplate = ''
    $scope.cursorpos = 0

    $scope.propertyLiteralSelection = {}
    $scope.propertyLiteralType = {}
    $scope.propertyLiteralTypeSelections = ['Plain Literal', 'Typed Literal', 'Blank Node']

    $scope.$watch 'rdb.selectedTables()', (val) ->
      if val?
        $scope.table = _.first $scope.rdb.selectedTables()

    $scope.$watch 'table', (val) ->
      if val?
        $scope.columns = $scope.rdb.selectedColumns()[val]

    $scope.isSelected = (column) -> _.contains $scope.selectedColumns, column

    $scope.insert = (column) ->
      if ($scope.isSelected column)
        oldVal = $scope.subjectTemplate
        $scope.subjectTemplate = oldVal.replace '{' + column + '}', ''
        $scope.selectedColumns = _.without $scope.selectedColumns, column
      else
        oldVal = $scope.subjectTemplate
        $scope.subjectTemplate = (oldVal.slice 0, $scope.cursorpos) + '{' + column + '}' + (oldVal.slice $scope.cursorpos, oldVal.length)
        $scope.selectedColumns.push column

