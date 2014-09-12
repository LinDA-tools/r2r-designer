'use strict'

describe 'Controller: RdfCtrl', ->

  # load the controller's module
  beforeEach module 'r2rDesignerApp'

  RdfCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    RdfCtrl = $controller 'RdfCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
