'use strict';

describe('Service: lov', function () {

  // load the service's module
  beforeEach(module('r2rDesignerApp'));

  // instantiate service
  var lov;
  beforeEach(inject(function (_lov_) {
    lov = _lov_;
  }));

  it('should do something', function () {
    expect(!!lov).toBe(true);
  });

});
