'use strict'

app = angular.module 'app'

app.directive 'popover', ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    $(elem).popover
      trigger: attrs.popoverTrigger
      html: true
      content: attrs.popoverHtml
      placement: attrs.popoverPlacement
