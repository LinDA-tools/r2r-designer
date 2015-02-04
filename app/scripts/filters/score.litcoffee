Rounds the float score to two decimal positions after comma. 

    'use strict'

    angular.module 'r2rDesignerApp'
      .filter 'scoreFilter', () ->
        (input) ->
          (Number input).toPrecision 2
