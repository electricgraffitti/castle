/*jslint white: false, onevar: false, browser: true, devel: true, undef: true, nomen: true, laxbreak: true, eqeqeq: true, plusplus: true, bitwise: true, regexp: true, strict: false, newcap: true, immed: true, laxbreak: true */
/*global jQuery, $, Raphael */

var flash = {

	injectFlashBox: function() {
		$('#flash').addClass("flash_wrap");
		$("#flash").hide();
	},

	setFlash: function() {
		var flash_message = $("#flash").html();
		var msg = $.trim(flash_message);
		if (msg !== "") {
			flash.activateNotice(flash_message);
		}
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
				$flash_div.hide();
			});
		},
		2500);
	}

};

var base = {

	setNavHovers: function() {
		$('ul#main_nav_ul li').removeClass('highlight');
		$('ul#main_nav_ul li').prepend('<span class="active" />').each(function() {
			var $span = $('> span.active', this).css({
				opacity: 0
			});
			$(this).hover(function() {
				if ($(this).hasClass('active')) {
					$span.stop().fadeTo(400, 0);
				} else {
					$span.stop().fadeTo(400, 1);
				}
			},
			function() {
				$span.stop().fadeTo(400, 0);
			});
			$(this).click(function() {
				$span.fadeTo(200, 0);
				$('ul#main_nav_ul a').removeClass('active');
				$(this).addClass('active');
			});
		});
	},

	stopProp: function() {
		$('.stop_prop').bind('click', function(e) {
			e.stopPropagation();
		});
	},

	setFade: function(e) {
		e.effect("highlight", {
			color: '#cff2ff'
		},
		1000);
	}

};

//**********Initialize Document**********//
$(document).ready(function() {
	// injects flash div into dom
	flash.injectFlashBox();
	flash.setFlash();
});
