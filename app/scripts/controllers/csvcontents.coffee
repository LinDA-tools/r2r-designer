'use strict'

angular.module 'app'
  .controller 'CsvContentsCtrl', ($scope, Csv) ->

    $scope.csv = Csv
    $scope.table = ''

    $scope.$watch 'csv.csvFile()', (val) ->
      if val?
        $scope.table = val.name
      $scope.csv.getCsvData()
