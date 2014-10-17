'use strict'

angular.module 'app'
  .controller 'dbContentsCtrl', ($scope, Config, Rdb) ->

    $scope.config = Config
    $scope.rdb = Rdb

    $scope.tableColumns = {}

    $scope.$watch 'config.datasource', (value) ->
      if value?
        Rdb.getTables().then (promise) -> $scope.tables = promise

    $scope.$watch 'config.datasource', (value) ->
      if value?
        Rdb.getTableColumns().then (promise) ->
          $scope.tableColumns = promise

    $scope.$watch 'tables', (value) ->
      $scope.rdb.selectedTables = []

    $scope.$watch 'tableColumns', (value) ->
      $scope.rdb.selectedColumns = {}

    $scope.getTables = Rdb.getTables
    $scope.isSelectedTable = (table) -> _.contains $scope.rdb.selectedTables, table
    $scope.isSelectedColumn = (table, column) -> _.contains $scope.rdb.selectedColumns[table], column

    $scope.toggleSelectTable = (table) ->
      if _.contains $scope.rdb.selectedTables, table
        $scope.rdb.selectedTables = _.without $scope.rdb.selectedTables, table
      else
        $scope.rdb.selectedTables.push table

    $scope.toggleSelectColumn = (table, column) ->
      if $scope.tableColumns[table]?
        if _.contains $scope.rdb.selectedColumns[table], column
          $scope.rdb.selectedColumns[table] = _.without $scope.rdb.selectedColumns[table], column
        else
          if $scope.rdb.selectedColumns[table]?
            $scope.rdb.selectedColumns[table].push column
          else
            $scope.rdb.selectedColumns[table] = [column]
