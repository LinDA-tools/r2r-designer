'use strict';

angular.module('app')
  .controller('RdbCtrl', function ($scope, $http, Config, Rdb, Rdf) {

    $scope.config = Config;
    $scope.rdb = Rdb;
    $scope.rdf = Rdf;

    $scope.tables = [];
    $scope.data = [];
    $scope.columnsMap = [];

    $scope.$watch('config.datasource', function (value) {
      if (value) {
        $scope.rdb.getTables().then(function (promise) {
          $scope.tables = promise;
        });
      }
    });

    $scope.$watch('rdb.table', function (value) {
      if (value) {
        $scope.rdb.getColumnsMap(value).then(function (promise) {
          $scope.columnsMap = promise;
        });
      }
    });

    $scope.$watch('columnsMap', function (value) {
      if ($scope.rdb.table && value) {
        $scope.rdb.getTableData($scope.rdb.table, value).then(function (promise) {
          $scope.rdb.columns = promise.columns;
          $scope.data = promise.data;
        });
      }
    });
  });
