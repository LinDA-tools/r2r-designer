'use strict';

describe('Service: Rdf', function () {

  // load the service's module
  beforeEach(module('r2rDesignerApp'));

  // instantiate service
  var Rdf;
  beforeEach(inject(function (_Rdf_) {
    Rdf = _Rdf_;
  }));

  it('should do something', function () {
    expect(!!Rdf).toBe(true);
  });

});
