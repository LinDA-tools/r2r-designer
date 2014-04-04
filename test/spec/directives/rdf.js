'use strict';

describe('Directive: rdf', function () {

  // load the directive's module
  beforeEach(module('app'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<rdf></rdf>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the rdf directive');
  }));
});
