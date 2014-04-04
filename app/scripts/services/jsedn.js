'use strict';

angular.module('app')
  .service('jsedn', function jsedn() {
    this.get = function () {
      return jsedn;
    };
  });
