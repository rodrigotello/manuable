var HomeIndex = new function(){
	"use strict";
	var self = this;
	self.init = function(){
		$("#error_only_procucers").hide();
		$("#product_status_modal").hide();
		$("#product_description_modal").hide();

		// Popup Product Type Modal
		$("#btt_original,#btt_repaired").click(function(e){
				$("#error_only_procucers").hide();
				$('#product_type_modal').modal('hide');
				$('#product_status_modal').modal('show');
		});

		$("#btt_someone_else").click(function(e){
				$("#error_only_procucers").show();
		});

		// Popup Product Status Modal
		$("#btt_doing,#btt_selling").click(function(e){
				$("#product_status_modal").modal("hide");
				$("#product_type_modal").modal("hide");
				$("#product_description_modal").modal("show");
		});

		$("#btt_reg_cancel").click(function(e){
			$("#product_description_modal").modal("hide");
		});
	}
};
