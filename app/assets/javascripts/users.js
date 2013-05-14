var UsersEdit = new function(){
  "use strict";
  var self = this;
  self.init = function(){

  }
};

var UsersShow = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    $('#follow').bind('ajax:success', function(){
      var $this = $(this);
      $this.replaceWith('<span class="btn btn-mini active"><i class="icon-ok"></i> Siguiendo</span>');
      var li = "<li>";
      li += '<img src="'+ current_user.avatar.small.url +'" alt="'+current_user.name+'"/>';
      li += current_user.name;
      $('#followers').prepend(li);
    });

  }
};
