var ProductsNew = new function(){
	"use strict";
	var self = this;
	self.init = function(){
		$('.tipinfo').popover({placement:'right',trigger:'hover'});
		
		// $('#tab_characteristics a').click(function (e) {
		// 	e.preventDefault();
		// 	$(this).tab('show');
		// });

		$("#product_made_by").change(function(e){
			if ( $(this).val() === 'someone_else' ){
				$("#only_artisant_error").show();
				$(".form-actions").hide();
			}else{
				$("#only_artisant_error").hide();
				$(".form-actions").show();
			}
		});
	}
};


