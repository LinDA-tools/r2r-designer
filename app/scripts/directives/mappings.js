'use strict';

angular.module('app')
  .directive('mappings', function () {
    return {
      templateUrl: 'partials/mappings.html',
      restrict: 'E'
    };
  });
