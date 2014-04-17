'use strict';

angular.module('app')
  .directive('config', function () {
    return {
      templateUrl: 'partials/config.html',
      restrict: 'E'
    };
  });
