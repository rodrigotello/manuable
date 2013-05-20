// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/bootstrap-transition
//= require twitter/bootstrap/bootstrap-alert
//= require twitter/bootstrap/bootstrap-modal
//= require twitter/bootstrap/bootstrap-button
//= require twitter/bootstrap/bootstrap-dropdown
//= require twitter/bootstrap/bootstrap-tooltip
//= require twitter/bootstrap/bootstrap-popover
//= require bootstrap-typeahead
//= require jquery.tagsinput.min
//= require bootstrap-modalmanager
//= require rails.validations
//= require rails.validations.simple_form
//= require handlebars
//= require jquery_nested_form
//= require jquery.chosen.min
//= require bootstrap-datepicker
//= require holder
//= require jquery-fileupload/basic
//= require_tree .

ClientSideValidations.formBuilders['NestedForm::SimpleBuilder'] = ClientSideValidations.formBuilders['SimpleForm::FormBuilder'];

$(function(){
  "use strict";

  var page = $("body").data("page");
  if( "object" === typeof window[page] )
    window[page].init();

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
  $('.datepicker').datepicker({ 'format' : 'yyyy/mm/dd' });
  $('.tag-input').tagsInput({ defaultText: "Propiedades", width: '98%', height: 'auto' });

  $(document).on('click', 'a[rel*=modal]', function(e){
    e.preventDefault();
    var $this = $(this);

    $.get($this.attr('href'), { "no_layout" : 1, "modal" : 1 }, function(data){
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
    $(this).addClass('disable').parents('.heart-overlay').addClass('liked');
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
