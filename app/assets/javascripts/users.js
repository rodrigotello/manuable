var ProfilesEdit = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    window["ProfilesEdit"].initialized = true;
    if($("#user_state_id").change(function(){
      if($(this).val()){
        $("#city-autocomplete").parents('.user_city_id').show();
        $("#city-autocomplete").focus();
      }else{
        $("#city-autocomplete").parents('.user_city_id').hide();
      }
    }).val() || $("#city-autocomplete").val()){
      $("#city-autocomplete").parents('.user_city_id').show();
    }else{
      $("#city-autocomplete").parents('.user_city_id').hide();
    }
    $("#city-autocomplete").typeahead({
      name: 'cities',
      prefetch: '/cities.json',
      remote: {
        url: '/cities.json?q=%QUERY',
        replace: function(url, query){
          return url.replace(this.wildcard, query)+'&state_id='+$("#user_state_id").val();
        },
        filter: function(cities){
          var decorated_cities = [];
          for(var i=0;i<cities.length;i++){
            decorated_cities.push({
                          value: cities[i].name + ', ' + cities[i].state.name,
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
      $('#user_city_id').val(datum.city.id);
    });

    $('#croppable').Jcrop({
      aspectRatio: 1,
      setSelect: [0, 0, 300, 300],
      onSelect: function(c){
                  $('#user_crop_x').val(c.x);
                  $('#user_crop_y').val(c.y);
                  $('#user_crop_w').val(c.w);
                  $('#user_crop_h').val(c.h);
                },
      onChange: function(coords){
                  $('#crop-preview-wrapper').css({
                    width: Math.round(100/coords.w * $('#croppable').width()) + 'px',
                    height: Math.round(100/coords.h * $('#croppable').height()) + 'px',
                    marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px',
                    marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
                  });
                }
    });

  }
};

var UsersShow = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    window["UsersShow"].initialized = true;
    $('#follow-user').bind('ajax:success', function(){
      var $this = $(this),
          matches = $this.attr('href').match(/users\/([0-9]+)\/follow/);

      if( matches ){
        $this.html("Siguiendo");
        $this.attr('href', "/users/" + matches[1] + "/unfollow");
        $this.data('method', "delete");
      }else{
        matches = $this.attr('href').match(/users\/([0-9]+)\/unfollow/);
        $this.html("Seguir");
        $this.attr('href', "/users/" + matches[1] + "/follow");
        $this.data('method', "post");
      }

    });
    $('.user .user-menu a').bind('click', function(e){
      var $this = $(this);
      if( $this.attr('href').match(/#.+/) ){
        $this.parents('ul').find('a').removeClass('active');
        $this.addClass('active');
        $('.user section').fadeOut();
        $($this.attr('href')).fadeIn();
      }else{

      }
    });
  }
};
