/*jslint white: false, onevar: false, browser: true, devel: true, undef: true, nomen: true, laxbreak: true, eqeqeq: true, plusplus: true, bitwise: true, regexp: true, strict: false, newcap: true, immed: true, laxbreak: true */
/*global jQuery, $, Raphael */

var Flash = {

	injectFlashBox: function() {
		$('#flash').addClass("flash_wrap");
		$("#flash").hide();
	},

	setFlash: function() {
		var flash_message = $("#flash").html();
		var msg = $.trim(flash_message);
		if (msg !== "") {
			Flash.activateNotice(flash_message);
		}
	},

	activateNotice: function(flash_message) {
		var flash_div = $("#flash");
		flash_div.html(flash_message);
		flash_div.show("slide", {
			direction: 'up'
		});
		// Set the fadeout
		setTimeout(function() {
			flash_div.hide("slide", {
				direction: 'up'
			},
			function() {
				flash_div.html("");
				flash_div.hide();
			});
		},
		2500);
	}
};

var Base = {
	
	pageResize: function() {
		var header = $("#hd"),
				body = $("#bd"),
				subBoxes = $("#mast_sub_boxes"),
				footer = $("#ft"),
				segmentHeights = (header.outerHeight() + subBoxes.outerHeight() + footer.outerHeight());


		body.height($(window).height() - segmentHeights);

		$(window).resize(function() {
			body.height($(window).height() - segmentHeights);
		});
	},

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
      $(this).parents('ul:first').find('a').removeClass('selected active').end().end().addClass('active selected');
      $(this).parents('ul:first').find('li').removeClass('selected active').end().end().addClass('active selected');
    }
    
    function trigger(data) {
      var el = $('#banner_nav .navigation').find('a[href$="' + data.id + '"]').get(0);
      selectNav.call(el);
    }

    $('#slider').serialScroll(scrollOptions);
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

var Forms = {

	initForms: function(chargeAmount){
		Forms.validateSignupForm(chargeAmount);
	},

	resetSubmitButton: function() {
		var submitButton = $("#order_submit");

		submitButton.val("Setup Account");
		submitButton.removeAttr('disabled');
		submitButton.removeClass('blue_button');
		submitButton.addClass('red_button');
	},

	orderSubmitButton: function() {
		var submitButton = $("#order_submit");

		submitButton.on('click', function() {
			$(this).val("Processing...");
			$(this).attr('disabled', 'disabled');
			$(this).removeClass('red_button');
			$(this).addClass('blue_button');
			$(this).submit();
		});
	},

	resetAssignedSubmitButton: function() {
		var submitButton = $("#assigned_products_submit");

		submitButton.val("Send Items");
		submitButton.removeAttr('disabled');
		submitButton.removeClass('blue_button');
		submitButton.addClass('red_button');
	},

	assignedProductsSubmitButton: function() {
		var submitButton = $("#assigned_products_submit");

		submitButton.on('click', function() {
			$(this).val("Processing...");
			$(this).attr('disabled', 'disabled');
			$(this).removeClass('red_button');
			$(this).addClass('blue_button');
			$(this).parents("form").first().submit();
		});
	},

	
	validateLocations: function() {
    $("#new_order").ketchup();
  },

  validateSignupForm: function(chargeAmount) {
  	var formEl = $("#new_order"),
  			submitButton = formEl.find("input[type='submit']");

    formEl.ketchup();
    submitButton.on("click", function(e) {
      if( formEl.ketchup("isValid") ) {
        Gateway.formSubmit(chargeAmount);
      } else {
      	e.preventDefault();
      	Forms.resetSubmitButton();
      }
    });
  }
};

var Gateway = {
  
  formSubmit: function(chargeAmount){
    $("#new_order").submit(function(e) {
    	e.preventDefault();
      var submitButton = $(this).find(".submit-button"),
          actionsDiv = $(this).find(".actions");

          $("#submit_error_message").remove();
          $(".actions p").remove();

          Gateway.stripeVerify($(this), chargeAmount);
          submitButton.attr("disabled", "disabled");
          submitButton.addClass("disabled");
    });
  },

  stripeVerify: function(stripeForm, chargeAmount) {
    var self = stripeForm,
        cardNumber = self.find("#credit_card_card_number").val(),
        cardCvv = self.find("#credit_card_verification_value").val(),
        cardMonth = self.find("#credit_card_month").val(),
        cardYear = self.find("#credit_card_year").val(),
        amount = (chargeAmount * 100); // Stripe expects amount to be in cents

      if (cardNumber.length) {
          // Submit Values to Stripe for auth
          Stripe.createToken({
            number: cardNumber,
            cvc: cardCvv,
            exp_month: cardMonth,
            exp_year: parseInt(cardYear)
          }, amount, Gateway.stripeResponseHandler);
      } else {
        return false;
      }
  },

  stripeResponseHandler: function(status, response) {
    if (status == 200) {
      $('#order_stripe_card_token').val(response.id)
      $('#new_order')[0].submit();
    } else {
      $('.submit-button').attr('disabled', false);
      $('.submit-button').removeClass('disabled');
      $(".actions p").remove();
      $(".actions").append("<div id='submit_error_message' class='red'>" + response.error.message + "</div>");
    }
  }
};

var Layout = {

	setPanels: function() {
		Layout.setPanelSizes();
		Layout.setInternalContentPanel();
	},

	setPanelSizes: function() {
		var header = $("#mast_header"),
				footer = $("#ft"),
				sidebar = $("#internal #sidebar"),
				content = $("#internal #content");

		sidebar.height($(window).height() - (footer.outerHeight() + header.outerHeight()));
		content.height($(window).height() - (footer.outerHeight() + header.outerHeight()));

		$(window).resize(function() {
			sidebar.height($(window).height() - (footer.outerHeight() + header.outerHeight()));
			content.height($(window).height() - (footer.outerHeight() + header.outerHeight()));
		});
	},

	setInternalContentPanel: function() {
		var contentPanel = $("#content"),
				sidebar = $("#sidebar");

		contentPanel.width($(window).width() - (sidebar.outerWidth() + 1));
		$(window).resize(function() {
			contentPanel.width($(window).width() - (sidebar.outerWidth() + 1));
		});
	}

};

var Navigation = {

  setCurrentNav: function() {
    var url = location.pathname,
        all_links = $('ul#main_nav li'),
        current_link = $('ul#main_nav li a[href$="' + url + '"]'),
        active_link = current_link.parent("li");

    if (url == "/") {
      all_links.removeClass('active');
      $('.home').addClass('active');
    } else {
      all_links.removeClass('active');
      active_link.addClass('active');
    }
  },

  setInternalNav: function() {
  	var url = location.pathname,
        all_links = $('ul#internal_nav li'),
        current_link = $('ul#internal_nav li a[href$="' + url + '"]'),
        active_link = current_link.parent("li");

    if (url == "/") {
      all_links.removeClass('active');
      $('.home').addClass('active');
    } else {
      all_links.removeClass('active');
      active_link.addClass('active');
    }
  },

};

var Admin = {
	
	adminScripts: function() {
		Admin.setupDataTables();
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
	Flash.injectFlashBox();
	Flash.setFlash();
	Base.setTips();
});
