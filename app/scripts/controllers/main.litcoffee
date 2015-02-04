# A generic main controller

    'use strict'

    angular.module 'r2rDesignerApp'
      .controller 'MainCtrl', ($scope, _) ->


The project title.

        $scope.title = 'R2R Mapping Designer'

The sidetip holds the description and HTML template which should be displayed as a tooltip on the side.
It is filled by passing messages upwards by the sidetip directive, and is defined here to be accessible
by all sub-controllers.

        $scope.sidetip =
          tooltip: ''
          tmpl: ''
