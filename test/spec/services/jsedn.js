'use strict';

describe('Service: Jsedn', function () {

  // load the service's module
  beforeEach(module('app'));

  // instantiate service
  var Jsedn;
  beforeEach(inject(function (_Jsedn_) {
    Jsedn = _Jsedn_;
  }));

  it('should do something', function () {
    expect(!!Jsedn).toBe(true);
  });

});
