'use strict'

app = angular.module('app')

app.directive 'rdftip', () ->
  restrict: 'A'
  scope:
    rdfelem: '@'
  # controller: ($scope) ->
  link: (scope, element, attrs, ctrl) ->
    element.bind 'mouseenter', () ->
      scope.$emit 'changeSidetip', 'rdf'

    element.bind 'mouseleave', () ->
      scope.$emit 'changeSidetip', ''
