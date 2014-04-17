'use strict';

describe('Controller: RdbCtrl', function () {

  // load the controller's module
  beforeEach(module('app'));

  var RdbCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    RdbCtrl = $controller('RdbCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
