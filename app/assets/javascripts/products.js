var ProductsNew = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $("#product-fields").hide();
    $("#product_made_by").change(function(e){
      if ( $(this).val() === 'someone_else' ){
        $("#product-fields").hide();
        $("#only_artisant_error").show();
      }else{
        $("#only_artisant_error").hide();
        $("#product-fields").show();
      }
    });
  }
};
