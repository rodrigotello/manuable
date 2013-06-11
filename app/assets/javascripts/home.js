var HomeIndex = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $('.want-learn').tooltip({placement: 'right'});
    $('.want-buy').tooltip({placement: 'right'});
  }
};

var HomeAbout = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $('#abouttabs a.active').tab('show');
  }
};
