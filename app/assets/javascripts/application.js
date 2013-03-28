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
//= require twitter/bootstrap
//= require rails.validations
//= require rails.validations.simple_form
//= require handlebars
//= require jquery_nested_form
//= require jquery.chosen.min
//= require bootstrap-datepicker
//= require jquery-fileupload/basic
//= require_tree .

ClientSideValidations.formBuilders['NestedForm::SimpleBuilder'] = ClientSideValidations.formBuilders['SimpleForm::FormBuilder'];

$(function(){
  "use strict";
  $('input[type=file]').fileupload({
    autoUpload: false,
    dropZone: $('#file-dropzone'),
    filesContainer: $('#file-dropzone'),
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
    add: function (e, data) {
        var $uploader = $(this).data('blueimp-fileupload') ||
                $(this).data('fileupload'),
            options = $uploader.options,
            template = Handlebars.compile( $("#upload-template").html()),
            files = data.files;

        for(var i in files){
          console.log(files[i].name);
          var $upload = $( $.trim(template({ "filename" : new Handlebars.SafeString( files[i].name ) })));
            data.context = $('#file-dropzone').append($upload).children(":last");
        }

        // data.submit();

    },
    done: function (e, data) {
      var $uploader = $(this).data('blueimp-fileupload') ||
              $(this).data('fileupload'),
          files = $uploader._getFilesFromResponse(data),
          template,
          deferred;

      if (data.context) {
          data.context.each(function (index) {
              var file = files[index] ||
                      {error: 'Empty file upload result'},
                  deferred = $uploader._addFinishedDeferreds();
              if (file.error) {
                  $uploader._adjustMaxNumberOfFiles(1);
              }
              $uploader._transition($(this)).done(
                  function () {
                      var node = $(this);
                      template = $uploader._renderDownload([file])
                          .replaceAll(node);
                      $uploader._forceReflow(template);
                      $uploader._transition(template).done(
                          function () {
                              data.context = $(this);
                              $uploader._trigger('completed', e, data);
                              $uploader._trigger('finished', e, data);
                              deferred.resolve();
                          }
                      );
                  }
              );
          });
      } else {
          if (files.length) {
              $.each(files, function (index, file) {
                  if (data.maxNumberOfFilesAdjusted && file.error) {
                      $uploader._adjustMaxNumberOfFiles(1);
                  } else if (!data.maxNumberOfFilesAdjusted &&
                          !file.error) {
                      $uploader._adjustMaxNumberOfFiles(-1);
                  }
              });
              data.maxNumberOfFilesAdjusted = true;
          }
          template = $uploader._renderDownload(files)
              .appendTo($uploader.options.filesContainer);
          $uploader._forceReflow(template);
          deferred = $uploader._addFinishedDeferreds();
          $uploader._transition(template).done(
              function () {
                  data.context = $(this);
                  $uploader._trigger('completed', e, data);
                  $uploader._trigger('finished', e, data);
                  deferred.resolve();
              }
          );
      }
    }
  });

  var page = $("body").data("page");
  if( "object" === typeof window[page] )
    window[page].init();

  $("[data-toggle=tooltip], abbr").tooltip();
  $("select.go-chosen").chosen();
  $('.datepicker').datepicker({ 'format' : 'yyyy/mm/dd' });

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

  $(document).bind('dragover', function (e) {
    var $dropZone = $('#file-dropzone'),
        timeout = window.dropZoneTimeout;
    if (!timeout) {
        $dropZone.addClass('in');
    } else {
        clearTimeout(timeout);
    }
    if (e.target === $dropZone[0]) {
        $dropZone.addClass('hover');
    } else {
        $dropZone.removeClass('hover');
    }
    window.dropZoneTimeout = setTimeout(function () {
        window.dropZoneTimeout = null;
        $dropZone.removeClass('in hover');
    }, 100);
  });
});


