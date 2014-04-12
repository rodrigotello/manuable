'use strict';

angular.module('manuableApp')
  .controller('HomeCtrl', function ($scope, $stateParams, Restangular) {
    Restangular.all('categories').getList().then(function(categories){
      $scope.categories = categories;
    });
  })

  .controller('HomeIndexCtrl', function ($scope, $stateParams, Restangular) {
    $scope.$parent.params = $stateParams;
    var currentPage = 1;

    Restangular.all('products').getList({c: $stateParams.c, pop: $stateParams.pop, new: $stateParams.new }).then( function(products){
      $scope.products = products;
    });

    $scope.loadMore = function(){
      currentPage += 1;

      Restangular.all('products').getList({ page: currentPage, c: $stateParams.c, pop: $stateParams.pop, new: $stateParams.new }).then( function(products){
        $scope.products = $scope.products.concat( products );
      });
    }
  });
