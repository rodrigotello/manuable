var EventsNew = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    window["EventsNew"].initialized = true;
    // $('#event_starts_at_time, #event_ends_at_time').timepicker({
    //   minuteStep: 5,
    //   showInputs: false,
    //   disableFocus: false,
    //   defaultTime: false
    // });
    $('#event_starts_at_date, #event_ends_at_date').datepicker({
      format: 'yyyy-mm-dd'
    });
  }
};

var EventsCheckout = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    window["EventsCheckout"].initialized = true;
    xtotal();
    $('#event-checkout .event-product-input input').bind({
      keyup: function(e){
        var $this = $(this),
            amount = parseInt($this.val().match(/[0123456789]*/)[0], 10);

        if(isNaN(amount)){
          $this.val(0);
        }else{
          $this.val(amount);
        }

        var total = amount * parseFloat($this.data('price'));
        $this.parent().parent().find('.event-product-price').text(toCurrency(total)).data('total', total);

        xtotal();
      }
    });
    $('#event_sale_category').change(function(){xtotal();})
    function xtotal(){
      var $items = $('#event-checkout .event-product-price'),
          grandTotal = event_sale_products[$('#event_sale_category').val()].price;

      for( var i=0; i < $items.length; i++ ){
        var st = parseInt( $($items[i]).data('total'), 10);
        if( !isNaN(st) ){
          grandTotal += parseInt( $($items[i]).data('total'), 10);
        }

      }
      console.log(grandTotal);
      $('#total').html('<strong>' + toCurrency(grandTotal) + '</strong>');
    }

  }
};
