'use strict'

app = angular.module('app')

app.directive 'rdfBadge', ($timeout) ->
  restrict: 'A'
  replace: true
  scope:
    uri: '@'
    label: '@'
    local: '@'
    prefixed: '@'
    definition: '@'
    vocabUri: '@'
    vocabTitle: '@'
    vocabDescr: '@'
    score: '@'
  templateUrl: 'partials/rdfbadge.html'
  controller: ($scope) ->
    definition =
      if $scope.definition and !(_.isEmpty $scope.definition)
        """
        <span style="margin-left:1em">
          #{$scope.definition}
        </span>
        <hr />
        """
      else
        """
        <span style="margin-left:1em;font-style:italic;color:#dddddd">
          No definition available!
        </span>
        <hr />
        """

    vocabDescr =
      if $scope.vocabDescr? and !(_.isEmpty $scope.vocabDescr)
        """
          <span style="margin-left:1em">
            #{$scope.vocabDescr}
          </span>
        """
      else
        ""

    vocabulary =
      if $scope.vocabTitle? and !(_.isEmpty $scope.vocabTitle)
        """
        <h4>
          <sup>2</sup>#{$scope.vocabTitle}
        </h4>
        <span>
          &rarr;&nbsp;<a href="#{$scope.vocabUri}">#{$scope.vocabUri}</a>
        </span><br /><br />
        <span style="margin-left:1em">
          #{$scope.vocabDescr}
        </span>
        <hr />
        """
      else
        """
        <h5>
          <sup>2</sup>&rarr;&nbsp;<a href="#{$scope.vocabUri}">#{$scope.vocabUri}</a>
        </h5>
        #{vocabDescr}
        <hr />
        """

    $scope.tmpl = """
    <h4><sup>1</sup>#{$scope.label or $scope.local}</h4>
    <span>&rarr;&nbsp;<a href="#{$scope.uri}">#{$scope.uri}</a></span><br /><br />
    #{definition}
    #{vocabulary}
    <span class="score">score: #{$scope.score}</span>
    """
  link: (scope, element, attrs) ->
    element.bind 'mouseenter', () ->
      scope.$emit 'changeSidetip', scope.tmpl

    # element.bind 'mouseleave', () ->
    #   scope.$emit 'changeSidetip', ''
