# The App

The 'r2rDesignerApp' holds the module and it's configuration for the r2r-designer.

    'use strict'

These are the dependencies of the app:

    app = angular.module 'r2rDesignerApp', [
      'ngCookies',
      'ngResource',
      'ngSanitize',
      'ngRoute',
      'ui.bootstrap',
      'duScroll',
      'underscore',
      'angularFileUpload'
    ]

The routes of the app are configured to listen to /csv (default) and /rdb.
You can name distinct controllers to handle the routes, but we will use the same (largely empty) MainCtrl.

    app.config ($routeProvider) ->
      $routeProvider.when '/csv',
        templateUrl: 'partials/main.html'
        controller: 'CsvCtrl'
      .when '/rdb',
        templateUrl: 'partials/main.html'
        controller: 'RdbCtrl'
      .otherwise
        redirectTo: '/csv'
