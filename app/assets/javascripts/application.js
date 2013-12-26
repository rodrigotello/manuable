//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/bootstrap-transition
//= require twitter/bootstrap/bootstrap-alert
//= require bootstrap-modalmanager
//= require bootstrap-modal
//= require hogan
//= require twitter/bootstrap/bootstrap-button
//= require twitter/bootstrap/bootstrap-dropdown
//= require twitter/bootstrap/bootstrap-tooltip
//= require twitter/bootstrap/bootstrap-tab
//= require twitter/bootstrap/bootstrap-popover
//= require twitter/bootstrap/bootstrap-scrollspy
//= require twitter/bootstrap/bootstrap-affix
//= require bootstrap-typeahead
//= require bootstrap-timepicker
//= require bootstrap-datepicker
//= require jquery.tagsinput.min
//= require handlebars
//= require jquery_nested_form
//= require jquery.chosen.min
//= require jquery.ba-throttle-debounce.min
//= require jquery-fileupload/basic
//= require jquery.jcrop.min
//= require jquery.inputmask.min
//= require plugins
//= require jquery.ui.autocomplete
//= require jquery.markitup
//= require jquery.flexslider-min
//= require set
//= require_tree .

function toCurrency(num) {
  var sign;
  var cents;
  var i;

  num = num.toString().replace(/\$|\,/g, '');
  if (isNaN(num)) {
    num = "0";
  }
  sign = (num == (num = Math.abs(num)));
  num = Math.floor(num * 100 + 0.50000000001);
  cents = num % 100;
  num = Math.floor(num / 100).toString();
  if (cents < 10) {
    cents = '0' + cents;
  }

  for (i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++) {
    num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
  }

  return (((sign) ? '' : '-') + '$' + num + '.' + cents);
}

$(function(){
  "use strict";
  var LOADERIMG = '<div id="loader"><div id="loader_1" class="loader"></div><div id="loader_2" class="loader"></div><div id="loader_3" class="loader"></div><div id="loader_4" class="loader"></div><div id="loader_5" class="loader"></div><div id="loader_6" class="loader"></div><div id="loader_7" class="loader"></div><div id="loader_8" class="loader"></div></div>';
  $.expr[':'].regex = function(elem, index, match) {
      var matchParams = match[3].split(','),
          validLabels = /^(data|css):/,
          attr = {
              method: matchParams[0].match(validLabels) ?
                          matchParams[0].split(':')[0] : 'attr',
              property: matchParams.shift().replace(validLabels,'')
          },
          regexFlags = 'ig',
          regex = new RegExp(matchParams.join('').replace(/^\s+|\s+$/g,''), regexFlags);
      return regex.test(jQuery(elem)[attr.method](attr.property));
  }

  var page = $("body").data("page");
  if( "object" === typeof window[page] && !window[page].initialized){
    window[page].init();
  }
  $(":input").inputmask();

  // $('input[type=file]').fileupload({
  //   dropZone: $('#file-dropzone'),
  //   filesContainer: $('#file-dropzone'),
  //   sequentialUploads: true,
  //   singleFileUploads: true,
  //   add: function (e, data) {
  //     var $uploader = $(this).data('blueimp-fileupload') ||
  //             $(this).data('fileupload'),
  //         options = $uploader.options,
  //         template = Handlebars.compile( $("#upload-template").html()),
  //         files = data.files;
  //     for(var i in files){
  //       var $upload = $('#file-dropzone').append($( $.trim(template({ "filename" : new Handlebars.SafeString( files[i].name ) })))).children(":last");
  //       files[i].context = $upload;
  //       $upload.find('.remove-attachment').bind('click.fu', function(e){
  //         e.preventDefault();
  //         var $this = $(this);
  //         if (!data.jqXHR) {
  //           console.log('no jqXHR');
  //         } else {
  //           console.log('aborting');
  //           data.jqXHR.abort();
  //         }
  //         $this.parent().remove();
  //       });

  //     }
  //     data.submit();
  //   },
  //   done: function (e, data) {
  //     var context = data.files[0].context,
  //         result = data.result[data.result.length - 1];
  //     context.find(".progress").remove();
  //     context.find(".remove-attachment").unbind('click.fu').bind('click.fu', function(e){
  //       e.preventDefault();
  //       $.post('/my/' + result.delete_url, { '_method' : 'delete' }, function(){
  //         context.remove();
  //       });

  //     });
  //   },
  //   progress: function (e, data) {
  //     var context = data.files[0].context;
  //     if (context) {
  //         var progress = Math.floor(data.loaded / data.total * 100);
  //         context.find('.progress')
  //             .attr('aria-valuenow', progress)
  //             .find('.bar').css( 'width', progress + '%');
  //     }
  //   }

  // });

  $("[data-toggle=tooltip], abbr").tooltip();
  $("select.go-chosen").chosen();

  $(document).on('click', 'a.fbshare', function(e){

    window.open($(this).attr('href'), 'sharer', 'width=626,height=436');
  });
  $(document).on('click', 'a[rel*=modal]', function(e){
    e.preventDefault();
    var $this = $(this);

    $.get($this.attr('href'), { "modal" : 1 }, function(data){
      var template = Handlebars.compile( $("#plain-modal-template").html()),
          $modal = $( $.trim(template({ "title" : new Handlebars.SafeString(($this.attr("title")||$this.attr("data-original-title")||$this.html())), "body" : new Handlebars.SafeString(data) }) ));

      $modal.modal({ "show" : false }).on("shown", function(){
          $('form[data-validate]', $modal).validate();
          $('.datepicker', $modal).datepicker({ 'format' : 'yyyy/mm/dd' });
          $("select.chosen", $modal).chosen();
        }).modal('show');
      $modal.on('hidden', function(){
        $modal.remove();
      });
      if ( $this.data('modalclass') ){
        $modal.addClass($this.data('modalclass'));
      }
    });
  });

  $(document).on('click', 'a:regex(href,^\/products\/[0-9]+$)', function(e){
    e.preventDefault();
    var $this = $(this);
    $('#product-modal-body').html(LOADERIMG);
    $('#product-modal').css({ top: $(window).scrollTop() + 50 });
    $('#product-modal-overlay, #product-modal').fadeIn();
    $.get($this.attr('href'), { no_layout: 1 }, function(data){
      $('#product-modal-body').html(data);
    });
  });

  $('#product-modal-overlay, #product-modal-close').click(function(e){
    e.preventDefault();
    $('#product-modal-overlay, #product-modal').fadeOut();
  });
  $(document).on('ajax:success', 'a.manuable-like', function(data, status, xhr){
    var $this = $(this);
    if($this.html().match(/gusta/)){
      $this.html('<i class="fa fa-heart">&nbsp;</i>Te gusta');
    }else{
      $this.html('<i class="fa fa-heart"></i>');
    }
    $this.removeAttr('data-method');
    $this.removeAttr('data-remote');
    $this.attr('href', 'javascript:void(1)');
  });

  $(document).bind('dragover', function (e) {
    var $dropZone = $('#file-dropzone');
    $dropZone.addClass('hover');
  });

  $(document).bind('drop', function (e) {
    var $dropZone = $('#file-dropzone');
    $dropZone.removeClass('hover');
  });

  $(document).bind('dragleave', function (e) {
    var $dropZone = $('#file-dropzone');
    $dropZone.removeClass('hover');
  });

});
