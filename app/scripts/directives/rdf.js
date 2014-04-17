'use strict';

angular.module('app')
  .directive('rdf', function () {
    return {
      templateUrl: 'partials/rdf.html',
      restrict: 'E'
    };
  });
