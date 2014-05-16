'use strict';

var ModalInstanceCtrl = function ($scope, $modalInstance, item, title) {

  $scope.title = title;
  $scope.selected = item;

  $scope.save = function () {
    $modalInstance.close($scope.selected);
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
};

angular.module('app')
  .controller('ConfigCtrl', function ($scope, $modal, R2rs, Config) {
  
  $scope.config = Config;
  $scope.datasource = $scope.config.datasources[0];

  $scope.$watch('config.datasource', function (value) {
    var spec = $scope.config.datasources.filter(function (i) { return (i.name === value); })[0];

    if (spec) {
      R2rs.registerDatabase(spec);
    }
  });

  $scope.newDatasource = function () {
    var modalInstance = $modal.open({
      templateUrl: 'partials/config_datasource.html',
      controller: ModalInstanceCtrl,
      resolve: {
        item: function () {
          return {
            'name' : '',
            'subprotocol' : '',
            'subname' : '',
            'username' : '',
            'password' : ''
          };
        },
        title: function () {
          return 'Create new datasource ...';
        }
      }
    });

    modalInstance.result.then(function (item) {
      $scope.config.datasources.push(item);
      $scope.config.datasource = item;
    });
  };

  $scope.editDatasource = function () {
    var index = $scope.config.datasources.indexOf($scope.config.datasource);

    var modalInstance = $modal.open({
      templateUrl: 'partials/config_datasource.html',
      controller: ModalInstanceCtrl,
      resolve: {
        item: function () {
          return $scope.config.datasources[index];
        },
        title: function () {
          return 'Configure datasource ...';
        }
      }
    });

    modalInstance.result.then(function (item) {
      $scope.config.datasources[index] = item;
      $scope.config.datasource = item;
    });
  };
});
