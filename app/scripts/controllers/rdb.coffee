'use strict'

angular.module 'app'
  .controller 'RdbCtrl', ($scope, $http, Config, Rdb, R2rs) ->

    $scope.config = Config
    $scope.rdb = Rdb
    $scope.tables = []
    $scope.data = []
    $scope.columnsMap = []

    $scope.$watch 'config.datasource', (value) ->
      R2rs.getTables().then((promise) -> $scope.tables = promise) if value?

    $scope.$watch 'rdb.table', (value) ->
      R2rs.getColumnsMap(value).then((promise) -> $scope.columnsMap = promise) if value?

    $scope.$watch 'columnsMap', (value) ->
      if Rdb.table? and value?
        R2rs.getTableData(Rdb.table, value).then (promise) ->
          Rdb.columns = promise.columns
          $scope.data = promise.data
