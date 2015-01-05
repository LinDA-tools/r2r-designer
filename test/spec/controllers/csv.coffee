'use strict'

describe 'Controller: CsvCtrl', ->

  # load the controller's module
  beforeEach module 'r2rDesignerApp'

  CsvCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CsvCtrl = $controller 'CsvCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
