var feedPagination = function(feedid, total_pages, page, url){
  var $feed = $(feedid),
      scrollCallback = function(e){
        if( $(window).scrollTop() >= $(document).height() / 2 - $(window).height() ){ // half page
          if ( !$feed.data('loading') && $feed.data('page') < total_pages ){
            var next_page = $feed.data('page') + 1;
            $feed.data('page', next_page);
            $feed.data('loading', true);
            console.log('loading '+next_page);
            $.getJSON(url, { page: next_page }, function(data){
              $feed.append(data.html);
              console.log(data.total_entries)
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
