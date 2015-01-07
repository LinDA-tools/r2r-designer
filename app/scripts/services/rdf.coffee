'use strict'

angular.module 'r2rDesignerApp'
  .factory 'Rdf', ->

    baseUri: ''
    subjectTemplate: ''
    propertyLiteralSelection: {}
    propertyLiteralTypes: {}
    selectedClasses: {}
    selectedProperties: {}
    suggestions: {}
