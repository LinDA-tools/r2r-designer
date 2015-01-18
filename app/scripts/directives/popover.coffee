'use strict'

app = angular.module 'r2rDesignerApp'

app.directive 'popover', ($popover) ->
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
  contentTemplate: 'partials/rdfbadge.html'
  link: (scope, elem, attrs) ->
    $popover elem,
      trigger: 'hover'
      html: true
      placement: 'bottom'
