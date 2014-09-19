'use strict'

angular.module 'app'
	.controller 'Playground2Ctrl', ($scope, RdbFactory) ->
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
			else if item.tagName is "TABLE"
				tabName = item.id.substring(0, item.id.indexOf("_"))
				
			counter = 0
			for tab in $scope.tables
				if tab.tableName is tabName
					break
				counter++
			tab.enlist = enlistment
			#console.log(tab+" is set to " + enlistment)
