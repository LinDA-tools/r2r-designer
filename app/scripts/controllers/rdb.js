'use strict';

angular.module('app')
  .controller('RdbCtrl', function ($scope, $http) {

    var host = 'http://localhost:3000/';
    $scope.tables = [];

    $http.get(host + 'tables').success(function(data) {
      $scope.tables = jsedn.toJS(jsedn.parse(data));
    });
  });
