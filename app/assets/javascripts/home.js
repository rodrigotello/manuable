var HomeIndex = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $('.want-learn').tooltip({placement: 'right'});
    $('.want-buy').tooltip({placement: 'right'});
    $('#upcoming-events .flexslider').flexslider({
      animation: 'slide',
      animationLoop: false,
      minItems: 3,
      maxItems: 3,
      itemWidth: 353,
      controlNav: false,
      prevText: '',
      nextText: ''
    });
  }
};

var HomeAbout = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $('#abouttabs a.active').tab('show');
  }
};
