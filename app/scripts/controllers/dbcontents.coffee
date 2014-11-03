'use strict'

angular.module 'app'
  .controller 'DbContentsCtrl', ($scope, Rdb) ->

    $scope.rdb = Rdb
