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

var Modal = {

  createModal: function(insertedData, titleText){
    var modalWrap = $("<div id='modal_wrap'></div>"),
        modalTitle = $("<span id='modal_title'></span>"),
        modalHeader = $("<div id='modal_header' class='black_gradient'></div>"),
        modalCloseLink = $("<div id='close_modal_link' class='button close_button red_button'>X</div>"),
        modalContent = $("<div id='modal_content'></div>");
        
        if (titleText != undefined) {
          modalTitle.text(titleText);
          modalHeader.prepend(modalTitle);
        }
        modalContent.append(insertedData);
        modalHeader.append(modalCloseLink);
        modalWrap.append(modalHeader).append(modalContent);
        return modalWrap;
  },

  confirmDelete: function(message, callback) {
    var confirmMessage = (message ? message : "Are you sure you want to delete?"),
        confirmContent = Modal.confirmModalContent(confirmMessage),
        modal = Modal.loadModal(confirmContent);

    Modal.activateConfirm(callback);
  },

  confirmModalContent: function(message) {
    var confirmWrap = $("<div id='confirm_wrap'></div>"),
        confirmMessage = $("<div id='confirm_message'></div>"),
        confirmOkButton = $("<span id='confirm_ok' class='button blue_button'>Ok</span>"),
        confirmCancelButton = $("<span id='confirm_cancel' class='button red_button'>Cancel</span>");

        confirmMessage.text(message);
        confirmWrap.append(confirmMessage).append(confirmOkButton).append(confirmCancelButton);

        return confirmWrap;
  },

  activateConfirm: function(callback) {
    var modal = $("#modal_wrap"),
        okButton = $("#confirm_ok"),
        cancelButton = $("#confirm_cancel");

    okButton.on("click", function() {
      modal.remove();
      callback();
    });
    cancelButton.on("click", function() {
      modal.remove();
      return false;
    });
  },

  loadModal: function(insertedData, titleText) {
    var modal = Modal.createModal(insertedData, titleText);
        
    Modal.removeModal();    
    $('body').append(modal);
    modal.css({"top" : ($(window).scrollTop() + 50) })
    Modal.closeModal();
    Modal.dragModal();
  },

  dragModal: function() {
    var modal = $("#modal_wrap"),
        modalHeader = modal.find("#modal_header");
      
    modal.draggable({
      handle: modalHeader
    });
  },

  closeModal: function() {
    var closeLink = $("#close_modal_link");

    closeLink.on("click", function() {
      Modal.removeModal();
    });
  },

  removeModal: function() {
    var modal = $("#modal_wrap");
    modal.remove();
  }
};

