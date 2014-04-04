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
  .controller('ConfigCtrl', function ($scope, $modal) {
    $scope.datasources = [
      {
        'name' : 'MySQL Sample Database',
        'subprotocol' : 'mysql',
        'subname' : 'mysql',
        'username' : 'mysql',
        'password' : 'mysql'
      },
      {
        'name' : 'Northwind Postgres Database',
        'subprotocol' : 'psql',
        'subname' : 'psql',
        'username' : 'postgres',
        'password' : 'postgres'
      }
    ];
  
    $scope.currentDs = $scope.datasources[0];

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
        $scope.datasources.push(item);
      });
    };

    $scope.editDatasource = function () {
      var index = $scope.datasources.indexOf($scope.currentDs);

      var modalInstance = $modal.open({
        templateUrl: 'partials/config_datasource.html',
        controller: ModalInstanceCtrl,
        resolve: {
          item: function () {
            return $scope.datasources[index];
          },
          title: function () {
            return 'Configure datasource ...';
          }
        }
      });

      modalInstance.result.then(function (item) {
        $scope.datasources[index] = item;
      });
    };
  });
