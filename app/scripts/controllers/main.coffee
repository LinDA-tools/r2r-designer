'use strict'

angular.module 'r2rDesignerApp'
  .controller 'MainCtrl', ($scope, _) ->

    $scope.title = 'R2R Mapping Designer'

    $scope.sidetip =
      tooltip: ''
      tmpl: ''
