'use strict'

describe 'Service: jsedn', ->

  # load the service's module
  beforeEach module 'r2rDesignerApp'

  # instantiate service
  jsedn = {}
  beforeEach inject (_jsedn_) ->
    jsedn = _jsedn_

  it 'should do something', ->
    expect(!!jsedn).toBe true
