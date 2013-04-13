var ProductsNew = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    var $product_sources = $('#product-sources .product-source').click(function(e){
      e.preventDefault();
      var $this = $(this);

      $('i', $product_sources.not($this)).fadeIn(700, function(){
        $('i', $this).fadeIn(700);
        if( $this.prop("id") === 'btt_someone_else' ){
          $('#maker-error').fadeIn(700);
        }else{
          $("#product-sources").fadeOut(700);
          setTimeout(function(){
            $("#product-onsale-select").fadeIn(700);
          },350);
        }
      });

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
