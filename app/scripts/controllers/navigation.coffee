'use strict'

angular.module 'app'
	.controller 'NavigationCtrl', ($scope) ->

		$scope.pointer = 0
		$scope.URLs = ['#/step/connection','#/step/database','#/step/triples']


		$scope.currentURL = () ->
			"#"+document.URL.split('#')[1]


		$scope.adjustPointer = () ->
			curr = $scope.currentURL()
			p = 0
			angular.forEach $scope.URLs, (x) ->
				$scope.pointer = p if x.search(curr) > -1
				p++


		$scope.getCurrentURL = () ->
			$scope.adjustPointer()
			$scope.URLs[$scope.pointer]
		$scope.getNextURL = () ->
			$scope.adjustPointer()
			result = false
			result = $scope.URLs[$scope.pointer+1] if ($scope.pointer < ($scope.URLs.length - 1))
			result			 
		$scope.getPreviousURL = () ->
			$scope.adjustPointer()
			result = false
			result = $scope.URLs[$scope.pointer-1] if $scope.pointer > 0
			result		

		$scope.isCurrentURL = (u) ->
			$scope.adjustPointer()
			result = false
			result = true if document.URL.search(u) > -1
			result

