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
	},
	
	setTips: function() {
		$('.tool_tip').tipTip({
			defaultPosition: "top"
		});
	},

	removeFormFields: function(link) {
		$(link).prev("input[type=hidden]").val("1");
		$(link).closest('.fields').hide();
	},
	
	addFormFields: function(association) {
		var new_id = new Date().getTime(),
				regexp = new RegExp("new_" + association, "g");
				
		$(link).parent().before(content.replace(regexp, new_id));
	},
	
	triggerAddFormFields: function() {
		var link = $(".package_add_product"),
				formSetWrap = $("#packaged_products"),
				newFormSet = $(".product_select").first();
	}
	
};

var forms = {
	
	validateLocations: function() {
    $("#new_order").ketchup();
  },	
	
	validatePaymentInfo: function() {
    $("#new_billing_record").ketchup();
  }
	
};

var admin = {
	
	adminScripts: function() {
		admin.setupDataTables();
	},
	
	setupDataTables: function() {
		postsTable = $('#dashboard_blogs_table').dataTable({
			"bJQueryUI": true,
			"sPaginationType": "full_numbers"
		});
		eventsTable = $('#dashboard_users_table').dataTable({
			"bJQueryUI": true,
			"sPaginationType": "full_numbers"
		});
		linksTable = $('#dashboard_packages_table').dataTable({
			"bJQueryUI": true,
			"sPaginationType": "full_numbers"
		});
		linksTable = $('#dashboard_products_table').dataTable({
			"bJQueryUI": true,
			"sPaginationType": "full_numbers"
		});
	},
	
	addPackagedProduct: function() {
		var selectWrapper = $("#packaged_products"),
				fields = $(".product_select"),
				addTrigger = $(".package_add_product"),
				deleteLinkHTML = "<a href='' class='delete_product_field'>Remove</a>",
				deleteLink = $(".delete_product_field");
				
		
		addTrigger.click(function(e) {
			var field = fields.clone(),
					countInput = field.find('input:text');
					
			field.append(deleteLinkHTML)
			countInput.val("");
			selectWrapper.prepend(field);
			e.preventDefault();
		});
		
		deleteLink.live('click', function(e) {
			insertedField = $(this).parents(".product_select").first();
			insertedField.remove();
			e.preventDefault();
		});
		
	},
	
	toggleDependencies: function() {
	  var depCkBox = $("#dependent_checkbox input:checkbox"),
	      depProds = $('#dependent_products');
	  
	  depCkBox.click(function() {
	    
	    if ($(this).is(':checked')) {
        depProds.slideDown();
      } else {
        depProds.slideUp();
      }
      
	  });
	  
	}
	
};
//**********Initialize Document**********//
$(document).ready(function() {
	// injects flash div into dom
	flash.injectFlashBox();
	flash.setFlash();
	base.setTips();
});
