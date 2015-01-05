'use strict'

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

app.config ($routeProvider) ->
  $routeProvider.when '/csv',
    templateUrl: 'partials/main.html'
    controller: 'CsvCtrl'
  .when '/rdb',
    templateUrl: 'partials/main.html'
    controller: 'RdbCtrl'
  .otherwise
    redirectTo: '/csv'
