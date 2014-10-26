'use strict'

app = angular.module('app')

app.directive 'columntip', () ->
  restrict: 'A'
  controller: ($scope, Rdb) ->
    $scope.rdb = Rdb
    $scope.getData = () ->
      d = $scope.rdb.getColumn 'products', 'ProductName'
      console.log d
  link: (scope, element, attrs, ctrl) ->
    element.bind 'mouseenter', () ->
      tmpl = """
      
      """
      
      data = scope.getData()
      console.log data

      scope.$emit 'changeSidetip', tmpl
    element.bind 'mouseleave', () ->
      scope.$emit 'changeSidetip', ''
