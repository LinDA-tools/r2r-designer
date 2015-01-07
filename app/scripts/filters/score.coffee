'use strict'

angular.module 'r2rDesignerApp'
  .filter 'scoreFilter', () ->
    (input) ->
      (Number input).toPrecision 2
