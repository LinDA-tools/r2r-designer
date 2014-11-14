'use strict'

angular.module 'app'
  .controller 'CsvConfigCtrl', ($scope, Csv) ->

    $scope.csv = Csv
    $scope.file = ''
    $scope.progress =
      value: 0
    $scope.submitting = false

    $scope.onFileSelect = ($files) ->
      $scope.file = $files[0]
      $scope.csv.file = $scope.file

    $scope.submit = () ->
      $scope.submitting = true
      $scope.csv.submitCsvFile $scope.file, $scope.progress
        .then (res) ->
          $scope.submitting = false
