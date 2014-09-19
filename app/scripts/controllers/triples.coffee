'use strict'

angular.module 'app'
  .controller 'TriplesCtrl', ($scope, RdbFactory) ->

    $scope.tables = RdbFactory.tables
    $scope.test = 'test success'
