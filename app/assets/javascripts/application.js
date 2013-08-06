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
//= require rails.validations
//= require rails.validations.simple_form
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
//= require set
//= require_tree .

ClientSideValidations.formBuilders['NestedForm::SimpleBuilder'] = ClientSideValidations.formBuilders['SimpleForm::FormBuilder'];

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
      })
    });
  });

  $(document).on('ajax:success', 'a.like', function(data, status, xhr){
    var $this = $(this);
    $this.addClass('disable').parents('.heart-overlay').addClass('liked');
    var $counter = $this.find(".likes-count");
    $this.removeAttr('data-method');
    $this.removeAttr('data-remote');
    $this.attr('href', 'javascript:void(1)');
    $counter.html(parseInt($counter.html(), 10)+1);

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
