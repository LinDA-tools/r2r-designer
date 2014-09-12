'use strict'

describe 'Controller: RdbCtrl', ->

  # load the controller's module
  beforeEach module 'r2rDesignerApp'

  RdbCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    RdbCtrl = $controller 'RdbCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
