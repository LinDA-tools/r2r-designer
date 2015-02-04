# The RDB configuration controller

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'RdbConfigCtrl', ($scope, Rdb) ->

        $scope.rdb = Rdb

        $scope.checking = false
        $scope.checked = false
        $scope.success = false

        $scope.$watch 'rdb.datasource.host', () ->
          $scope.checked = false

        $scope.$watch 'rdb.datasource.driver', () ->
          $scope.checked = false

        $scope.$watch 'rdb.datasource.name', () ->
          $scope.checked = false

        $scope.$watch 'rdb.datasource.username', () ->
          $scope.checked = false

        $scope.$watch 'rdb.datasource.password', () ->
          $scope.checked = false

This tests the database for connectivity and authN/authZ.

        $scope.test = () ->
          $scope.checking = true
          $scope.rdb.checkDatabase $scope.rdb.datasource
            .success (data) ->
              $scope.checking = false
              $scope.checked = true
              $scope.success = (data == "true")
            .error (data) ->
              $scope.checking = false
              $scope.checked = true
              $scope.success = (data == "false")

This checks the database again and applies the changes.
Currently, only one database connection is preserved by the backend!

        $scope.apply = () ->
          $scope.checked = false
          $scope.checking = true
          $scope.rdb.checkDatabase $scope.rdb.datasource
            .success (data) ->
              $scope.checking = false
              $scope.checked = true
              $scope.success = (data == "true")
              $scope.rdb.registerDatabase $scope.rdb.datasource
                .success () ->
                  $scope.rdb.getTables()
                  $scope.rdb.getTableColumns()
                .error () ->
                  console.log 'error: could not connect to server'
            .error (data) ->
              $scope.checking = false
              $scope.checked = true
              $scope.success = (data == "false")
