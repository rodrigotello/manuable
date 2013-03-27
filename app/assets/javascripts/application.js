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
//= require jquery.fileupload
//= require_tree .

ClientSideValidations.formBuilders['NestedForm::SimpleBuilder'] = ClientSideValidations.formBuilders['SimpleForm::FormBuilder'];

"use strict";
$(function(){
  $('input[type=file]').fileupload({
    done : function(e, data) {
      console.log("Done", data.result)
      $(data.result).appendTo(this);
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
});


