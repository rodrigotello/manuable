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
            Restangular.one('products', $scope.product.id).all('likes').post().then(
              function(){
                $scope.product.liked = true;
              },
              function(){}
            )
            //Product.like({}, {id: $scope.product.id }, function(r){
              // VALIDATE response
              $scope.product.liked = true;
            //});
          }

        }
      };
    })
    .directive('nonav', function(){
      return {
        restrict: 'A',
        link: function(scope, element, attrs){
          element.on('click', function(e){
            e.preventDefault();
          });
        }
      }
    })
    .directive('autosave',function () {
      return {
        restrict : 'A',
        scope: { save: '&ngSubmit' },
        link: function($scope, $element, $attrs){
          $scope.$parent.$watch($attrs.autosave, _.debounce($scope.save, 2000), true);
          $scope.$broadcast('autosaving')
        }
      }
    })
    .directive('thumb', ['$window', function($window) {
      var helper = {
        support: !!($window.FileReader && $window.CanvasRenderingContext2D),
        isFile: function(item) {
          return angular.isObject(item) && item instanceof $window.File;
        },
        isImage: function(file) {
          var type =  '|' + file.type.slice(file.type.lastIndexOf('/') + 1) + '|';
          return '|jpg|png|jpeg|gif|'.indexOf(type) !== -1;
        }
      };

      return {
        restrict: 'A',
        template: '<canvas/>',
        link: function(scope, element, attributes) {
          if (!helper.support) return;

          var params = scope.$eval(attributes.thumb);

          if (!helper.isFile(params.file)) return;
          if (!helper.isImage(params.file)) return;

          var canvas = element.find('canvas');
          var reader = new FileReader();

          reader.onload = onLoadFile;
          reader.readAsDataURL(params.file);

          function onLoadFile(event) {
              var img = new Image();
              img.onload = onLoadImage;
              img.src = event.target.result;
          }

          function onLoadImage() {
              var width = params.width || this.width / this.height * params.height;
              var height = params.height || this.height / this.width * params.width;
              canvas.attr({ width: width, height: height });
              canvas[0].getContext('2d').drawImage(this, 0, 0, width, height);
          }
        }
      };
    }])
