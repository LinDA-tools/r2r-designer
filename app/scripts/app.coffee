'use strict'

app = angular.module 'app', [
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
    templateUrl: 'partials/csvtrans.html'
    controller: 'MainCtrl'
  .when '/rdb',
    templateUrl: 'partials/rdbtrans.html'
    controller: 'MainCtrl'
  .otherwise
    redirectTo: '/csv'
