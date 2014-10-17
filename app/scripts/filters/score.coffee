'use strict'

angular.module 'app'
  .filter 'scoreFilter', () ->
    (input) ->
      (Number input).toPrecision 2
