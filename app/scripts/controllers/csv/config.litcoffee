# The CSV configuration controller

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'CsvConfigCtrl', ($scope, Csv) ->

        $scope.csv = Csv
       
'file' holds the current selected file.

        $scope.file = ''
        $scope.success = false
        $scope.submitted = false

        $scope.onFileSelect = ($files) ->
          $scope.file = $files[0]

Submits a file. On success, an excerpt of the data is retrieved.

        $scope.submit = () ->
          $scope.csv.submitCsvFile $scope.file
            .success () ->
              $scope.csv.getCsvData()
              $scope.submitted = true
              $scope.success = true
            .error () ->
              $scope.submitted = true
              $scope.success = false
