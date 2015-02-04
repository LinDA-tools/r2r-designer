# The RDB content controller

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'RdbContentsCtrl', ($scope, Rdb) ->

        $scope.rdb = Rdb
