'use strict'

app = angular.module 'r2rDesignerApp'

app.directive 'cursor', () ->
  restrict: 'A'
  scope:
    content: '='
    cursorpos: '='
  controller: ($scope) ->
  link: (scope, element, attrs) ->
    element.on 'keyup', () ->
      scope.cursorpos = element.prop 'selectionStart'
      scope.$apply()
    element.on 'click', () ->
      scope.cursorpos = element.prop 'selectionStart'
      scope.$apply()
