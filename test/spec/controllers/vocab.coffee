'use strict'

describe 'Controller: VocabCtrl', ->

  # load the controller's module
  beforeEach module 'r2rDesignerApp'

  VocabCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    VocabCtrl = $controller 'VocabCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
