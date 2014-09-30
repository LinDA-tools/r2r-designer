'use strict'

describe 'Controller: DbcontentsctrlCtrl', ->

  # load the controller's module
  beforeEach module 'r2rDesignerApp'

  DbcontentsctrlCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DbcontentsctrlCtrl = $controller 'DbcontentsctrlCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
