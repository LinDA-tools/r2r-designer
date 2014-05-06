'use strict';

describe('Service: r2rTe', function () {

  // load the service's module
  beforeEach(module('r2rDesignerApp'));

  // instantiate service
  var r2rTe;
  beforeEach(inject(function (_r2rTe_) {
    r2rTe = _r2rTe_;
  }));

  it('should do something', function () {
    expect(!!r2rTe).toBe(true);
  });

});
