'use strict'

app = angular.module 'app'

app.directive 'wizard', (Sidetip) ->
  restrict: 'EA'
  scope: {}
  transclude: true
  templateUrl: (element, attribute) ->
    attribute.template || 'partials/wizard.html'
  controller: ($scope, $document, $timeout) ->
    $scope.steps = []
    $scope.sidetip = Sidetip.sidetip

    @addStep = (step) ->
      $scope.steps.push step
      if $scope.steps.length == 1
        @goTo step.name

    @getStep = (name) ->
      (i for i in $scope.steps when i.name == name)[0]

    @goTo = (name) ->
      getStep = @getStep
      $timeout ->
        step = getStep name
        if step? and $scope.currentStep?
          $scope.currentStep.selected = false
          $scope.currentStep.treated = true
        step.selected = true
        $scope.currentStep = step

    @fnStep = (current, fn) ->
      next = @getStep current
      index = $scope.steps.indexOf next
      newIndex = fn index
      if index != -1 and
         newIndex >= 0 and
         newIndex < $scope.steps.length and
         $scope.steps[newIndex]?
        @goTo $scope.steps[newIndex].name
      $scope.steps[newIndex].name

    @nextStep = (current) -> @fnStep current, (x) -> ++x
    @prevStep = (current) -> @fnStep current, (x) -> --x

    @isFirst = (name) -> $scope.steps[0].name == name
    @isLast = (name) -> $scope.steps[$scope.steps.length - 1].name == name

    @scrollTo = (name, offs, duration) ->
      section = angular.element document.getElementById name
      $document.scrollTo section, offs || 30, duration || 750

    return

app.directive 'step', (Sidetip) ->
  restrict: 'E'
  require: '^wizard'
  scope:
    name: '@'
    heading: '@'
    sidetip: '='
    # description: '@'
  transclude: true
  templateUrl: 'partials/step.html'
  controller: ($rootScope) ->
    $rootScope.sidetip = Sidetip
    $rootScope.$watch 'sidetip.tmpl', (value) ->
      alert value if value?
  link: (scope, element, attrs, wizard) ->
    wizard.addStep
      name: scope.name
      heading: scope.heading
      # description: scope.description
      selected: scope.selected

    scope.isSelected = () -> wizard.getStep(scope.name).selected
    scope.isTreated = () -> wizard.getStep(scope.name).treated
    scope.isFirst = () -> wizard.isFirst scope.name
    scope.isLast = () -> wizard.isLast scope.name

app.directive 'next', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, wizard) ->
    element.bind 'click', ->
      newStep = wizard.nextStep scope.name
      wizard.scrollTo newStep

app.directive 'prev', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, wizard) ->
    element.bind 'click', ->
      newStep = wizard.prevStep scope.name
      wizard.scrollTo newStep

app.directive 'goto', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, wizard) ->
    element.bind 'click', ->
      wizard.goTo attrs.goto
      wizard.scrollTo attrs.goto
