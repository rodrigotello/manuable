window.loadGmaps = function(callback) {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyDYNvOp0LjEnBkqb3kAOH9Hv9Cxk0hpg20&sensor=false&callback=' + callback;
  document.body.appendChild(script);
}
var EventsNew = new function(){
  "use strict";
  var self = this;
  var map = false,
      marker = false,
      $lat = false,
      $lng = false,
      geocoder =false;

  self.init = function(){
    window["EventsNew"].initialized = true;
    window.loadGmaps('initNewEventMap');
    $('#event_starts_at_date, #event_ends_at_date').datepicker({
      format: 'yyyy-mm-dd'
    });
    $('#event_starts_at_time, #event_ends_at_time').timepicker({
      format: 'yyyy-mm-dd'
    });

    $('#organizer_names').tagsInput({
      height: 30,
      width: '100%',
      defaultText: 'Organizadores',
      autocomplete_url: '/users.json',
      autocomplete: { selectFirst: true, width: '100px', autoFill: true },
      onRemoveTag: function(tag){
        var selected_items = $('#organizer_names_tag').data('selected_items'),
            $hidden = $('#event_user_ids'),
            removed_id = selected_items[tag],
            ids = $hidden.val().split(','),
            cleaned_ids = [];
        for(var i=0;i< ids.length; i++){
          if ( parseInt(ids[i], 10) !== removed_id){
            cleaned_ids.push(ids[i]);
          }
        }
        $hidden.val(cleaned_ids.join(','));
      }
    });
    $('#organizer_names_tag').bind('autocompleteselect', function(event, ui){
          var $hidden = $('#event_user_ids'),
              selected_items = $('#organizer_names_tag').data('selected_items');
          if ( !selected_items ){
            selected_items = {};
          }
          selected_items[ui.item.label] = ui.item.id;
          $('#organizer_names_tag').data('selected_items', selected_items);
          if ( $hidden.val() !== "" ){
            var arr = $hidden.val().split(',');
            arr.push(ui.item.id);
            $hidden.val( arr.join(',')  );
          }else{
            $hidden.val( ui.item.id  );
          }
        });

    $('#event_address, #event_zip, #event_location, #event_city_input').blur( function(){
      if( !($('#event_city_input').val() && $('#event_address').val() && $('#event_zip').val() && $('#event_city_input').val() ) ){ return; }
      codeAddress($('#event_address').val() + ", " + $('#event_zip').val() + ", " + $('#event_location').val() + ", " + $('#event_city_input').val());
    });
    $lat = $('#event_lat');
    $lng = $('#event_lng');

    $("#event_city_input").typeahead({
      name: 'cities',
      prefetch: '/cities.json',
      remote: {
        url: '/cities.json?q=%QUERY',
        replace: function(url, query){
          return url.replace(this.wildcard, query)+'&state_id=19';
        },
        filter: function(cities){
          var decorated_cities = [];
          for(var i=0;i<cities.length;i++){
            decorated_cities.push({
                          value: cities[i].name,
                          tokens: [cities[i].name, cities[i].state.name],
                          state: cities[i].state,
                          city: { id: cities[i].id, name: cities[i].name}
                        });
          }
          return decorated_cities;
        }
      },
      limit: 10
    }).on('typeahead:selected', function(e, datum){
      $('#event_city_id').val(datum.city.id);
    });

  }

  window.initNewEventMap = function(){
    if( map ) { return; }

    var latlng = new google.maps.LatLng(25.6560047, -100.37475519999998);

    var mapOptions = {
      zoom: 14,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("new-event-map"), mapOptions);
    marker = new google.maps.Marker({
        map: map,
        position: latlng,
        draggable: true
    });
    var pinIcon = new google.maps.MarkerImage(
        "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FFFF00",
        null, /* size is determined at runtime */
        null, /* origin is 0,0 */
        null, /* anchor is bottom center of the scaled image */
        new google.maps.Size(22, 38)
    );
    marker.setIcon(pinIcon);
    google.maps.event.addListener(marker, 'dragend', function() {
      map.setCenter(marker.getPosition());

      $lat.val(marker.getPosition().lat());
      $lng.val(marker.getPosition().lng());


      geoCoder().geocode( { 'latLng': marker.getPosition()}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          $('#event_address').val(results[1].formatted_address);
        } else {
          $('#maps-error').html('No pudimos ubicar el mapa. Solo la dirección será guardada')
          $lat.val('');
          $lng.val('');
        }
      });

    });
  }

  function codeAddress(address) {
    if(!address){ return; }

    geoCoder().geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        marker.setPosition(results[0].geometry.location)
        $lat.val(results[0].geometry.location.lat());
        $lng.val(results[0].geometry.location.lng());
      } else {
        $('#maps-error').html('No pudimos ubicar el mapa. Solo la dirección será guardada')
        $lat.val('');
        $lng.val('');
      }
    });
  }

  function geoCoder(){
    if (geocoder) { return geocoder; }
    geocoder = new google.maps.Geocoder();
    return geocoder;
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

    $('#event_sale_category').change(function(){
      xtotal();
      $('#event-price-total,#event-price').html(toCurrency(event_sale_products[parseInt($('#event_sale_category').val(), 10)].price));
    });

    function xtotal(){
      var $items = $('#event-checkout .event-product-price'),
          grandTotal = event_sale_products[parseInt($('#event_sale_category').val(), 10)].price;

      for( var i=0; i < $items.length; i++ ){
        var st = parseInt( $($items[i]).data('total'), 10);
        if( !isNaN(st) ){
          grandTotal += parseInt( $($items[i]).data('total'), 10);
        }

      }

      $('#total').html('<strong>' + toCurrency(grandTotal) + '</strong>');
    }

  }
};

