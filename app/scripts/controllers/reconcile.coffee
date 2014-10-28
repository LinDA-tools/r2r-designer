'use strict'

angular.module 'app'
  .controller 'ReconcileCtrl', ($scope, _, Oracle, Rdb, Rdf) ->

    $scope.rdb = Rdb
    $scope.rdf = Rdf

    $scope.loading = false

    $scope.table = ''
    $scope.tableTag = {}

    $scope.columns = []
    $scope.columnTags = {}

    $scope.suggestions = {}

    $scope.$watch 'rdb.selectedTables()', (val) ->
      if val?
        $scope.table = _.first $scope.rdb.selectedTables()

    $scope.$watch 'table', (val) ->
      if val?
        $scope.columns = $scope.rdb.selectedColumns()[val]

    $scope.ask = (table, columns) ->
      $scope.loading = true
      Oracle.ask table, $scope.tableTag[table], columns, $scope.columnTags
        .then (promise) ->
          $scope.loading = false
          $scope.suggestions[table] = promise

    $scope.getColumnSuggestions = (table, column) ->
      if $scope.suggestions? and $scope.suggestions[table] and $scope.suggestions[table].columns?
        (_.first (_.filter $scope.suggestions[table].columns, (i) -> i.name == column)).recommend

    $scope.selectClass = (table, _class) ->
      if table? and _class?
        if _.contains $scope.rdf.selectedClasses[table], _class
          $scope.rdf.selectedClasses[table] = _.without $scope.rdf.selectedClasses[table], _class
        else
          selected = $scope.rdf.selectedClasses[table] or []
          selected.push _class
          $scope.rdf.selectedClasses[table] = selected

    $scope.selectProperty = (table, column, property) ->
      if table? and column? and property?
        currentTable = $scope.rdf.selectedProperties[table] or {}
        if currentTable[column] == property
          currentTable[column] = null
        else
          currentTable[column] = property
        $scope.rdf.selectedProperties[table] = currentTable

    $scope.isSelectedClass = (table, _class) ->
      _.contains $scope.rdf.selectedClasses[table], _class

    $scope.isSelectedProperty = (table, column, property) ->
      currentTable = $scope.rdf.selectedProperties[table]
      currentTable and (currentTable[column] == property)

    # $scope.suggestions = {
    #   "products" : {
    #     "table" : {
    #       "name" : "products",
    #       "recommend" : [ {
    #         "definition" : [ "This is the largest SuperType and includes any instance offered for sale or performed as a commercial service. Often physical object made by humans that is not a conceptual work or a facility, such as vehicles, cars, trains, aircraft, spaceships, ships, foods, beverages, clothes, drugs, weapons. Products also include the concept of 'state' (e/g/., on/off)" ],
    #         "prefixedName" : [ "umbel:Products" ],
    #         "vocabulary.description" : [ ],
    #         "vocabulary.title" : [ ],
    #         "vocabulary.uri" : [ "http://umbel.org/umbel#" ],
    #         "localName" : [ "Products" ],
    #         "label" : [ ],
    #         "score" : 0.5555555,
    #         "comment" : [ ],
    #         "vocabulary.prefix" : [ "umbel" ],
    #         "uri" : [ "http://umbel.org/umbel#Products" ]
    #       }, {
    #         "definition" : [ ],
    #         "prefixedName" : [ "gr:Offering" ],
    #         "vocabulary.description" : [ ],
    #         "vocabulary.title" : [ ],
    #         "vocabulary.uri" : [ "http://purl.org/goodrelations/v1#" ],
    #         "localName" : [ "Offering" ],
    #         "label" : [ "Offering" ],
    #         "score" : 0.44718835,
    #         "comment" : [ "An offering represents the public, not necessarily binding, not necessarily exclusive, announcement by a gr:BusinessEntity to provide (or seek) a certain gr:BusinessFunction for a certain gr:ProductOrService to a specified target audience. An offering is specified by the type of product or service or bundle it refers to, what business function is being offered (sales, rental, ...), and a set of commercial properties. It can either refer to \n(1) a clearly specified instance (gr:Individual),\n(2) to a set of anonymous instances of a given type (gr:SomeItems),\n(3) a product model specification (gr:ProductOrServiceModel), see also section 3.3.3 of the GoodRelations Technical Report. \n\nAn offering may be constrained in terms of the eligible type of business partner, countries, quantities, and other commercial properties. The definition of the commercial properties, the type of product offered, and the business function are explained in other parts of this vocabulary in more detail.\n\nExample: Peter Miller offers to repair TV sets made by Siemens, Volkswagen Innsbruck sells a particular instance of a Volkswagen Golf at $10,000.\n\nCompatibility with schema.org: This class is a superclass to http://schema.org/Offer, since gr:Offering can also represent demand." ],
    #         "vocabulary.prefix" : [ "gr" ],
    #         "uri" : [ "http://purl.org/goodrelations/v1#Offering" ]
    #       }, {
    #         "definition" : [ ],
    #         "prefixedName" : [ "gr:BusinessEntity" ],
    #         "vocabulary.description" : [ ],
    #         "vocabulary.title" : [ ],
    #         "vocabulary.uri" : [ "http://purl.org/goodrelations/v1#" ],
    #         "localName" : [ "BusinessEntity" ],
    #         "label" : [ "Business entity" ],
    #         "score" : 0.40066153,
    #         "comment" : [ "An instance of this class represents the legal agent making (or seeking) a particular offering. This can be a legal body or a person. A business entity has at least a primary mailing address and contact details. For this, typical address standards (vCard) and location data (geo, WGS84) can be attached. Note that the location of the business entity is not necessarily the location from which the product or service is being available (e.g. the branch or store). Use gr:Location for stores and branches.\n\t\t\nExample: Siemens Austria AG, Volkswagen Ltd., Peter Miller's Cell phone Shop LLC\n\nCompatibility with schema.org: This class is equivalent to the union of http://schema.org/Person and http://schema.org/Organization." ],
    #         "vocabulary.prefix" : [ "gr" ],
    #         "uri" : [ "http://purl.org/goodrelations/v1#BusinessEntity" ]
    #       } ]
    #     },
    #     "columns" : [ {
    #       "name" : "ProductID",
    #       "recommend" : [ {
    #         "definition" : [ ],
    #         "prefixedName" : [ "schema:productID" ],
    #         "vocabulary.description" : [ "Search engines including Bing, Google, Yahoo! and Yandex rely on schema.org markup to improve the display of search results, making it easier for people to find the right web pages." ],
    #         "vocabulary.title" : [ "Schema.org vocabulary" ],
    #         "vocabulary.uri" : [ "http://schema.org/" ],
    #         "localName" : [ "productID" ],
    #         "label" : [ "productID" ],
    #         "score" : 1,
    #         "comment" : [ "The product identifier, such as ISBN. For example: <code>&lt;meta itemprop='productID' content='isbn:123-456-789'/&gt;</code>." ],
    #         "vocabulary.prefix" : [ "schema" ],
    #         "uri" : [ "http://schema.org/productID" ]
    #       } ]
    #     }, {
    #       "name" : "ProductName",
    #       "recommend" : [ {
    #         "definition" : [ ],
    #         "prefixedName" : [ "dicom:ProductName" ],
    #         "vocabulary.description" : [ ],
    #         "vocabulary.title" : [ ],
    #         "vocabulary.uri" : [ "http://purl.org/healthcarevocab/v1#" ],
    #         "localName" : [ "ProductName" ],
    #         "label" : [ "Product Name" ],
    #         "score" : 1,
    #         "comment" : [ ],
    #         "vocabulary.prefix" : [ "dicom" ],
    #         "uri" : [ "http://purl.org/healthcarevocab/v1#ProductName" ]
    #       } ]
    #     } ]
    #   }
    # }
