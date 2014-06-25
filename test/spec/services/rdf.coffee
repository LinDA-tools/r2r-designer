'use strict'

describe 'Service: rdf', ->

  # load the service's module
  beforeEach module 'r2rDesignerApp'

  # instantiate service
  rdf = {}
  beforeEach inject (_rdf_) ->
    rdf = _rdf_

  it 'should do something', ->
    expect(!!rdf).toBe true
