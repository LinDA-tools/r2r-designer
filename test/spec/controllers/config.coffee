'use strict'

describe 'Controller: ConfigCtrl', ->

  # load the controller's module
  beforeEach module 'r2rDesignerApp'

  ConfigCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ConfigCtrl = $controller 'ConfigCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