var EventsShow = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    if(window["EventsShow"].initialized){ return ;}
    window["EventsShow"].initialized = true;
    window.loadGmaps('initEventMap');

    $('.datetime').timepicker({
      format: 'yyyy-mm-dd'
    });
    $('.event-nav a').click(function(){
      $('html,body').animate({
        scrollTop: $($(this).attr("href")).offset().top - 150
        }, 500);
    });

    $('form.new_event_schedule').bind('ajax:success', function(e, schedule){
      var $li = $("<li class=\"clearfix\">" +
                  "  <span class=\"schedule-time\">" +
                  schedule.starts_at +
                  "  </span>" +
                  "  <span class=\"schedule-name\">" +
                  schedule.name +
                  "  </span>" +
                  "  <a href=\"" + $(this).attr('action').replace('.json','') + "/" + schedule.id + ".json\" class=\"remove-event-schedule\" data-method=\"delete\" data-remote=\"true\" rel=\"nofollow\">x</a>" +
                  "</li>");
      $li.find('a').bind('ajax:success', function(){
        $(this).parents("li:first").remove();
      });
      $(this).siblings('ul.schedule').append($li)
    });

    $('.remove-event-schedule').bind('ajax:success', function(){
      $(this).parents("li:first").remove();
    });
  }
  window.initEventMap = function(){
    var ele = document.getElementById("map");
    if ( !ele ){ return false; }
    var latlng = new google.maps.LatLng(ele.attributes['data-lat'].value, ele.attributes['data-lng'].value);

    var mapOptions = {
      zoom: 14,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(ele, mapOptions);
    var marker = new google.maps.Marker({
        map: map,
        position: latlng,
        draggable: false
    });
  }
};

var EventsCreate = EventsNew;
var EventsEdit = EventsNew;

// var EventsMap = new function(){
//   "use strict";
//   var self = this;
//   self.init = function(){
//     if(window["EventsMap"].initialized){ return ;}
//     window["EventsMap"].initialized = true;
//     window.loadGmaps('initEventMap');
//   }
//   window.initEventMap = function(){
//     var ele = document.getElementById("event-map");
//     if ( !ele ){ return false; }
//     var latlng = new google.maps.LatLng(ele.attributes['data-lat'].value, ele.attributes['data-lng'].value);

//     var mapOptions = {
//       zoom: 14,
//       center: latlng,
//       mapTypeId: google.maps.MapTypeId.ROADMAP
//     }
//     var map = new google.maps.Map(ele, mapOptions);
//     var marker = new google.maps.Marker({
//         map: map,
//         position: latlng,
//         draggable: false
//     });
//   }
// };
var EventsRequestAccess = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    if(window["EventsRequestAccess"].initialized){ return ;}
    window["EventsRequestAccess"].initialized = true;
    $('#event-tos .request-access').click(function(e){
      if($(this).hasClass('disabled')){
        return false;
      }
    });
    $('#obs-cb, #terms-cb').change(function(){
      if( $('#obs-cb').is(':checked') && $('#terms-cb').is(':checked')  ){
        $('#event-tos .request-access').removeClass('disabled');
      }else{
        $('#event-tos .request-access').addClass('disabled');
      }
    });
  }
}
var EventPaymentsShow = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    if(window["EventPaymentsShow"].initialized){ return ;}
    window["EventPaymentsShow"].initialized = true;
    $('#event_payment_position').change(function(){
     $('#oxxo-link').attr('href', location.pathname+'?position=' + $(this).val());
    });
  }
}
