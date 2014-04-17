'use strict';

describe('Controller: RdfCtrl', function () {

  // load the controller's module
  beforeEach(module('app'));

  var RdfCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    RdfCtrl = $controller('RdfCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
