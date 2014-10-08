'use strict'

angular.module 'app'
  .controller 'reconcileCtrl', ($scope, Oracle) ->

    $scope.oracle = Oracle

    $scope.table = 'products'
    $scope.columns = ['ProductID', 'ProductName', 'UnitPrice']
    
    $scope.tableTag = ''
    $scope.columnTags = []

    $scope.suggestions = {
      table: {
        "name":"products",
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
          "name":"ProductID",
          "recommend": [
            {
              "prefixedName":["schema:productID"],
              "uri":["http://schema.org/productID"],
              "score":1
            }
          ]
        },
        {
          "name":"ProductName",
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
      $scope.oracle.ask ($scope.tableTag || $scope.table),
                        ($scope.columnTags || $scope.columns)
        .then (promise) ->
          $scope.suggestions = promise

