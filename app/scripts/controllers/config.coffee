'use strict'

angular.module 'app'
  .controller 'ConfigCtrl', ($scope, Rdb, Config) ->

    $scope.datasource = Config.datasource

    $scope.test = () ->
      console.log "test"

    $scope.apply = () ->
      console.log "apply"
