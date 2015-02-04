# The RDB publisher controller  

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'RdbPublishCtrl', ($scope, $timeout, $window, _, Rdb, Rdf, Sml, Transform) ->

        $scope.rdb = Rdb
        $scope.rdf = Rdf
        $scope.sml = Sml
        $scope.transform = Transform

        $scope.publishing = false
        $scope.published = false
        $scope.success = false

This creates an RDF dump of the current database. 'table' is the database table to be transformed. 

        $scope.dump = (table) ->

'mapping' holds the domain object of the mapping specification to be transformed to SML.

          mapping =
            source: 'rdb'
            tables: $scope.rdb.selectedTables()
            columns: $scope.rdb.selectedColumns()
            baseUri: $scope.rdf.baseUri
            subjectTemplate: $scope.rdf.subjectTemplate
            classes: $scope.rdf.selectedClasses
            properties: $scope.rdf.selectedProperties
            literals: $scope.rdf.propertyLiteralSelection
            literalTypes: $scope.rdf.propertyLiteralTypeSelection

Creates the dump and opens a new tab for download (necessary?).

          w = $window.open ''
          $scope.currentMapping = $scope.sml.toSml mapping, table
          $scope.transform.dumpdb $scope.currentMapping
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

        $scope.mapping = (table) ->

The mapping object, see above.

          mapping =
            source: 'rdb'
            tables: $scope.rdb.selectedTables()
            columns: $scope.rdb.selectedColumns()
            baseUri: $scope.rdf.baseUri
            subjectTemplate: $scope.rdf.subjectTemplate
            classes: $scope.rdf.selectedClasses
            properties: $scope.rdf.selectedProperties
            literals: $scope.rdf.propertyLiteralSelection
            literalTypes: $scope.rdf.propertyLiteralTypeSelection
          
Opens a new tab and spits out the mapping as raw text.

          $scope.currentMapping = $scope.sml.toSml mapping, table
          w = $window.open ''
          w.document.open()
          w.document.write '<pre>' + $scope.safe_tags_replace($scope.currentMapping) + '</pre>'
          w.document.close()

        $scope.publish = (to) ->
          $scope.publishing = true

The mapping object, see above.

          mapping =
            source: 'rdb'
            tables: $scope.rdb.selectedTables()
            columns: $scope.rdb.selectedColumns()
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
            .error (data) ->
              console.log 'error: could not connect to server'
              $scope.publishing = false
              $scope.published = true
              $scope.success = false
