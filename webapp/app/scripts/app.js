'use strict';

angular
  .module('manuableApp', [
    'restangular',
    'ngSanitize',
    'ui.router',
    'ui.bootstrap',
    'angularMoment',
    'wu.masonry'
  ])
  .config(function ($stateProvider, RestangularProvider) {
    RestangularProvider.setBaseUrl('http://localhost:3000/api')

    $stateProvider
      .state('public', {
        abstract: true,
        url: "",
        views: { "yield" : { templateUrl: "views/layouts/application.html", controller: 'ApplicationCtrl' } }
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
        url: '/usuario',
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
  });
