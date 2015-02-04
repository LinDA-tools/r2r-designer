# The CSV content controller

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'CsvContentsCtrl', ($scope, Csv) ->

        $scope.csv = Csv
        $scope.table = ''

        $scope.$watch 'csv.csvFile()', (val) ->
          if val?
            $scope.table = val.name

        $scope.$watch 'selectAll', (val) ->
          if val
            $scope.csv.selectAllColumns $scope.table
          else
            $scope.csv.deselectAllColumns $scope.table
