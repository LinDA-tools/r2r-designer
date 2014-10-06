'use strict'

angular.module 'app'
  #.controller 'RdbCtrl', ($scope, $http, Config, Rdb, R2rs) ->
  .controller 'RdbCtrl', ($scope, RdbFactory) ->



    $scope.tables = RdbFactory.tables
    $scope.tablesEnlisted = RdbFactory.tablesEnlisted


