'use strict';
var MessageModalController = function($scope, $modalInstance, Restangular, currentUser){
  $scope.conversation = { body: '' };

  $scope.submit = function(){
    $scope.user.all('messages').post({ body: $scope.conversation.body }).then(function(message){
      $scope.messages.push(message);
      $scope.conversation.body = '';
    });
  }

}

angular.module('manuableApp')
  .controller('UserCtrl', function ($scope, $q) {
    $scope.user = {};
    $scope.products = [];
    $scope.followers = [];
    $scope.followees = [];
    $scope.userDefer = $q.defer();
  })
  .controller('UserShowCtrl', function ($scope, $stateParams, $state, Restangular, $modal, currentUser) {
    var currentPage = 1;

    $scope.messageModal = function(){
      $scope.user.all('messages').getList().then(function(messages){
        $scope.messages = messages;
        $modal.open({
          templateUrl: '/views/partials/message.modal.html',
          controller: MessageModalController,
          scope: $scope
        });
      });
    }

    $scope.unfollow = function(){
      $scope.user.all("follow").remove().then(function(){
        $scope.user.followed = false;
        if( $state.current.name === "public.user.show.followers"){
          $scope.user.follows = _.filter( $scope.user.follows, function(u){ return u.id !== currentUser().getUser().id });
        }
      });
    }

    $scope.follow = function(){
      $scope.user.all("follow").post().then(function(){
        $scope.user.followed = true;
        if( $state.current.name === "public.user.show.followers"){
          $scope.user.follows.push(currentUser().getUser());
        }
      });
    }

    Restangular.one('users', $stateParams.id).get().then( function(user){
      $scope.user = user;
      $scope.userDefer.resolve();

      $scope.user.all('products').getList().then( function(products){
        $scope.user.products = products;
      });
    });

    $scope.loadMore = function(){
      currentPage += 1;

      $scope.user.all('products').getList({ page: currentPage }).then( function(products){
        $scope.user.products = products;
      });
    }

  })

  .controller('UserShowProductsCtrl', function ($scope, $stateParams, Restangular, $timeout) {
    $scope.userDefer.promise.then(function(){
      $scope.user.all('products').getList().then( function(products){
        $scope.user.products = products;
      });
    });
  })

  .controller('UserShowLikedProductsCtrl', function ($scope, $stateParams, Restangular) {
    var currentPage = 1;
    $scope.userDefer.promise.then(function(){
      $scope.user.all('products').getList({ liked: 1}).then( function(products){
        $scope.user.products = products;
      });

      $scope.loadMore = function(){
        currentPage += 1;

        $scope.user.all('products').getList({ liked: 1, page: currentPage }).then( function(products){
          $scope.user.products = products;
        });
      }
    });
  })
  .controller('UserShowFollowersCtrl', function ($scope, $stateParams, Restangular) {

    $scope.userDefer.promise.then(function(){
      $scope.user.get({ 'includes[]' : [ 'followers' ]}).then( function(user){
        $scope.user.follows = user.followers;
      });
    });

  }).controller('UserShowFolloweesCtrl', function ($scope, $stateParams, Restangular) {

    $scope.userDefer.promise.then(function(){
      $scope.user.get({ 'includes[]' : [ 'followees' ]}).then( function(user){
        $scope.user.follows = user.followees;
      });
    });

  }).controller('UserLoginCtrl', function($modal){
  }).controller('UserLogoutCtrl', function($rootScope, $cookieStore, currentUser, $state, Restangular){
    currentUser().removeUser();
    $cookieStore.remove('currentUser');
    delete $rootScope.currentUser;
    Restangular.setDefaultHeaders({ 'Authorization': undefined });
    $state.go('public.home.index', {}, { reload: true });
  });
