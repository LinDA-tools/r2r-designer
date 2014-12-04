'use strict'

angular.module 'app'
  .factory 'Rdf', ->

    baseUri: ''
    subjectTemplate: ''
    propertyLiteralSelection: {}
    propertyLiteralTypes: {}
    selectedClasses: {}
    selectedProperties: {}
    suggestions: {}
