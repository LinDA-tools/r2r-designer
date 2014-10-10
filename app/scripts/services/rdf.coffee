'use strict'

angular.module 'app'
  .factory 'Rdf', ->

    selectedClasses : {}
    selectedProperties : {}

    baseProperties: [
      {
        prefix: 'rdfs'
        prefixedName: 'rdfs:label'
        localName: 'label'
        group: 'base'
      },
      {
        prefix: 'rdfs'
        prefixedName: 'rdfs:comment'
        localName: 'comment'
        group: 'base'
      },
      {
        prefix: 'rdfs'
        prefixedName: 'rdfs:seeAlso'
        localName: 'seeAlso'
        group: 'base'
      },
      {
        prefix: 'dc'
        prefixedName: 'dc:title'
        localName: 'title'
        group: 'base'
      },
      {
        prefix: 'skos'
        prefixedName: 'skos:prefLabel'
        localName: 'prefLabel'
        group: 'base'
      },
      {
        prefix: 'skos'
        prefixedName: 'skos:altLabel'
        localName: 'altLabel'
        group: 'base'
      }
    ],

    baseTypes: [
      {
        prefix: 'rdfs'
        prefixedName: 'rdfs:Resource'
        localName: 'Resource'
        group: 'base'
      },
      {
        prefix: 'rdfs'
        prefixedName: 'rdfs:Literal'
        localName: 'Literal'
        group: 'base'
      },
      {
        prefix: 'rdfs'
        prefixedName: 'rdfs:Class'
        localName: 'Class'
        group: 'base'
      },
      {
        prefix: 'skos'
        prefixedName: 'skos:Concept'
        localName: 'Concept'
        group: 'base'
      }
    ]
