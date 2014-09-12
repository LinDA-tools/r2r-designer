'use strict'

describe 'Service: vocab', ->

  # load the service's module
  beforeEach module 'r2rDesignerApp'

  # instantiate service
  vocab = {}
  beforeEach inject (_vocab_) ->
    vocab = _vocab_

  it 'should do something', ->
    expect(!!vocab).toBe true
