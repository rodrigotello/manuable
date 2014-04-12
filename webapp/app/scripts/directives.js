'use strict';

angular
  .module('manuableApp')
    .directive('productCard', function () {
      return {
        replace: true,
        restrict: 'E',
        scope: { product: '=' },
        templateUrl: "views/products/product_card.html",
        controller: function($scope, Restangular){
          $scope.like = function(){
            if( $scope.product.liked ) { return; }
            //Product.like({}, {id: $scope.product.id }, function(r){
              // VALIDATE response
              $scope.product.liked = true;
            //});
          }

        }
      };
    });

