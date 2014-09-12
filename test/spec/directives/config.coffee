'use strict'

describe 'Directive: config', ->

  # load the directive's module
  beforeEach module 'r2rDesignerApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<config></config>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the config directive'
