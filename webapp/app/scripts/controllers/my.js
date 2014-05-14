'use strict';

angular.module('manuableApp')
  .controller('MyCtrl', function( $scope, currentUser, Restangular ) {
    $scope.user = currentUser().getUser();

    Restangular.all('my').all('products').getList().then(function(products){
      $scope.products = products;
    });
  })
  .controller('MyShowCtrl', function($rootScope, $scope, $q, currentUser, Restangular, $fileUploader){
    $scope.newProduct = {};
    $scope.updateProfile = function(){
      Restangular.all('my').one('profile').patch($scope.user).then(function(user){
        currentUser().updateUser(_.pick(user, ['country_id', 'cover_url', 'avatar', 'first_name', 'id', 'location', 'name', 'nickname', 'state_id']));
        $rootScope.currentUser = currentUser().getUser();
      });
    }

    var uploader = $scope.uploader = $fileUploader.create({
      scope: $scope,
      url: ''
    });


    // ADDING FILTERS

    // Images only
    uploader.filters.push(function(item /*{File|HTMLInputElement}*/) {
      var type = uploader.isHTML5 ? item.type : '/' + item.value.slice(item.value.lastIndexOf('.') + 1);
      type = '|' + type.toLowerCase().slice(type.lastIndexOf('/') + 1) + '|';
      return '|jpg|png|jpeg|gif|'.indexOf(type) !== -1;
    });

    var newProductReveal = false;
    // REGISTER HANDLERS

    uploader.bind('afteraddingfile', function (event, item) {
      alert('x')
      item.upload();
      $scope.newProduct.attachments.push(item);

      if ( !newProductReveal ){
        newProductReveal = true;
        $scope.newProductModal($scope);
      }
    });

    uploader.bind('whenaddingfilefailed', function (event, item) {
    });

    uploader.bind('afteraddingall', function (event, items) {
    });

    uploader.bind('beforeupload', function (event, item) {
      console.info('Before upload', item);
    });

    uploader.bind('progress', function (event, item, progress) {
      console.info('Progress: ' + progress, item);
    });

    uploader.bind('success', function (event, xhr, item, response) {
      console.info('Success', xhr, item, response);
    });

    uploader.bind('cancel', function (event, xhr, item) {
      console.info('Cancel', xhr, item);
    });

    uploader.bind('error', function (event, xhr, item, response) {
      console.info('Error', xhr, item, response);
    });

    uploader.bind('complete', function (event, xhr, item, response) {
      console.info('Complete', xhr, item, response);
    });

    uploader.bind('progressall', function (event, progress) {
      console.info('Total progress: ' + progress);
    });

    uploader.bind('completeall', function (event, items) {
      console.info('Complete all', items);
    });
  });
