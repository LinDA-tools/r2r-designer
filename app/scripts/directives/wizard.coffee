'use strict'

app = angular.module 'app'

app.directive 'wizard', () ->
  restrict: 'EA'
  transclude: true
  templateUrl: 'partials/wizard.html'
  controller: ($scope, $document, $timeout) ->
    $scope.steps = []
    
    $scope.$on 'changeSidetip', (event, data) ->
      $timeout () ->
        $scope.sidetip.tmpl = data

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
        $scope.sidetip.tooltip = $scope.currentStep.description

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
      section = (document.getElementById name)
      #$document.scrollTo section, offs || 90, duration || 750

    return

app.directive 'step', () ->
  restrict: 'E'
  require: '^wizard'
  scope:
    name: '@'
    heading: '@'
    description: '@'
    sidetip: '='
  transclude: true
  templateUrl: 'partials/step.html'
  link: (scope, element, attrs, ctrl) ->
    ctrl.addStep
      name: scope.name
      heading: scope.heading
      description: scope.description
      selected: scope.selected

    scope.isSelected = () -> ctrl.getStep(scope.name).selected
    scope.isTreated = () -> ctrl.getStep(scope.name).treated
    scope.isFirst = () -> ctrl.isFirst scope.name
    scope.isLast = () -> ctrl.isLast scope.name

app.directive 'next', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, ctrl) ->
    element.bind 'click', ->
      newStep = ctrl.nextStep scope.name
      ctrl.scrollTo newStep

app.directive 'prev', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, ctrl) ->
    element.bind 'click', ->
      newStep = ctrl.prevStep scope.name
      ctrl.scrollTo newStep

app.directive 'goto', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, ctrl) ->
    element.bind 'click', ->
      ctrl.goTo attrs.goto
      ctrl.scrollTo attrs.goto
