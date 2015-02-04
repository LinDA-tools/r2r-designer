# The RDB revision controller   

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'RdbReviseCtrl', ($scope, _, Rdb, Rdf) ->

        $scope.rdb = Rdb
        $scope.rdf = Rdf

        $scope.table = ''
        $scope.columns = []

        $scope.$watch 'rdb.selectedTables()', (val) ->
          if val?
            $scope.table = _.first $scope.rdb.selectedTables()

        $scope.$watch 'table', (val) ->
          if val?
            $scope.columns = $scope.rdb.selectedColumns()[val]

The subjectTemplate holds the generator template for the subject URI.
With 'insert' you can insert an available column into the template. Curly braces denote columns.
This section needs an overhaul.

        $scope.selectedColumns = []
        $scope.cursorpos = 0
        $scope.isSelected = (column) -> _.contains $scope.selectedColumns, column

        $scope.insert = (column) ->
          if ($scope.isSelected column)
            oldVal = $scope.rdf.subjectTemplate
            $scope.rdf.subjectTemplate = oldVal.replace '{' + column + '}', ''
            $scope.selectedColumns = _.without $scope.selectedColumns, column
          else
            oldVal = $scope.rdf.subjectTemplate
            $scope.rdf.subjectTemplate = (oldVal.slice 0, $scope.cursorpos) + '{' + column + '}' + (oldVal.slice $scope.cursorpos, oldVal.length)
            $scope.selectedColumns.push column
