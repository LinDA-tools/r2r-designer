'use strict'

angular.module 'app'
  .controller 'CsvContentsCtrl', ($scope, Csv) ->

    $scope.csv = Csv

    $scope.$watch 'csv.file.name', (val) ->
      $scope.csv.getCsvData()
