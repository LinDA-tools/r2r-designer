'use strict'

angular.module 'app'
  .controller 'reconcileCtrl', ($scope, Oracle, Rdf) ->

    $scope.table = 'products'
    $scope.tableTag = ''

    $scope.columns = ['ProductID', 'ProductName', 'UnitPrice']
    $scope.columnTags = {}

    $scope.selectedClasses = Rdf.selectedClasses
    $scope.selectedProperties = Rdf.selectedProperties

    $scope.suggestions = {
      table: {
        "name": "products",
        "recommend": [
          {
            "prefixedName":["umbel:Products"],
            "uri":["http://umbel.org/umbel#Products"],
            "score":0.5555555
          },
          {
            "prefixedName":["gr:Offering"],
            "uri":["http://purl.org/goodrelations/v1#Offering"],
            "score":0.44718835
          },
          {
            "prefixedName":["gr:BusinessEntity"],
            "uri":["http://purl.org/goodrelations/v1#BusinessEntity"],
            "score":0.40066153
          }
        ]
      },
      columns: [
        {
          "name": "ProductID",
          "recommend": [
            {
              "prefixedName":["schema:productID"],
              "uri":["http://schema.org/productID"],
              "score":1
            }
          ]
        },
        {
          "name": "ProductName",
          "recommend": [
            {
              "prefixedName":["dicom:ProductName"],
              "uri":["http://purl.org/healthcarevocab/v1#ProductName"],
              "score":1
            }
          ]
        },
        {"name":"UnitPrice", "recommend":[]}
      ]
    }

    $scope.ask = () ->
      Oracle.ask $scope.table, $scope.tableTag, $scope.columns, $scope.columnTags
        .then (promise) ->
          $scope.suggestions = promise

    $scope.selectClass = (table, _class) ->
      if table? and _class?
        $scope.selectedClasses[table] = _class

    $scope.selectProperty = (table, column, property) ->
      if table? and column? and property?
        currentTable = $scope.selectedProperties[table] or {}
        currentTable[column] = property
        $scope.selectedProperties[table] = currentTable

    $scope.isSelectedClass = (table, _class) ->
      $scope.selectedClasses[table] == _class

    $scope.isSelectedProperty = (table, column, property) ->
      currentTable = $scope.selectedProperties[table]
      currentTable and (currentTable[column] == property)
