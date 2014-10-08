'use strict'

angular.module 'app'
  .filter 'score', () ->
    (input) ->
      return input.toPrecision(2)
