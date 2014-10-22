'use strict'

angular.module 'app'
  .controller 'ConfigCtrl', ($scope, Rdb) ->

    $scope.rdb = Rdb

    $scope.checking = false
    $scope.checked = false
    $scope.success = false

    $scope.$watch 'rdb.datasource.host', () ->
      $scope.checked = false

    $scope.$watch 'rdb.datasource.driver', () ->
      $scope.checked = false

    $scope.$watch 'rdb.datasource.name', () ->
      $scope.checked = false

    $scope.$watch 'rdb.datasource.username', () ->
      $scope.checked = false

    $scope.$watch 'rdb.datasource.password', () ->
      $scope.checked = false

    $scope.test = () ->
      $scope.checking = true
      $scope.rdb.checkDatabase $scope.rdb.datasource
        .success (data) ->
          console.log 'success: ' + data
          $scope.checking = false
          $scope.checked = true
          $scope.success = (data == "true")
        .error (data) ->
          console.log 'error: ' + data
          $scope.checking = false
          $scope.checked = true
          $scope.success = (data == "false")

    $scope.apply = () ->
      $scope.checked = false
      $scope.rdb.registerDatabase $scope.rdb.datasource
        .then () ->
          $scope.rdb.getTables()
          $scope.rdb.getTableColumns()
