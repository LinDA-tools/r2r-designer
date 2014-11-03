'use strict'

app = angular.module('app')

app.directive 'columntip', () ->
  restrict: 'A'
  scope:
    table: '@'
    column: '@'
  controller: ($scope, Rdb) ->
    $scope.rdb = Rdb
    $scope.getData = () -> $scope.rdb.getColumn $scope.table, $scope.column

  link: (scope, element, attrs, ctrl) ->
    element.bind 'mouseenter', () ->
      
      scope.getData().success (data) ->
        tmpl = _.foldl (_.take data, 20), ((x, y) -> (x + "<br />").concat(y))
        if (_.size data) > 20
          tmpl += '<br />...'
        scope.$emit 'changeSidetip', tmpl

    element.bind 'mouseleave', () ->
      scope.$emit 'changeSidetip', ''
