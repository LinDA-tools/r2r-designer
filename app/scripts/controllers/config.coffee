'use strict'

angular.module 'app'
  .controller 'ConfigCtrl', ($scope, Rdb) ->

    $scope.rdb = Rdb

    $scope.checking = false
    $scope.checked = false
    $scope.success = false

    $scope.$watch 'rdb.datasource.subname', () ->
      $scope.checked = false

    $scope.$watch 'rdb.datasource.subprotocol', () ->
      $scope.checked = false

    $scope.$watch 'rdb.datasource.username', () ->
      $scope.checked = false

    $scope.$watch 'rdb.datasource.password', () ->
      $scope.checked = false

    $scope.test = () ->
      $scope.checking = true
      $scope.rdb.checkDatabase
        subname: $scope.rdb.datasource.subname
        subprotocol: $scope.rdb.datasource.subprotocol
        username: $scope.rdb.datasource.username
        password: $scope.rdb.datasource.password
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
