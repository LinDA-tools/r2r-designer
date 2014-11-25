'use strict'

angular.module 'app'
  .controller 'CsvContentsCtrl', ($scope, Csv) ->

    $scope.csv = Csv

    $scope.$watch 'csv.uploads()', (val) ->
      $scope.csv.getCsvData()
