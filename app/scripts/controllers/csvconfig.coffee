'use strict'

angular.module 'app'
  .controller 'CsvConfigCtrl', ($scope, Csv) ->

    $scope.csv = Csv
    $scope.file = ''
    $scope.progress =
      value: 0
      submitting: false
    $scope.success = false
    $scope.submitted = false

    $scope.onFileSelect = ($files) ->
      $scope.file = $files[0]

    $scope.submit = () ->
      $scope.csv.submitCsvFile $scope.file, $scope.progress
        .success () ->
          $scope.csv.getCsvData()
          $scope.submitted = true
          $scope.success = true
          $scope.progress.submitting = false
        .error () ->
          $scope.submitted = true
          $scope.success = false
          $scope.progress.submitting = false
