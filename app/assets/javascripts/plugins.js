var feedPagination = function(feedid, total_pages, page, url, params){
  "use strict";
  if ( typeof(params) !== 'object' ){
    params = {};
  }

  var $feed = $(feedid),
      scrollCallback = function(e){
        console.log($(window).scrollTop(), $(document).height() - 1000 )
        if( $(window).scrollTop() >= $(document).height() - 1000){ // half page
          if ( !$feed.data('loading') && $feed.data('page') < total_pages ){
            var next_page = $feed.data('page') + 1;
            $feed.data('page', next_page);
            $feed.data('loading', true);
            params.page = next_page
            $.getJSON(url, params, function(data){
              $feed.append(data.html);
              $feed.data('loading', false);
            });
          }
        }
      };

  $feed.data('page', page);
  $feed.data('loading', false);
  $(window).scroll( $.throttle( 1000, scrollCallback ) );
  // $(window).scroll( scrollCallback );
}
