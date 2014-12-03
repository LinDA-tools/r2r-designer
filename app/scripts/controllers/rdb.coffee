'use strict'

angular.module 'app'
	#.controller 'RdbCtrl', ($scope, $http, Config, Rdb, R2rs) ->
	.controller 'RdbCtrl', ($scope, RdbFactory) ->

		$scope.tablesOriginal = RdbFactory.tables
		$scope.tablesUIEnriched = RdbFactory.tablesUIEnriched

		###
		This will add variables to the database object that are needed for the ui representation
		enlist = choose for conversion to triples
		expand = expand view and show colums for tables, resp values for columns
		###
		$scope.enrichUIMeta = (tableObj) ->
			result = tableObj
			for tab in result #table behaviour
				tab["enlist"]=true
				tab["expand"]=true
				for col in tab.columns #column behaviour
					col["enlist"]=true
					col["expand"]=false
			return result
		
		#additional fields for ui functionalities woll be added by $scope.enrichUIMeta
		if typeof $scope.tablesUIEnriched is "undefined"
			$scope.tablesUIEnriched=$scope.enrichUIMeta($scope.tablesOriginal)
			RdbFactory["tablesUIEnriched"]=$scope.tablesUIEnriched

		null