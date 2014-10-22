'use strict'

app = angular.module('app')

app.directive 'columntip', () ->
  restrict: 'A'
  controller: ($rootScope) ->
    console.log $rootScope.sidetip.tmpl
    @set = (val) -> $rootScope.sidetip.tmpl = val
    return @
  link: (scope, element, attrs, ctrl) ->
    element.bind 'mouseenter', () ->
      ctrl.set 'foo'
    element.bind 'mouseleave', () ->
      ctrl.set 'bar'
