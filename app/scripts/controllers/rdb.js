'use strict';

angular.module('app')
  .controller('RdbCtrl', function ($scope, $http) {

    $scope.tables = [];
    $scope.data = [];
    $scope.table = '';
    $scope.columns = [];
    $scope.columnsMap = [];

    var host = 'http://localhost:3000/';

    $http.get(host + 'tables').success(function(data) {
      $scope.tables = jsedn.toJS(jsedn.parse(data));
    });

    $scope.$watch('table', function () {
      if ($scope.table !== '') {
        $http.get(host + 'columns?table=' + $scope.table).success(function(data) {
          $scope.columnsMap = jsedn.toJS(jsedn.parse(data));
        });
      }
    });

    $scope.$watch('columnsMap', function () {
      if ($scope.table !== '') {
        $http.get(host + 'table?name=' + $scope.table).success(function(data) {
          var mydata = jsedn.parse(data);
          var columnKeys = mydata.val[0].keys;

          var filterColumns = function (cols, kw) {
            var result = [];
            if (cols) {
              result = cols.filter(function(i) { if (i[0] === kw.name) { return true; } });
            }
            return result[0][1];
          };

          $scope.columns = columnKeys.map(function (i) { return filterColumns($scope.columnsMap, i); });
          $scope.data = mydata.val.map(function (i) { return i.vals; });
        });
      }
    });
  });
