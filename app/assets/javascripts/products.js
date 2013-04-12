var ProductsNew = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    var $product_sources = $('#product-sources .product-source').click(function(e){
      e.preventDefault();
      $('i', $product_sources).fadeIn();
    });
  }
};

var ProductsCharacteristics = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $('.tipinfo').popover({placement:'right',trigger:'focus'});
  }
};
