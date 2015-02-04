# The CSV publisher controller  

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'CsvPublishCtrl', ($scope, $timeout, $window, _, Csv, Rdf, Sml, Transform) ->

        $scope.csv = Csv
        $scope.rdf = Rdf
        $scope.sml = Sml
        $scope.transform = Transform

        $scope.publishing = false
        $scope.published = false
        $scope.success = false

This creates an RDF dump of the current CSV file. 'table' is therefore a placeholder for the CSV's name.

        $scope.dump = (table) ->

'mapping' holds the domain object of the mapping specification to be transformed to SML.

          mapping =
            source: 'csv'
            tables: $scope.csv.selectedTables()
            columns: $scope.csv.selectedColumns()
            baseUri: $scope.rdf.baseUri
            subjectTemplate: $scope.rdf.subjectTemplate
            classes: $scope.rdf.selectedClasses
            properties: $scope.rdf.selectedProperties
            literals: $scope.rdf.propertyLiteralSelection
            literalTypes: $scope.rdf.propertyLiteralTypeSelection

Creates the dump and opens a new tab for download (necessary?).

          w = $window.open ''
          $scope.currentMapping = $scope.sml.toSml mapping, table
          $scope.transform.dumpcsv $scope.currentMapping
            .then (url) ->
              w.location = url

Replaces some chars to not infere with the HTML output. 

        $scope.safe_tags_replace = (str) ->
          tagsToReplace =
            '&': '&amp;'
            '<': '&lt;'
            '>': '&gt;'

          replaceTag = (tag) ->
            tagsToReplace[tag] or tag

          str.replace /[&<>]/g, replaceTag

        $scope.mapping = () ->

The mapping object, see above.

          mapping =
            source: 'csv'
            tables: $scope.csv.selectedTables()
            columns: $scope.csv.selectedColumns()
            baseUri: $scope.rdf.baseUri
            subjectTemplate: $scope.rdf.subjectTemplate
            classes: $scope.rdf.selectedClasses
            properties: $scope.rdf.selectedProperties
            literals: $scope.rdf.propertyLiteralSelection
            literalTypes: $scope.rdf.propertyLiteralTypeSelection
          
Opens a new tab and spits out the mapping as raw text.

          $scope.currentMapping = $scope.sml.toSml mapping
          w = $window.open ''
          w.document.open()
          w.document.write '<pre>' + $scope.safe_tags_replace($scope.currentMapping) + '</pre>'
          w.document.close()

This publiches the dump to a known data server. 'to' is hard-coded to be either 'sparqlify' or 'openrdf'.

        $scope.publish = (to) ->
          $scope.publishing = true

The mapping object, see above.

          mapping =
            source: 'csv'
            tables: $scope.csv.selectedTables()
            columns: $scope.csv.selectedColumns()
            baseUri: $scope.rdf.baseUri
            subjectTemplate: $scope.rdf.subjectTemplate
            classes: $scope.rdf.selectedClasses
            properties: $scope.rdf.selectedProperties
            literals: $scope.rdf.propertyLiteralSelection
            literalTypes: $scope.rdf.propertyLiteralTypeSelection
          
          $scope.currentMapping = $scope.sml.toSml mapping

Calls the publish service with the current mapping.

          $scope.transform.publish to, $scope.currentMapping
            .success (data) ->
              $scope.publishing = false
              $scope.published = true
              $scope.success = true
            .error () ->
              console.log 'error: could not connect to server'
              $scope.publishing = false
              $scope.published = true
              $scope.success = false
