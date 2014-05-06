'use strict';

describe('Service: vocab', function () {

  // load the service's module
  beforeEach(module('r2rDesignerApp'));

  // instantiate service
  var vocab;
  beforeEach(inject(function (_vocab_) {
    vocab = _vocab_;
  }));

  it('should do something', function () {
    expect(!!vocab).toBe(true);
  });

});
