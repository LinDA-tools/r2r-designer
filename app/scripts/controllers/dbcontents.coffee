'use strict'

angular.module 'app'
  .controller 'dbContentsCtrl', ($scope, Rdb) ->
    $scope.rdb = Rdb
