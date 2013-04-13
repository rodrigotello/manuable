var ProductsNew = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $("#onsale").click(function(e){
      e.preventDefault();
      $("#product_on_sale").prop('checked', true).parents('form').submit();

    });
    $("#bragging").click(function(e){
      e.preventDefault();
      $("#product_on_sale").prop('checked', false).parents('form').submit();

    });
    var $product_sources = $('#product-sources .product-source').click(function(e){
      e.preventDefault();
      var $this = $(this);

      $('i', $product_sources.not($this)).fadeIn(700, function(){
        $('i', $this).fadeIn(700);
        if( $this.prop("id") === 'btt_someone_else' ){
          $('#maker-error').fadeIn(700);
        }else{
          $this.siblings('input').prop('checked', true);
          $("#product-sources").fadeOut(700);
          setTimeout(function(){
            $("#product-onsale-select").fadeIn(700);
          },350);
        }
      });

    });
  }
};
var ProductsEdit = ProductsNew;
