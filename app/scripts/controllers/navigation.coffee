'use strict'

angular.module 'app'
	.controller 'NavigationCtrl', ($scope, $route) ->

		$route.reloadOnSearch =false;

		$scope.step = 0
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
			#$scope.adjustStep()
			$scope.GuideTexts[$scope.step]


		$scope.currentURL = () ->
			"#"+document.URL.split('#')[1]

		$scope.CssClassNextStep = "";
		$scope.CssClassPreviousStep = "";

		#adjusts step pointer to recent browser URL, see $scope.URLs
		$scope.adjustStep = () ->
			curr = $scope.currentURL()
			p = 0
			angular.forEach $scope.URLs, (x) ->
				$scope.step = p if x.search(curr) > -1
				p++

			if $scope.isLastURL()
				$scope.CssClassNextStep = "disabled" 
			else
				$scope.CssClassNextStep = ""

			if $scope.getPreviousURL() is not false
				$scope.CssClassPreviousStep = "disabled"
			else
				$scope.CssClassPreviousStep = ""
		
		###
		$scope.$watch $location.url(), (newValue, oldValue) ->
			console.log("URL changed from " + oldValue + " to " + newValue)
			true
		###

		#fires every time the url changes
		$scope.$on '$routeChangeSuccess', () ->
			$scope.adjustStep()
			console.log("adjusted step");

		$scope.getCurrentURL = () ->
			#$scope.adjustStep()
			$scope.URLs[$scope.step]

		$scope.getNextURL = () ->
			#$scope.adjustStep()
			result = false
			result = $scope.URLs[$scope.step+1] if ($scope.step < ($scope.URLs.length - 1))
			result
		$scope.isLastURL = () ->
			return true if $scope.getNextURL() is not false
			false

		$scope.getPreviousURL = () ->
			#$scope.adjustStep()
			result = false
			result = $scope.URLs[$scope.step-1] if $scope.step > 0
			result
		$scope.isFirstURL = () ->
			return true if $scope.getPreviousURL() is not false
			false		

		$scope.isCurrentURL = (u) ->
			#$scope.adjustStep()
			result = false
			result = true if document.URL.search(u) > -1
			result

		


