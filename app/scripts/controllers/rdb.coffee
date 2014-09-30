'use strict'

angular.module 'app'
  #.controller 'RdbCtrl', ($scope, $http, Config, Rdb, R2rs) ->
  .controller 'RdbCtrl', ($scope, RdbFactory) ->



    $scope.tables = RdbFactory.tables
    $scope.tablesEnlisted = RdbFactory.tablesEnlisted

    $scope.enlistTableRow = (enlistment, item) -> 
      console.log item
      item.enlist=enlistment

    #tabName=String, enlistment=boolean  
    $scope.enlistTable = (enlistment, item) -> 
      console.log('item name is '+item)
      item = document.getElementById(item)
      console.log('item is '+item)
      console.log "item :  " + item + "  tagname: "+ item.tagName
      #selectedIndex is -1 if none selected
      if item.tagName is "SELECT" and item.selectedIndex > -1
        tabName = item[item.selectedIndex].value
      else #if item.tagName is "TABLE"
        tabName = item.id.substring(0, item.id.indexOf("_"))
        
      counter = 0
      for tab in $scope.tables
        if tab.tableName is tabName
          break
        counter++
      tab.enlist = enlistment
      console.log(tab+" (name: "+tabName+ ") is set to " + enlistment)

      ###
    $scope.config = Config
    $scope.rdb = Rdb

    $scope.tables = []
    $scope.data = []
    $scope.columnsMap = []

    $scope.$watch 'config.datasource', (value) ->
      if value?
        R2rs.getTables().then (promise) -> $scope.tables = promise

    $scope.$watch 'rdb.table', (value) ->
      if value?
        R2rs.getColumnsMap(value).then (promise) ->
          $scope.columnsMap = promise

    $scope.$watch 'columnsMap', (value) ->
      if Rdb.table? and value?
        console.log Rdb.table
        console.log value
        R2rs.getTableData(Rdb.table, value).then (promise) ->
          Rdb.columns = promise.columns
          $scope.data = promise.data
###

