var flash = {

	injectFlashBox: function() {
		$('#flash').addClass("flash_wrap");
		$("#flash").hide();
	},

	setFlash: function() {
		flash_message = $("#flash").html();
		msg = $.trim(flash_message);
		if (msg != "") {
			flash.activateNotice(flash_message);
		};
	},

	activateNotice: function(flash_message) {
		var $flash_div = $("#flash");
		$flash_div.html(flash_message);
		$flash_div.show("slide", {
			direction: 'up'
		});
		// Set the fadeout
		setTimeout(function() {
			$flash_div.hide("slide", {
				direction: 'up'
			},
			function() {
				$flash_div.html("");
				$flash_div.hide()
			})
		},
		2500);
	}

};

var ajax = {

	setAjaxNotice: function() {
		$('body').append('<div id="ajax_notice" style="display:none;"></div>')
	},

	findId: function(el) {
		elId = el.attr("content_id");
		return elId;
	},
	
	setAjaxCallbacks: function() {
		$('body').ajaxStart(function() {
			$("#ajax_notice").slideDown().text("Loading...");
		});
		$('body').ajaxStop(function() {
			$("#ajax_notice").slideUp();
		});
	},

	closeFormBox: function() {
		$('.ajax_form_box_close').live('click', function(e) {
			e.preventDefault();
			$('#ajax_form_box').slideUp('slow');
			$('#ajax_form').remove();
		});
	},

	setLiveDatepicker: function() {
		$(".date_field").live('click', function() {
			$(this).datepicker({
				showOn: 'focus'
			}).focus();
		});
	}

};

var base = {

	stopProp: function() {
		$('.stop_prop').bind('click', function(e) {
			e.stopPropagation();
		});
	}
	
};

//**********Initialize Document**********//
$(document).ready(function() {
	// injects flash div into dom
	flash.injectFlashBox();
	flash.setFlash();
	ajax.setAjaxNotice();
	ajax.setAjaxCallbacks();
});
