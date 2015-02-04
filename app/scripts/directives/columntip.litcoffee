# The 'columntip' directive

This implements the display of first 20 entries of database columns as a tooltip on the side.
On mouse hover over a column, an HTML template will be propagated to the main controller's sidetip holder.

    'use strict'

    app = angular.module 'r2rDesignerApp'

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
