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
	
	indexBanners: function() {
    var horizontal = true,
     		$panels = jQuery('#slider .panel'),
     		$container = jQuery('#slider .scrollContainer'),
     		$scroll = jQuery('#slider .scroll').css('overflow', 'hidden'),
				$nav = jQuery('#banner_nav .navigation a'),
		 		$prevNav = jQuery("div.banner_arrows.left_arrow"),
				$nextNav = jQuery("div.banner_arrows.right_arrow");
    
    var scrollOptions = {
      target: $scroll,
      items: $panels,
      navigation: $nav,
      prev: $prevNav,
      next: $nextNav,
      axis: 'xy',
      duration: 500,
      easing: 'swing',
      onAfter: trigger
    };
    
    if (horizontal) {
      $panels.css({ 'float' : 'left', 'position' : 'relative'});
      if (typeof $panels[0] == 'undefined') {
      
      } else {
        $container.css('width', $panels[0].offsetWidth * $panels.length);
      }
    }
    
    $nav.bind('mouseover, click', selectNav);

    function selectNav() {
      jQuery(this).parents('ul:first').find('a').removeClass('selected active').end().end().addClass('active selected');
      jQuery(this).parents('ul:first').find('li').removeClass('selected active').end().end().addClass('active selected');
    }
    
    function trigger(data) {
      var el = jQuery('#banner_nav .navigation').find('a[href$="' + data.id + '"]').get(0);
      selectNav.call(el);
    }

    jQuery('#slider').serialScroll(scrollOptions);
    $.localScroll(scrollOptions);
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
