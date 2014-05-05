'use strict';

angular.module('app')
  .controller('RdbCtrl', function ($scope, $http, Rdb, Rdf, Jsedn) {

    $scope.rdb = Rdb;
    $scope.rdf = Rdf;
    $scope.jsedn = Jsedn;

    $http.get($scope.rdb.host + 'tables').success(function(data) {
      $scope.rdb.tables = $scope.jsedn.toJS($scope.jsedn.parse(data));
    });

    $scope.$watch('rdb.table', function (value) {
      if (value) {
        $http.get($scope.rdb.host + 'columns?table=' + value).success(function(data) {
          $scope.rdb.columnsMap = $scope.jsedn.toJS($scope.jsedn.parse(data));
        });
      }
    });

    $scope.$watch('rdb.columnsMap', function (value) {
      if ($scope.rdb.table && value) {
        $http.get($scope.rdb.host + 'table?name=' + $scope.rdb.table).success(function(data) {
          var mydata = $scope.jsedn.parse(data);
          var columnKeys = mydata.val[0].keys;

          var filterColumns = function (cols, kw) {
            var result = [];
            if (cols) {
              result = cols.filter(function(i) { if (i[0] === kw.name) { return true; } });
            }
            if (result[0] && result[0][1]) {
              return result[0][1];
            } else {
              return [];
            }
          };

          $scope.rdb.columns = columnKeys.map(function (i) { return filterColumns(value, i); });
          $scope.rdb.data = mydata.val.map(function (i) { return i.vals; });
        });
      }
    });
  });
