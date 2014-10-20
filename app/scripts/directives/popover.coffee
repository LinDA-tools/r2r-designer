'use strict'

app = angular.module 'app'

app.directive 'popover', ->
  restrict: 'A'
  link: (scope, elem, attrs) ->
    $(elem).popover
      # trigger: attrs.popoverTrigger
      trigger: 'hover'
      html: true
      content: attrs.popoverHtml
      placement: attrs.popoverPlacement
