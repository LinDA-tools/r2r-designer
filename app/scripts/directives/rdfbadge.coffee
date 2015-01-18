'use strict'

app = angular.module 'r2rDesignerApp'

app.directive 'rdfBadge', ($timeout, $popover) ->
  restrict: 'A'
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
          <span>#{$scope.definition}</span>
          <hr />
        """
      else
        """
          <span class="nodefinition">No definition available!</span>
          <hr />
        """

    vocabDescr =
      if $scope.vocabDescr? and !(_.isEmpty $scope.vocabDescr)
        """
          <span>#{$scope.vocabDescr}</span>
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
          <span>
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
  link: (scope, elem, attrs) ->
    elem.bind 'mouseenter', () ->
      scope.$emit 'changeSidetip', scope.tmpl
    $popover elem,
      content: scope.tmpl
      container: 'body'
      trigger: 'hover'
      html: true
      placement: 'bottom'

    # element.bind 'mouseleave', () ->
    #   scope.$emit 'changeSidetip', ''
