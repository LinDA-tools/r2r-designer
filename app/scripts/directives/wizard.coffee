'use strict'

app = angular.module 'r2rDesignerApp'

app.directive 'wizard', () ->
  restrict: 'EA'
  transclude: true
  templateUrl: 'partials/wizard.html'
  controller: ($scope, $document, $timeout) ->
    $scope.wizsteps = []
    
    $scope.$on 'changeSidetip', (event, data) ->
      $timeout () ->
        $scope.sidetip.tmpl = data

    @addStep = (step) ->
      $scope.wizsteps.push step
      if $scope.wizsteps.length == 1
        @goTo step.name

    @getStep = (name) ->
      (i for i in $scope.wizsteps when i.name == name)[0]

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
      index = $scope.wizsteps.indexOf next
      newIndex = fn index
      if index != -1 and
         newIndex >= 0 and
         newIndex < $scope.wizsteps.length and
         $scope.wizsteps[newIndex]?
        @goTo $scope.wizsteps[newIndex].name
      $scope.wizsteps[newIndex].name

    @nextStep = (current) -> @fnStep current, (x) -> ++x
    @prevStep = (current) -> @fnStep current, (x) -> --x

    @isFirst = (name) -> $scope.wizsteps[0].name == name
    @isLast = (name) -> $scope.wizsteps[$scope.wizsteps.length - 1].name == name

    @scrollTo = (name, offs, duration) ->
      section = (document.getElementById name)
      # $document.scrollTo section, offs || 90, duration || 750
      $document.scrollTo 0
    
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
      scope.$emit 'changeSidetip', ''
      newStep = ctrl.nextStep scope.name
      ctrl.scrollTo newStep

app.directive 'prev', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, ctrl) ->
    element.bind 'click', ->
      scope.$emit 'changeSidetip', ''
      newStep = ctrl.prevStep scope.name
      ctrl.scrollTo newStep

app.directive 'goto', ->
  restrict: 'A'
  require: '^wizard'
  link: (scope, element, attrs, ctrl) ->
    element.bind 'click', ->
      scope.$emit 'changeSidetip', ''
      ctrl.goTo attrs.goto
      ctrl.scrollTo attrs.goto
