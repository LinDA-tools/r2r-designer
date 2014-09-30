'use strict'

angular.module 'app'
  .controller 'TriplesCtrl', ($scope, $http, R2rs, Oracle) ->

    # $scope.config = Config
    # $scope.rdb = Rdb
    $scope.oracle = Oracle
    $scope.ask = () ->
      $scope.oracle.ask ($scope.tableTag || $scope.table),
                        ($scope.columnTags || $scope.columns)
        .then (promise) ->
          $scope.suggestions = promise

    $scope.table = 'products'
    $scope.columns = ['ProductID', 'ProductName', 'UnitPrice']

    $scope.tableTag = ''
    $scope.columnTags = []

    $scope.tables = ['categories','customers','customercustomerdemo','customerdemographics','employees','employeeterritories','order_details','orders','products','region','shippers','shippers_tmp','suppliers','territories','usstates']
    $scope.tableColumns = {
      'products': ['ProductID', 'ProductName', 'SupplierID', 'CategoryID', 'QuantityPerUnit', 'UnitPrice', 'UnitsInStock', 'UnitsOnOrder', 'ReorderLevel', 'Discontinued']
      'customers': ['CustomerID', 'CompanyName', 'ContactName', 'ContactTitle', 'Address', 'City', 'Region', 'PostalCode', 'Country', 'Phone', 'Fax']
      'employees': ['EmployeeID', 'LastName', 'FirstName', 'Title', 'TitleOfCourtesy', 'BirthDate', 'HireDate', 'Address', 'City', 'Region', 'PostalCode',
                    'Country', 'HomePhone', 'Extension', 'Photo', 'Notes', 'ReportsTo', 'PhotoPath']
      'customercustomerdemo':['CustomerID', 'CustomerTypeID'],
      'suppliers': ['SupplierID', 'CompanyName', 'ContactName', 'ContactTitle', 'Address', 'City', 'Region', 'PostalCode', 'Country', 'Phone', 'Fax', 'HomePage']
      'categories': ['CategoryID', 'CategoryName', 'Description', 'Picture'],
      'customerdemographics':['CustomerTypeID', 'CustomerDesc'],
      'region':['RegionID', 'RegionDescription'],
      'shippers':['ShipperID', 'CompanyName', 'Phone']
      'shippers_tmp':['ShipperID', 'CompanyName', 'Phone'],
      'usstates':['StateID', 'StateName', 'StateAbbr', 'StateRegion'],
      'employeeterritories':['EmployeeID', 'TerritoryID']
      'order_details': ['OrderID', 'ProductID', 'UnitPrice', 'Quantity', 'Discount']
      'orders': ['OrderID', 'CustomerID', 'EmployeeID', 'OrderDate', 'RequiredDate', 'ShippedDate', 'ShipVia', 'Freight', 'ShipName', 'ShipAddress',
      'ShipCity', 'ShipRegion', 'ShipPostalCode', 'ShipCountry']
      'territories':['TerritoryID', 'TerritoryDescription', 'RegionID']
    }
    $scope.selectedTables = ['products']
    $scope.selectedColumns = {}
    # $scope.data = []
    # $scope.columnsMap = []

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
    $scope.getTables = R2rs.getTables

    $scope.isSelectedTable = (table) -> _.contains $scope.selectedTables, table
    $scope.isSelectedColumn = (table, column) -> _.contains $scope.selectedColumns[table], column
    
    # $scope.$watch 'config.datasource', (value) ->
    #   if value?
    #     R2rs.getTables().then (promise) -> $scope.tables = promise

    # $scope.$watch 'config.datasource', (value) ->
    #   if value?
    #     R2rs.getTableColumns().then (promise) -> $scope.tableColumns = promise

    # $scope.$watch 'rdb.table', (value) ->
    #   if value?
    #     R2rs.getColumnsMap(value).then (promise) ->
    #       $scope.columnsMap = promise

    # $scope.$watch 'tables', (value) ->
    #   $scope.selectedTables = []

    # $scope.$watch 'tableColumns', (value) ->
    #   $scope.selectedColumns = {}

    $scope.toggleSelectTable = (table) ->
      if _.contains $scope.selectedTables, table
        $scope.selectedTables = _.without $scope.selectedTables, table
      else
        $scope.selectedTables.push table

    $scope.toggleSelectColumn = (table, column) ->
      if $scope.tableColumns[table]?
        if _.contains $scope.selectedColumns[table], column
          $scope.selectedColumns[table] = _.without $scope.selectedColumns[table], column
        else
          if $scope.selectedColumns[table]?
            $scope.selectedColumns[table].push column
          else
            $scope.selectedColumns[table] = [column]
