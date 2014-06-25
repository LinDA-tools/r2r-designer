'use strict'

describe 'Service: r2rs', ->

  # load the service's module
  beforeEach module 'r2rDesignerApp'

  # instantiate service
  r2rs = {}
  beforeEach inject (_r2rs_) ->
    r2rs = _r2rs_

  it 'should do something', ->
    expect(!!r2rs).toBe true
