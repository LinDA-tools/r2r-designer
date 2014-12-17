'use strict'

angular.module 'app'
  .controller 'CsvContentsCtrl', ($scope, Csv) ->

    $scope.csv = Csv
    $scope.table = ''
    $scope.numItemsReduced = 10
    $scope.numItemsMaximized = 100
    $scope.showAllItems = no

    $scope.$watch 'csv.csvFile()', (val) ->
      if val?
        $scope.table = val.name
      $scope.csv.getCsvData()
