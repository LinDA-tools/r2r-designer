'use strict'

angular.module 'app'
  .controller 'PlaygroundCtrl', ($scope, $http, Config, Oracle) ->

    $scope.oracle = Oracle

    $scope.tables = []
    $scope.data = []
    $scope.columnsMap = []

