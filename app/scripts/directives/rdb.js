'use strict';

angular.module('app')
  .directive('rdb', function () {
    return {
      templateUrl: 'partials/rdb.html',
      restrict: 'E'
    };
  });
