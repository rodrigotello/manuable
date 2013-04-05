var ProductsNew = new function(){
	"use strict";
	var self = this;
	self.init = function(){
		//$('.tipinfo').popover({placement:'right',trigger:'hover'});
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

var ProductsCharacteristics = new function(){
	"use strict";
	var self = this;
	self.init = function(){
		$('.tipinfo').popover({placement:'right',trigger:'focus'});
	}
};