'use strict'

angular.module 'app'
  .controller 'MainCtrl', ($scope, _) ->
    $scope.sidetip =
      tooltip: ''
      tmpl: ''
