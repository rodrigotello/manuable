'use strict';
var LoginModalController = function($scope, $http, $modalInstance, currentUser, $state, $stateParams, Restangular, $cookieStore){
  var login = function(email, password, callback){
    $http({
      method  : 'POST',
      url     : 'http://localhost:3000/api/authentications',
      data    : { 'email' : email, 'password' : password },
    })
    .success(function(data, status) {
      if(status == 401 ){
        //console.log(data)
      }else{
        currentUser().setUser(data);
      }
      callback();
    })
    .error(function(data, status, headers, config) {

    });

  }
  $scope.submit = function(){
    login($scope.login.email, $scope.login.password, function(){
      if( currentUser().getUser() ){
        $modalInstance.close();

        $state.transitionTo($state.current, $stateParams, {
          reload: true,
          inherit: false,
          notify: true
        });
      }
    });
  }
}

var NewProductModalController = function($scope, $modalInstance, currentUser, $state, $stateParams, Restangular ){
  $scope.submit = function(){

  }
}
angular.module('manuableApp')
  .controller('LoginController', function(){
  })
  .controller('ApplicationCtrl', function( $rootScope, $scope, $location, $state, $stateParams, currentUser, $cookieStore, Restangular, $modal, $http) {
    if ( $cookieStore.get('currentUser') ){
      currentUser().setUser($cookieStore.get('currentUser'));
    }

    currentUser().then(function(u){
      $rootScope.currentUser = u;
      Restangular.setDefaultHeaders({ 'Authorization': 'Token token=' + u.token });
    });

    if( $location.path() === '' ){
      $state.go('public.home.index');
    }

    $rootScope.loginModal = function(){
      $modal.open({
        templateUrl: '/views/partials/login.modal.html',
        controller: LoginModalController
      });
    };

    $rootScope.newProductModal = function(){
      $modal.open({
        templateUrl: '/views/partials/new.product.html',
        controller: NewProductModalController
      });
    };

  });
