'use strict'

angular.module 'app'
  .controller 'dbContentsCtrl', ($scope, Rdb, Sidetip) ->

    $scope.rdb = Rdb
    $scope.sidetip = Sidetip

    # $scope.$watch 'rdb.datasource', (value) ->
    #   if value?
    #     Rdb.getTables().then (promise) -> $scope.tables = promise

    # $scope.$watch 'rdb.datasource', (value) ->
    #   if value?
    #     Rdb.getTableColumns().then (promise) ->
    #       $scope.tableColumns = promise

    # $scope.$watch 'rdb.tables', (value) ->
    #   $scope.rdb.selectedTables = []

    # $scope.$watch 'rdb.tableColumns', (value) ->
    #   $scope.rdb.selectedColumns = {}
