'use strict'

angular.module 'r2rDesignerApp'
  .controller 'DbContentsCtrl', ($scope, Rdb) ->

    $scope.rdb = Rdb
