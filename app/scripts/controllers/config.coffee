'use strict'

ModalInstanceCtrl = ($scope, $modalInstance, item, title) ->
  $scope.title = title
  $scope.selected = item

  $scope.save = ->
    $modalInstance.close($scope.selected)

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'

angular.module 'app'
  .controller 'ConfigCtrl', ($scope, $modal, R2rs, Config) ->
    $scope.config = Config
    $scope.datasource = $scope.config.datasources[0]

    $scope.$watch 'config.datasource', (value) ->
      if value
        console.log value
        R2rs.registerDatabase value

    $scope.newDatasource = ->
      modalInstance = $modal.open
        templateUrl: 'partials/config_datasource.html'
        controller: ModalInstanceCtrl
        resolve:
          item: ->
            'name' : ''
            'subprotocol' : ''
            'subname' : ''
            'username' : ''
            'password' : ''
          title: ->
            return 'Create new datasource ...'

      modalInstance.result.then (item) ->
        $scope.config.datasources.push item
        $scope.config.datasource = item

    $scope.editDatasource = ->
      index = $scope.config.datasources.indexOf $scope.config.datasource

      modalInstance = $modal.open
        templateUrl: 'partials/config_datasource.html'
        controller: ModalInstanceCtrl
        resolve:
          item: ->
            $scope.config.datasources[index]
          title: ->
            'Configure datasource ...'

      modalInstance.result.then (item) ->
        $scope.config.datasources[index] = item
        $scope.config.datasource = item
