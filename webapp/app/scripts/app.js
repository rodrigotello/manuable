'use strict';

angular.module('manuableApp', [
    'restangular',
    'ngSanitize',
    'ngCookies',
    'ui.router',
    'ui.bootstrap',
    'angularMoment',
    'wu.masonry',
    'luegg.directives',
    'angularFileUpload'
  ])
  .provider('requestTracker', function requestTrackerProvider() {
    var endpoints = {};
    this.$get = function requestTrackerFactory($rootScope) {
      return endpoints;
    };
  })
  .config(function($stateProvider, RestangularProvider, $locationProvider, requestTrackerProvider) {
    var requestsUrlStatus = requestTrackerProvider.$get();

    RestangularProvider.setBaseUrl('http://localhost:3000/api')
    RestangularProvider.addRequestInterceptor(function(element, operation, what, url){
      requestsUrlStatus[url] = 'loading';
    });

    RestangularProvider.addResponseInterceptor(function(data, operation, what, url, response, deferred){
      requestsUrlStatus[url] = 'done';
      return data;
    });

    $stateProvider
      .state('public', {
        abstract: true,
        url: "",
        views: { "yield" : { templateUrl: "views/layouts/application.html", controller: 'ApplicationCtrl' }}
      })
      .state('public.home', {
        abstract: true,
        url: "/inicio",
        views: { "applicationYield" : { templateUrl: "views/layouts/home.html", controller: 'HomeCtrl' } }
      })
      .state('public.home.index', {
        url: "/?pop&new&c",
        views: { "homeYield" : { templateUrl: "views/home/index.html", controller: 'HomeIndexCtrl' } }
      })
      .state('public.user', {
        abstract: true,
        url: '/perfil',
        views: { 'applicationYield': { templateUrl: 'views/layouts/user.html', controller: 'UserCtrl' } }
      })
      .state('public.user.show', {
        abstract: true,
        url: '/:id',
        views: { 'userYield': { templateUrl: 'views/users/show.html', controller: 'UserShowCtrl' } }
      })
      .state('public.user.show.products', {
        url: '',
        views: { 'userContentYield': { templateUrl: 'views/users/show.products.html', controller: 'UserShowProductsCtrl' } }
      })
      .state('public.user.show.likes', {
        url: '/gustos',
        views: { 'userContentYield': { templateUrl: 'views/users/show.products.html', controller: 'UserShowLikedProductsCtrl' } }
      })
      .state('public.user.show.followers', {
        url: '/seguidores',
        views: { 'userContentYield': { templateUrl: 'views/users/show.follows.html', controller: 'UserShowFollowersCtrl' } }
      })
      .state('public.user.show.followees', {
        url: '/seguidos',
        views: { 'userContentYield': { templateUrl: 'views/users/show.follows.html', controller: 'UserShowFolloweesCtrl' } }
      })
      .state('public.product.show', {
        url: '/producto/:id',
        views: { 'productPopup': { templateUrl: 'views/products/show.html', controller: 'ProductShowCtrl' } }
      })
      .state('public.login', {
        url: '/entrar',
        views: { 'applicationYield': { templateUrl: 'views/users/login.html', controller: 'UserLoginCtrl' } }
      })
      .state('public.logout', {
        url: '/salir',
        views: { 'null': { templateUrl: 'views/users/login.html', controller: 'UserLogoutCtrl' } }
      })
      .state('public.my', {
        abstract: true,
        url : '/mi',
        views: { 'applicationYield': { templateUrl: 'views/layouts/my.html', controller: 'MyCtrl' } }
      })
      .state('public.my.profile', {
        url : '/informacion',
        views: { 'myYield': { templateUrl: 'views/my/show.html', controller: 'MyShowCtrl' } }
      })
      .state('public.my.products', {
        abstract: true,
        url : 'productos',
        views: { 'myProductsYield': { templateUrl: 'views/my/products/.html', controller: 'MyShowCtrl' } }
      })
  }).factory('$localStore', function() {
    if(typeof(Storage) === "undefined"){
      throw 'No localStorage support';
    }

    var service = {
      get: function(key){
        try {
          return JSON.parse(localStorage[key]);
        }catch(err){
          return undefined;
        }
      },
      set: function(key, value){
        localStorage[key] = JSON.stringify(value);
      },
      put: function(key, value){
        localStorage[key] = JSON.stringify(value);
      },
      remove: function(key){
        localStorage[key] = undefined;
      }
    };

    return service;
  }).factory('currentToken', function() {
    var token = null;
    var service = {
      get: function(t){
        return token;
      },
      set: function(value){
        token = value;
      }
    }
    return service;
  });