var Base = {

  helpIcon: function() {
    var helpIcon = $(".info_button");

    helpIcon.on('click', function() {
      var message = $(this).data('info');
      Modal.loadModal(message, "Permit Notice");
    });

  },
	
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
  },

  submitLocationFormElements: function () {
  	var formHolder = $("#internal_content");

  	formHolder.on({
  		blur: function (e) {
				Forms.checkforFieldValue($(this));
  		},
  		keypress: function (e) {
	  		if (e.keyCode == 13) {
	  			e.preventDefault();
	  			$(this).blur();
	  		}
  		}
  	}, '.location_field');
  },

  checkforFieldValue: function (inputElement) {
  		if (inputElement.val() != "") {
  			Forms.submitLocationForm(inputElement);
  		} else {
  			return;
  		}
  },

  submitLocationForm: function(inputElement) {
  	var form = inputElement.parents('form').first();
  	$.ajax({
  		url: form.attr('action'),
  		data: {id: inputElement.attr('item_id'), product_location: inputElement.val()},
  		dataType: 'json',
  		cache: false,
  		type: "POST"
  	}).done(function(data) {
  		  Forms.removeCurrentLocationForm(inputElement);
  			Forms.displayAssignedProductsSection();
  			Forms.updateLocationsAfterSave(data);
  	});
  },

  removeCurrentLocationForm: function (inputElement) {
  	inputElement.parents('li').first().remove();
  },

  displayAssignedProductsSection: function () {
  	$("#assigned_products").removeClass('hidden');
  },

  updateLocationsAfterSave: function (returnedDataObject) {
  	$("#added_products").append(Forms.assignedLocationTemplate(returnedDataObject));
  },

  assignedLocationTemplate: function (returnedDataObject) {
  	var template = Handlebars.compile($("#location_template").html());
  	return template(returnedDataObject);
  },

  infoFormToggle: function() {
  	var internalContent = $("#internal_content");

  	internalContent.on('click', ".hidden_form_link", function() {
  		var link = $(this),
  				form = link.siblings('form');

  		link.toggleClass('open');
  		form.slideToggle(function() {
  			Forms.toggleEditInfoLinkText(link);
  		});	
  	});	
  },

  toggleEditInfoLinkText: function(link) {
  	if (link.hasClass('open')) {
  		link.text("Hide Form");
  	} else {
  		link.text("Edit Information")
  	}
  },

  sameServiceCheckboxToggle: function() {
  	var checkBox = $("#same_as_billing");

  	checkBox.on('change', function() {
  		Forms.toggleAddressState($(this));
  	});

  	Forms.liveBillingUpdateCheck(checkBox);
  },

  liveBillingUpdateCheck: function(checkbox) {
  	Forms.liveAddressUpdate(checkbox);
  	Forms.liveCityUpdate(checkbox);
  	Forms.liveStateUpdate(checkbox);
  	Forms.liveZipUpdate(checkbox);
  },

  liveAddressUpdate: function() {
  	var billingAddress = $("#billing_record_address");

  	billingAddress.on('blur', function() {
  		if ($("#same_as_billing").is(':checked')) {
  			Forms.copyTextField(document.getElementById('billing_record_address'), document.getElementById('additional_service_record_address'));
  		}
  	});
  },

  liveCityUpdate: function() {
  	var billingCity = $("#billing_record_city");

  	billingCity.on('blur', function() {
  		if ($("#same_as_billing").is(':checked')) {
  			Forms.copyTextField(document.getElementById('billing_record_city'), document.getElementById('additional_service_record_city'));
  		}
  	});
  },

  liveZipUpdate: function() {
  	var billingZip = $("#billing_record_billing_zip");

  	billingZip.on('blur', function() {
  		if ($("#same_as_billing").is(':checked')) {
  			Forms.copyTextField(document.getElementById('billing_record_billing_zip'), document.getElementById('additional_service_record_secondary_zip'));
  		}
  	});
  },  

  liveStateUpdate: function() {
  	var billingZip = $("#billing_record_state_id");

  	billingZip.on('change', function() {
  		if ($("#same_as_billing").is(':checked')) {
  			Forms.copySelectField(document.getElementById('billing_record_state_id'), document.getElementById('additional_service_record_state_id'));
  		}
  	});
  },

  toggleAddressState: function(checkBox) {
  	if (checkBox.is(':checked')) {
  		Forms.applyBillingAddressToServiceAddress();
  	} else {
  		Forms.emptyFormFields($("#additional_records"));
  	}
  },

  applyBillingAddressToServiceAddress: function() {
  	Forms.copyTextField(document.getElementById('billing_record_address'), document.getElementById('additional_service_record_address'));
  	Forms.copyTextField(document.getElementById('billing_record_city'), document.getElementById('additional_service_record_city'));
  	Forms.copyTextField(document.getElementById('billing_record_billing_zip'), document.getElementById('additional_service_record_secondary_zip'));
  	Forms.copySelectField(document.getElementById('billing_record_state_id'), document.getElementById('additional_service_record_state_id'));
  },

  copyTextField: function(copyFromField, copyToField) {
  	copyToField.value = copyFromField.value;
  },

  copySelectField: function(copyFromField, copyToField) {
  	copyToField.selectedIndex = copyFromField.selectedIndex;
  	copyToField.options[copyToField.selectedIndex].value = copyFromField.options[copyFromField.selectedIndex].value;
  	copyToField.options[copyToField.selectedIndex].text = copyFromField.options[copyFromField.selectedIndex].text;
  },

  emptyFormFields: function(fieldContainer) {
  	var textFields = fieldContainer.find('input.address_swap'),
  			selectFields = fieldContainer.find('select.address_swap');
	
  	textFields.each(function() {
  		$(this).val('');
  	});
  	selectFields.each(function() {
  		$(this).prop('selectedIndex',0);
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
  },

  creditCardUpdateSubmit: function(){
    $("#cc_update").submit(function(e) {
      e.preventDefault();
      var submitButton = $(this).find("#update_credt_card_submit");

          Gateway.stripeUpdateVerify($(this));
          submitButton.attr("disabled", "disabled");
          submitButton.addClass("disabled");
    });
  },

  stripeUpdateVerify: function(stripeForm) {
    var self = stripeForm,
        cardNumber = self.find("#credit_card_card_number").val(),
        cardCvv = self.find("#credit_card_verification_value").val(),
        cardMonth = self.find("#credit_card_month").val(),
        cardYear = self.find("#credit_card_year").val(),
        amount = 500; // Stripe expects amount to be in cents

      if (cardNumber.length) {
          // Submit Values to Stripe for auth
          Stripe.createToken({
            number: cardNumber,
            cvc: cardCvv,
            exp_month: cardMonth,
            exp_year: parseInt(cardYear)
          }, amount, Gateway.stripeUpdateResponseHandler);
      } else {
        return false;
      }
  },

  stripeUpdateResponseHandler: function(status, response) {
    if (status == 200) {
      $('#stripe_card_token').val(response.id)
      $('#cc_update')[0].submit();
    } else {
      $('#update_credt_card_submit').attr('disabled', false);
      $('#update_credt_card_submit').removeClass('disabled');
    }
  }  
};

var Layout = {

	setPanels: function() {
		Layout.setPanelSizes();
	},

	setPanelSizes: function() {
		var header = $("#mast_header"),
				footer = $("#ft"),
				sidebar = $("#sidebar"),
				content = $("#content");

		sidebar.height($(window).height() - (footer.height() + header.height()));
		content.height($(window).height() - (footer.height() + header.height()));
		content.width($(window).width() - (sidebar.outerWidth() + 1));

		$(window).resize(function() {
			sidebar.height($(window).height() - (footer.height() + header.height()));
			content.height($(window).height() - (footer.height() + header.height()));
			content.width($(window).width() - (sidebar.outerWidth() + 1));
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
  }

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

var App = {

  initDeleteLinks: function() {
    var deleteLinks = $(".delete_link");

    deleteLinks.on("click", function(e) {
      var self = $(this);
      
      Modal.confirmDelete("Are you sure?", function() {
        App.deleteRecord(self);
      });
      e.preventDefault();
    });
  },

  deleteRecord: function(link) {
    var url = link.attr("href"),
        parent = link.parents(".delete_parent").first();

    $.ajax({
      url: url,
      type: "DELETE",
      success: function(response) {
        parent.remove();
        Modal.loadModal("Record deleted.");
      },
      error: function(response, text, message) {
        var errorMessage = text + " - " + message;
        Modal.loadModal(errorMessage);
      }
    }); 
  }
};
//**********Initialize Document**********//
$(document).ready(function() {
	Flash.injectFlashBox();
	Flash.setFlash();
	Base.setTips();
  Base.helpIcon();
  App.initDeleteLinks();
});
