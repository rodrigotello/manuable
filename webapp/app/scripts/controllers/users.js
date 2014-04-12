'use strict';

angular.module('manuableApp')
  .controller('UserCtrl', function ($scope, $stateParams) {
  })
  .controller('UserShowCtrl', function ($scope, $stateParams, Restangular) {
    var currentPage = 1;

    Restangular.one('users', $stateParams.id).get().then( function(user){
      $scope.user = user;

      $scope.user.all('products').getList().then( function(products){
        $scope.products = products;
      });
    });

    $scope.loadMore = function(){
      currentPage += 1;

      $scope.user.all('products').getList({ page: currentPage }).then( function(products){
        $scope.products = products;
      });

    }
  })

  .controller('UserShowProductsCtrl', function ($scope, $stateParams, Restangular, $timeout) {
    $timeout(function(){
      $scope.$parent.user.all('products').getList().then( function(products){
        $scope.products = products;
      });
    }, 1000);
  })

  .controller('UserShowLikedProductsCtrl', function ($scope, $stateParams, Restangular) {
    var currentPage = 1;
    $scope.$parent.user.all('products').getList({ liked: 1}).then( function(products){
      $scope.products = products;
    });

    $scope.loadMore = function(){
      currentPage += 1;

      $scope.$parent.user.all('products').getList({ liked: 1, page: currentPage }).then( function(products){
        $scope.products = products;
      });
    }
  })
  .controller('UserShowFollowersCtrl', function ($scope, $stateParams, Restangular) {

    $scope.$parent.user.get({ 'includes[]' : [ 'followers' ]}).then( function(user){
      $scope.follows = user.followers;
    });

  }).controller('UserShowFolloweesCtrl', function ($scope, $stateParams, Restangular) {
    $scope.$parent.user.get({ 'includes[]' : [ 'followees' ]}).then( function(user){
      $scope.follows = user.followees;
    });

  });
