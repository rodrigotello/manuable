var ProductsNew = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $("#product_wizard").on("hidden", function(){
      $('#product-sources').show().find(".product-source i").hide();
      $('#product-onsale-select, #maker-error').hide();
    });

    $(".new_product .attachment-product-drop").click(function(e){
      var $this = $(this),
          $img = $('img', $this),
          $input = $('input', $this);


      if (e.target === $this[0] || e.target === $img[0]){
        $input.trigger('click');
      }
    });

    $(".new_product .attachment-product-drop input").change(function(){
      var $this = $(this);
      $this.after($this.val().match(/[-_\w]+[.][\w]+$/i)[0].substring(0, 15));
    });

    $(document).on('nested:fieldRemoved', ".edit_product", function(e){
      var $field = e.field;
      $field.find('img').remove();
    });

    // $('#product_materials').tagsInput({
    //   defaultText: 'Nuevo',
    //   height: '80px',
    //   width: '600px'
    // });

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
          $('#maker-error').hide();
          $this.siblings('input').prop('checked', true);
          $("#product-sources").fadeOut(700);
          setTimeout(function(){
            $("#product-onsale-select").fadeIn(700);
          }, 650);
        }
      });

    });
  }
};

var ProductsEdit = ProductsNew;
