'use strict'

angular.module 'r2rDesignerApp'
  .controller 'CsvContentsCtrl', ($scope, Csv) ->

    $scope.csv = Csv
    $scope.table = ''

    $scope.$watch 'csv.csvFile()', (val) ->
      if val?
        $scope.table = val.name
    #   $scope.csv.getCsvData()
