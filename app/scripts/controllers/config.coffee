'use strict'

angular.module 'app'
  .controller 'ConfigCtrl', ($scope, Rdb) ->

    $scope.rdb = Rdb

    $scope.test = () ->
      console.log "test"

    $scope.apply = () ->
      $scope.rdb.registerDatabase $scope.rdb.datasource
