'use strict';

describe('Directive: config', function () {

  // load the directive's module
  beforeEach(module('app'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<config></config>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the config directive');
  }));
});
