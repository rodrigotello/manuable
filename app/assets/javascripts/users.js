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
                = link_to u.name, u
      var li = "<li class='media'>";
      li += '<img class="media-object" src="'+ current_user.avatar.small.url +'" alt="'+current_user.name+'"/>';
      li += '<div class="media-body">';
      li += ('<a href="/users/"'+current_user.id+'">' + current_user.name + '</a>');
      li += '</div>';
      $('#followers').prepend(li);
    });

  }
};
