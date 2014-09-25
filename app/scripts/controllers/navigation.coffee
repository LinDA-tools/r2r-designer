'use strict'

angular.module 'app'
	.controller 'NavigationCtrl', ($scope) ->

		$scope.pointer = 0
		#wizard pages, in right order
		$scope.URLs = [
			"#/step/connection"
			"#/step/database"
			"#/step/triples"
			]
		#put wizard page description (as html) in same order as $scope.URLs
		$scope.GuideTexts = [
			"<p>First, choose a database and enter connection details.</p><p>The chosen database must provide the tables that you want to transform and provide as semantic data / RDF triples.</p>"
			"<p>In this step, select the tables and respective rows that you want to provide as semantic data.</p><p>Toggle the eye symbol <span class=\"glyphicon glyphicon-eye-open\"></span> to select or deselect tables or rows.</span></p>"
			"Here..."
			]

		$scope.getGuideText = () ->
			$scope.adjustPointer()
			$scope.GuideTexts[$scope.pointer]


		$scope.currentURL = () ->
			"#"+document.URL.split('#')[1]

		#adjusts pointer to recent browser URL, see $scope.URLs
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

		


