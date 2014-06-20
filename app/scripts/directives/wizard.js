'use strict';

var app = angular.module('app');

app.directive('wizard', function () {
  return {
    restrict: 'EA',
    scope: {
    },
    transclude: true,
    templateUrl: function (element, attribute) {
      return attribute.template || 'partials/wizard.html';
    },
    controller: function ($scope, $document, $timeout) {
      $scope.steps = [];

      this.addStep = function (step) {
        $scope.steps.push(step);
        if ($scope.steps.length === 1) {
          this.goTo(step.name);
        }
      };

      this.getStep = function (name) {
        return $scope.steps.filter(function (i) { if (i.name === name) { return true; }})[0];
      };

      this.goTo = function (name) {
        var getStep = this.getStep;
        $timeout(function () {
          var step = getStep(name);
          if ((step !== undefined) &&
              ($scope.currentStep !== undefined)) {
            $scope.currentStep.selected = false;
            $scope.currentStep.treated = true;
          }
          step.selected = true;
          $scope.currentStep = step;
          return;
        });
      };

      this.fnStep = function (current, fn) {
        var next = this.getStep(current);
        var index = $scope.steps.indexOf(next);
        var newIndex = fn(index);
        if (index !== -1 &&
            newIndex >= 0 &&
            newIndex < $scope.steps.length &&
            $scope.steps[newIndex] !== undefined) {
          this.goTo($scope.steps[newIndex].name);
        }
        return $scope.steps[newIndex].name;
      };

      this.nextStep = function (current) { return this.fnStep (current, function (x) { return ++x; }) };
      this.prevStep = function (current) { return this.fnStep (current, function (x) { return --x; }) };

      this.isFirst = function (name) { return $scope.steps[0].name === name; };
      this.isLast = function (name) { return $scope.steps[$scope.steps.length - 1].name === name; };

      this.scrollTo = function (name, offs, duration) {
        var section = angular.element(document.getElementById(name));
        $document.scrollTo(section, offs || 30, duration || 750);
      };
    }
  };
});

app.directive('step', function () {
  return {
    restrict: 'E',
    require: '^wizard',
    scope: {
      name: '@',
      heading: '@',
      description: '@'
    },
    transclude: true,
    templateUrl: function(element, attributes) {
      return attributes.template || 'partials/step.html';
    },
    link: function (scope, element, attrs, wizard) {
      scope.$watch('selected', function () {
      });

      wizard.addStep({
        name: scope.name,
        heading: scope.heading,
        description: scope.description,
        selected: scope.selected
      });

      scope.isSelected = function () { return wizard.getStep(scope.name).selected; };
      scope.isTreated = function () { return wizard.getStep(scope.name).treated; };
      scope.isFirst = function () { return wizard.isFirst(scope.name); };
      scope.isLast = function () { return wizard.isLast(scope.name); };
    }
  };
});

app.directive('next', function () {
  return {
    restrict: 'A',
    require: '^wizard',
    link: function (scope, element, attrs, wizard) {
      element.bind('click', function () {
        var newStep = wizard.nextStep(scope.name);
        wizard.scrollTo(newStep);
      });
    }
  };
});

app.directive('prev', function () {
  return {
    restrict: 'A',
    require: '^wizard',
    link: function (scope, element, attrs, wizard) {
      element.bind('click', function () {
        var newStep = wizard.prevStep(scope.name);
        wizard.scrollTo(newStep);
      });
    }
  };
});

app.directive('goto', function () {
  return {
    restrict: 'A',
    require: '^wizard',
    link: function (scope, element, attrs, wizard) {
      element.bind('click', function () {
        wizard.goTo(attrs.goto);
        wizard.scrollTo(attrs.goto);
      });
    }
  };
});
