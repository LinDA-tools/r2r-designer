# Common environment specific configuration

    'use strict'

    angular.module 'r2rDesignerApp'
      .factory 'Config', () ->

'backend' specifies where the r2r-designer server is running.

        backend: 'http://localhost:3000'
