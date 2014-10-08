'use strict'

angular.module 'app'
  .controller 'dbContentsCtrl', ($scope, Config, Rdb) ->

    $scope.config = Config
    $scope.rdb = Rdb

    # $scope.tables = ''
    $scope.tableColumns = {}
    $scope.selectedTables = []
    $scope.selectedColumns = {}

    $scope.$watch 'config.datasource', (value) ->
      if value?
        Rdb.getTables().then (promise) -> $scope.tables = promise

    $scope.$watch 'config.datasource', (value) ->
      if value?
        Rdb.getTableColumns().then (promise) ->
          $scope.tableColumns = promise

    $scope.$watch 'tables', (value) ->
      $scope.selectedTables = []

    $scope.$watch 'tableColumns', (value) ->
      $scope.selectedColumns = {}

    $scope.getTables = Rdb.getTables
    $scope.isSelectedTable = (table) -> _.contains $scope.selectedTables, table
    $scope.isSelectedColumn = (table, column) -> _.contains $scope.selectedColumns[table], column

    $scope.toggleSelectTable = (table) ->
      if _.contains $scope.selectedTables, table
        $scope.selectedTables = _.without $scope.selectedTables, table
      else
        $scope.selectedTables.push table

    $scope.toggleSelectColumn = (table, column) ->
      if $scope.tableColumns[table]?
        if _.contains $scope.selectedColumns[table], column
          $scope.selectedColumns[table] = _.without $scope.selectedColumns[table], column
        else
          if $scope.selectedColumns[table]?
            $scope.selectedColumns[table].push column
          else
            $scope.selectedColumns[table] = [column]
