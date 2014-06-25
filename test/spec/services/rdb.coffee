'use strict'

describe 'Service: rdb', ->

  # load the service's module
  beforeEach module 'r2rDesignerApp'

  # instantiate service
  rdb = {}
  beforeEach inject (_rdb_) ->
    rdb = _rdb_

  it 'should do something', ->
    expect(!!rdb).toBe true
