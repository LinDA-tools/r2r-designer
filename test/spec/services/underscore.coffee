'use strict'

describe 'Service: underscore', ->

  # load the service's module
  beforeEach module 'r2rDesignerApp'

  # instantiate service
  underscore = {}
  beforeEach inject (_underscore_) ->
    underscore = _underscore_

  it 'should do something', ->
    expect(!!underscore).toBe true
