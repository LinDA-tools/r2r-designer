'use strict'

describe 'Directive: mappings', ->

  # load the directive's module
  beforeEach module 'r2rDesignerApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<mappings></mappings>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the mappings directive'
