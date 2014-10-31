'use strict'

app = angular.module('app')

app.directive 'badge', ($timeout) ->
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
    tmpl: '@'
  templateUrl: 'partials/badge.html'
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
    # element.popover
    #   trigger: 'hover',
    #   html: true
    #   content: scope.tmpl
    #   placement: 'bottom'
    #   container: attrs['id']
    #   animation: false
    
    # .on 'mouseenter', () ->
      # element.parent().children().on 'mouseleave', () ->
      #   element.popover 'hide'
    # .on 'mouseleave', () ->
    #   console.log 'leave'
    #   element.popover 'hide'
    #   console.log attrs
    #   setTimeout () ->
    #     console.log 'timeout'
    #     console.log element.parent().children()
    #     if !($ '.popover:hover').length
    #       element.popover 'hide'
    #   , 50
     
      # setTimeout () ->
      #   console.log 'timeout'
      #   if !($ '.popover:hover').length
      #     element.popover("hide")
      # , 50
