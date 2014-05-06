'use strict';

angular.module('app')
  .directive('vocab', function () {
    return {
      templateUrl: 'partials/vocab.html',
      restrict: 'E'
    };
  });

