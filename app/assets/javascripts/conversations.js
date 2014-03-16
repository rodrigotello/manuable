var ConversationsHelpers = {
  fitConversation: function(){
    var $ul = $('.conversation ul'),
        height = $ul.height();
    $ul.css({ height: $(window).height() - 195 })
                  .scrollTop(height);
  }
};

var ConversationsNew = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    // ConversationsHelpers.fitConversation();
    $('#conversation_to_text').typeahead({
        name: 'users',
        prefetch: '/users.json',
        remote: '/users.json?q=%QUERY&t=as_typeahead_json',
        template: [
          '<img src="{{avatar}}" style="width: 25px" class="pull-left">',
          '<p class="repo-name">{{name}}</p>'
        ].join(''),
        engine: Hogan
      }).bind('typeahead:selected', function(e, item){
        $('#conversation_to_id').val(item.id);
        $('#conversation_body').focus();
        return item;
      });
  }
};
var MyConversationsNew = ConversationsNew;

var ConversationsCreate = ConversationsNew;

var ConversationsShow = new function(){
  "use strict";
  var self = this;
  self.init = function(){
    ConversationsHelpers.fitConversation();
  }
};
var ConversationsIndex = ConversationsShow;
