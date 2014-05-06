'use strict';

angular.module('app')
  .controller('RdbCtrl', function ($scope, $http, Config, Rdb, R2rs) {

    $scope.config = Config;
    $scope.rdb = Rdb;
    $scope.tables = [];
    $scope.data = [];
    $scope.columnsMap = [];

    $scope.$watch('config.datasource', function (value) {
      if (value) {
        R2rs.getTables().then(function (promise) {
          $scope.tables = promise;
        });
      }
    });

    $scope.$watch('rdb.table', function (value) {
      if (value) {
        R2rs.getColumnsMap(value).then(function (promise) {
          $scope.columnsMap = promise;
        });
      }
    });

    $scope.$watch('columnsMap', function (value) {
      if (Rdb.table && value) {
        R2rs.getTableData(Rdb.table, value).then(function (promise) {
          Rdb.columns = promise.columns;
          $scope.data = promise.data;
        });
      }
    });
  });
