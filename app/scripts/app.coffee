'use strict'

app = angular.module('app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ui.bootstrap',
  'duScroll',
  'underscore'
])

app.config ($routeProvider) ->
#app.config '$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'partials/start.html'
      controller: 'StartCtrl'
    .when '/step/connection',
      templateUrl: 'partials/config.html'
      controller: 'ConfigCtrl'
    .when '/step/database',
      templateUrl: 'partials/playground2.html'
      controller: 'Playground2Ctrl'
    .when '/step/triples',
      templateUrl: 'partials/triples.html'
      controller: 'TriplesCtrl'
    .when '/start',
      templateUrl: 'partials/start.html'
      controller: 'StartCtrl'
    .when '/about',
      templateUrl: 'partials/about.html'
      controller: 'AboutCtrl'
    .when '/contact',
      templateUrl: 'partials/contact.html'
      controller: 'ContactCtrl'
    .otherwise
      redirectTo: '/'
