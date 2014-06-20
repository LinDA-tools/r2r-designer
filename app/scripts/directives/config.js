'use strict';

angular.module('app')
  .directive('config', function () {
    return {
      restrict: 'E',
      templateUrl: 'partials/config.html'
    };
  });
