'use strict';

angular.module('manuableApp')
  .controller('ApplicationCtrl', function ($rootScope, $scope, $location, $state, $modal) {
    if( $location.path() === '' ){
      $state.go('public.home.index')
    }

    $rootScope.loginModal = function(){
      $modal.open({
        templateUrl: '/views/partials/login.html',
        controller: ['$scope',function($s){
          $s.login = function(){

          }
        }]
      });
    }
  });
