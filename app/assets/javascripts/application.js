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

var photos = {

	setItemPhotoFlyout: function() {
		$("h2#item_header a.flyout").flyout({
			loadingSrc: 'images/ajax-loader.gif'
		});
		$(".item_detail_panel a.flyout").flyout({
			loadingSrc: 'images/ajax-loader.gif'
		});
	}

};

var ajax = { 

	setAjaxNotice: function() {
		$('body').append('<div id="ajax_notice" style="display:none;"></div>');
	},

	findId: function(el) {
		var elId = el.attr("content_id");
		return elId;
	},

	setSidebarInfo: function(el, route) {
		var data = ajax.findId(el);
		var box = $('#info_panel');
		box.load(route, {
			id: data
		});
		base.setFade(box.parent('.sidebar_panel'));
	},

	setAjaxCallbacks: function() {
		$('body').ajaxStart(function() {
			$("#ajax_notice").slideDown().text("Loading...");
		});
		$('body').ajaxStop(function() {
			$("#ajax_notice").slideUp();
		});
	},

	setFormBoxTriggers: function() {
		$('.ajax_form_trigger').click(function(e) {
			e.preventDefault();
			ajax.triggerFormBox($(this));
		});
	},

	triggerFormBox: function(el) {
		var $form_box = $('#ajax_form_box');
		var $trigger_type = el.attr('trigger_type');
		ajax.loadAjaxForm($form_box, $trigger_type);
	},

	formBoxCallback: function(form_box) {
		form_box.slideDown('slow');
	},

	loadAjaxForm: function(form_box, tt) {
		
		var $form_box;
		
		switch (tt) {
		case('location'):
			$form_box.load('/ajax-location-form', ajax.formBoxCallback(form_box));
			break;
		case ('item'):
			$form_box.load('/ajax-item-form', ajax.formBoxCallback(form_box));
			break;
		case ('user'):
			$form_box.load('/ajax-user-form', ajax.formBoxCallback(form_box));
			break;
		case ('message'):
			$form_box.load('/ajax-message-form', ajax.formBoxCallback(form_box));
			break;
		case ('avatar'):
			$form_box.load('/ajax-avatar-form', ajax.formBoxCallback(form_box));
			break;
		case ('service'):
			$form_box.load('/ajax-service-form', ajax.formBoxCallback(form_box));
			break;
		}
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
	},

	modalAccountDetailSubmit: function() {
		// var $form = $("#modal_form form");
		// $form.bind('submit', function(e) {
		//       e.preventDefault();
		//       $.post($form.attr('action'), $form.serialize(), ajax.finishModalAccountDetailSubmit());
		// });
	},

	modalFormSubmit: function(modal) {
		// var $form = modal.find('form');
		// $form.bind('submit', function(e) {
		//       e.preventDefault();
		//       $.post($form.attr('action'), $form.serialize(), ajax.finishModalAccountDetailSubmit());
		// });
	},

	finishModalAccountDetailSubmit: function() {
		var modalText = $(".contentWrap p.modal_copy");
		modalText.html("Your Account has been updated. Thank You.");
	},
	
	reminderResolve: function() {
		var resolveLink = $(".resolve_link");
		
		resolveLink.click(function(e) {
			e.preventDefault();
			var data = parseInt($(this).attr('reminder_id')),
					row = $(this).closest(".item_detail_panel");
			
			$.ajax({
			  type: 'POST',
			  url: '/ajax-reminder-resolve',
			  data: {id:data},
			  success: removeReminder(row)
			});
			
			function removeReminder(row) {
				row.remove();
			}
			
		});	
	}

};

var forms = {
  
  signupMasks: function() {
    $('#user_phone').form_mask("(999) 999-9999");
  },
  
  businessPhoneMask: function() {
    $('#account_account_detail_attributes_business_phone').form_mask("(999) 999-9999");
    $('#account_account_detail_attributes_business_fax').form_mask("(999) 999-9999");
  },
  
  validateSignup: function() {
    $("#signup_form").ketchup();
  },
  
  validateModals: function(f) {
    var eid = f.attr('id');
    $("#" + eid).ketchup();
  },

	viewReminderItemFields: function() {
		var cb = $('#attach_item');
		var	fields = $("#reminder_item_fields");
		
		cb.change(function() {
			fields.toggle();
		});
	},
	
	showCustomReminderDate: function() {
		var freq = $('select#reminder_frequency_id');
		var reminderDateField = $("#reminder_date");
		freq.change(function() {
			if ($(this).val() == '1') {
				reminderDateField.show();
			} else {
				reminderDateField.hide();
			}
		});
	}
	
};

var modals = {

	quickLaunchTrigger: function() {
		var trig = $(".ql_trigger");
		trig.overlay({
			top: 35,
			expose: {
				color: '#000',
				loadSpeed: 200,
				opacity: 0.4
			},
			// disable this for modal dialog-type of overlays
			closeOnClick: false,

			onBeforeLoad: function() {
				var wrap = this.getOverlay();
				var link = this.getTrigger();
				var return_path = link.attr('return_path');
				var object_id = link.attr('object_id');
				var form = wrap.find('form');
				
				if (object_id !== "") {
					modals.setObjectParam(form, object_id);
				}
				
				modals.setReturnPath(form, return_path);
				modals.setupModalScroll(wrap);
				forms.validateModals(form);
			}

		});
	},
	
	triggerBusinessFormModal: function() {
		$("#business_form_modal").overlay({
			top: 35,
			expose: {
				color: '#000',
				loadSpeed: 200,
				opacity: 0.4
			},
			// disable this for modal dialog-type of overlays
			closeOnClick: false,

			// load it immediately after the construction
			load: true
		});
	},
	
	setReturnPath: function(form, link) {
		if (link) {
			form.find('.return_path').val(link);
		}
	},
	
	setObjectParam: function(form, oid) {
		form.find('.ajax_object').val(oid);
	},

	setupModalScroll: function(wrap) {
		var form = wrap.find("#modal_form form"),
				scroller = wrap.find("#modal_form .modal_form_wrap"),
				scrollBox = scroller.find(".modal_scroller"),
				panelWrap = scrollBox.find(".modal_panel_wrap"),
				panels = panelWrap.children('.modal_form_section')
				progNav = wrap.find(".progress_nav"),
				progNavLinks = progNav.find("ul li a"),
				stepNav = wrap.find(".next_prev_arrows"),
				prevNav = stepNav.find('a.modal_prev_button'),
				nextNav = stepNav.find('a.modal_next_button'),
				counter = 0
		
		prevNav.hide();
		
		nextNav.click(function() {
			var c = checkForm();
			if (c === true) {
				counter ++
				if (counter > 0) {
					prevNav.show();
				}
				if (counter === 2) {
					nextNav.hide();
				}	
			}
		});
		
		prevNav.click(function() {
			counter -- 
			if (counter === 0) {
				prevNav.hide();
			}
			
			if (counter < 2) {
				nextNav.show();
			}
			
		});
		
		var scrollOptions = {
			target: scrollBox,
			items: panels,
			navigation: progNavLinks,
			cycle: false,
			prev: prevNav,
			next: nextNav,
			axis: 'xy',
			duration: 500,
			easing: 'swing',
			onAfter: trigger,
			onBefore: checkForm
		};

		modals.setScrollerWidth(panelWrap, panels);
		scrollBox.serialScroll(scrollOptions);
		$.localScroll(scrollOptions);
		
		function checkForm() {
			var required_fields = $('.required_step');
			var empty_fields = 0;		
			required_fields.each(function() {
				if ($(this).val() === "") {
					$(this).addClass('empty_required');
					$(this).effect("shake", { times: 1 }, 50);
					empty_fields++;
				} else {
					$(this).removeClass('empty_required');
				}
			});

			if (empty_fields >= 1) {
				return false;
			} else {
				return true;
			}
		}
		
		// Setups a function grab the correct progress nav anchor to pass to a function to set the styles
		function trigger(data) {
			var el = progNav.find('a[href$="' + data.id + '"]').get(0);
			progressNav.setNavState(el);
		}
	},

	setScrollerWidth: function(el, panels) {
		el.width(panels.length * 720);
	},
	
	reminderItemToggle: function() {
		var toggle = $("#attach_item"),
				togglePanel = $("#reminder_item_fields");
				
		toggle.change(function() {
			togglePanel.toggle();
		});	
	}
	
};

var maps = {
  
  initMap: function(container, lg, lt, location_name) {
    
    // Set Long and Lat Object
    var location = new google.maps.LatLng(lt, lg);
    
    // Map Options for a Basic Map
    var mapOptions = {
      center: location,
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    // Init the Map
    var map = new google.maps.Map(document.getElementById(container), mapOptions);
    
    // Create Map Pin
    var mapPin = new google.maps.MarkerImage('/images/map_pin.png',
        // This marker is 20 pixels wide by 32 pixels tall.
        new google.maps.Size(20, 21),
        // The origin for this image is 0,0.
        new google.maps.Point(0,0),
        // The anchor for this image is the base of the flagpole at 0,32.
        new google.maps.Point(0, 21));
    
    // Add Marker
    var mapMarker = new google.maps.Marker({
        position: location,
        animation: google.maps.Animation.DROP,
        map: map,
        icon: mapPin,
        title: location_name
    });
    
    // If we want to init Street View out of the gate.
    // var panoramaOptions = {
    //   position: location,
    //   pov: {
    //     heading: 34,
    //     pitch: 10,
    //     zoom: 1
    //   }
    // };
    // var panorama = new google.maps.StreetViewPanorama(document.getElementById("map"), panoramaOptions);
    // map.setStreetView(panorama);
  }
};

var progressNav = {

	setNavState: function(el) {
		var $el = $(el);
		var elParent = $el.parent();
		var sibs = elParent.siblings();
		sibs.removeClass('active');
		sibs.removeClass('visited');
		elParent.prevAll().addClass('visited');
		elParent.removeClass('visited').addClass('active');
	}

};

var panels = {

	panelActions: function() {
		$('.panel').click(function() {
			panels.swapColor($(this));
		});
	},

	swapColor: function(el) {
		el.siblings('.panel').removeClass('active');
		el.addClass('active');
	},

	setActivePanel: function(p) {
		var activePanels = $('.item_detail_panel.active');
		activePanels.removeClass('active', 400);
		panels.setActiveSelectablePanel(p);
	},

	setActiveSelectablePanel: function(el) {
		el.siblings('.selectable_panel').removeClass('active');
		el.toggleClass('active', 400);
	},

	selectablePanelItems: function() {
		$('.selectable_panel.item_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "item-ajax");
		});
	},

	selectablePanelUser: function() {
		$('.selectable_panel.user_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "user-ajax");
		});
	},

	selectablePanelLocation: function() {
		$('.selectable_panel.location_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "locations-ajax");
		});
	},

	selectablePanelService: function() {
		$('.selectable_panel.service_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "service-ajax");
		});
	},
	
	selectablePanelReminder: function() {
		$('.selectable_panel.reminder_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "reminder-ajax");
		});
	},

	selectablePanelWarranty: function() {
		$('.selectable_panel.warranty_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "tracking-ajax");
		});
	},

	selectablePanelMessage: function() {
		$('.selectable_panel.message_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "message-ajax");
		});
	},

	userIndexAssignPanel: function() {
		$('.selectable_panel').click(function() {
			panels.setActivePanel($(this));
			ajax.setSidebarInfo($(this), "user-ajax");
		});
	}

};

var base = {

	setInternalHovers: function() {
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

	removeListedLinks: function() {
		$('.stop_prop').hide();
	},

	setFade: function(e) {
		e.effect("highlight", {
			color: '#cff2ff'
		},
		1000);
	},
	
	setSubAccountSelector: function() {
		$("#sub_account_toggle_checkbox").removeClass("hidden");
		$("#sub_account_form_field_wrap").addClass("hidden");
	},

	photoToggle: function() {
		var pcb = $("#photo_checkbox .iPhoneCheckContainer");
		pcb.click(function() {
			base.showPhotoUploader();
		});
	},

	documentToggle: function() {
		var dcb = $("#document_checkbox .iPhoneCheckContainer");
		dcb.click(function() {
			base.showDocumentUploader();
		});
	},

	avatarToggle: function() {
		var acb = $("#avatar_checkbox .iPhoneCheckContainer");
		acb.click(function() {
			base.showAvatarUploader();
		});
	},

	logoToggle: function() {
		var acb = $("#logo_checkbox .iPhoneCheckContainer");
		acb.click(function() {
			base.showLogoUploader();
		});
	},

	subAccountToggle: function() {
		var sacb = $("#sub_account_toggle_checkbox");
		sacb.click(function() {
			base.showSubAccountSelect();
		});
	},

	showPhotoUploader: function() {
		$("#photo_form").toggle("slow");
	},

	showAvatarUploader: function() {
		$("#avatar_form").toggle("slow");
	},

	showLogoUploader: function() {
		$("#logo_form").toggle("slow");
	},

	showSubAccountSelect: function() {
		$("#sub_account_form_field_wrap").toggle("slow");
	},

	showDocumentUploader: function() {
		$("#document_form").toggle("slow");
	},

	setDetailLinks: function() {
		$('.trigger_panel').prepend('<a href="" class="detail_trigger">View Details</a>');
		var trigger = $('.detail_trigger');
		trigger.toggle(
		function() {
			var panel = $(this).parents('.internal_panel_wrap');
			var $toggle_box = panel.height();
			var $internal_div = panel.children('.item_detail_list').height();
			var $total_height = $toggle_box + $internal_div;
			panel.first().animate({
				height: '100%'
			},
			500);
		},
		function() {
			var panel = $(this).parents('.internal_panel_wrap');
			panel.first().animate({
				height: '33px'
			},
			500);
		});
	},

	setLoginFormTips: function() {
		$('.form_tip').tipTip({
			defaultPosition: "top"
		});
	},

	setHelpTips: function() {
		$('.help_tip').tipTip({
			defaultPosition: "top"
		});
	},

	insertDateSelect: function(date_select_value) {
		var ds = $("#date_select");
		ds.children('select').remove();
		ds.append('<input class="form_tip" id="item_purchase_date" title="Select the purchase date of the item" name="item[purchase_date]" size="30" type="text" value=' + date_select_value + '>');
		$("#item_purchase_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertCardDateSelect: function(date_select_value) {
		var cds = $("#card_date_select");
		cds.children('select').remove();
		cds.append('<input class="form_tip" id="warranty_warranty_card_mailed_in_date" title="Select the date the warranty card was sent" name="warranty[warranty_card_mailed_in_date]" size="30" type="text" value=' + date_select_value + '>');
		$("#warranty_warranty_card_mailed_in_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertPartExpirationSelect: function(date_select_value) {
		var pe = $("#parts_expiration_select");
		pe.children().remove();
		pe.append('<input class="form_tip validate(required)" id="warranty_part_exp_date" title="Select the part expiration date for the item" name="warranty[parts_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#warranty_part_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertLaborExpirationSelect: function(date_select_value) {
		var le = $("#labor_expiration_select");
		le.children().remove();
		le.append('<input class="form_tip validate(required)" id="warranty_labor_exp_date" title="Select the labor expiration date for the item" name="warranty[labor_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#warranty_labor_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},
	
	insertPartsCardDateSelect: function(date_select_value) {
		var cds = $("#parts_card_date_select");
		cds.children('select').remove();
		cds.append('<input class="form_tip" id="parts_warranty_warranty_card_mailed_in_date" title="Select the date the warranty card was sent" name="warranty[warranty_card_mailed_in_date]" size="30" type="text" value=' + date_select_value + '>');
		$("#parts_warranty_warranty_card_mailed_in_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertPartsPartExpirationSelect: function(date_select_value) {
		var pe = $("#parts_parts_expiration_select");
		pe.children().remove();
		pe.append('<input class="form_tip validate(required)" id="parts_warranty_part_exp_date" title="Select the part expiration date for the item" name="warranty[parts_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#parts_warranty_part_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertPartsLaborExpirationSelect: function(date_select_value) {
		var le = $("#parts_labor_expiration_select");
		le.children().remove();
		le.append('<input class="form_tip validate(required)" id="parts_warranty_labor_exp_date" title="Select the labor expiration date for the item" name="warranty[labor_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#parts_warranty_labor_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertExtendedPartExpirationSelect: function(date_select_value) {
		var epe = $("#extended_parts_select");
		epe.children().remove();
		epe.append('<input class="form_tip validate(required)" id="extended_warranty_part_exp_date" title="Select the part expiration date for the item" name="extended_warranty[parts_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#extended_warranty_part_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertPartsExtendedLaborExpirationSelect: function(date_select_value) {
		var ele = $("#parts_extended_labor_select");
		ele.children().remove();
		ele.append('<input class="form_tip validate(required)" id="parts_extended_warranty_labor_exp_date" title="Select the labor expiration date for the item" name="extended_warranty[labor_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#parts_extended_warranty_labor_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},
	
	insertPartsExtendedPartExpirationSelect: function(date_select_value) {
		var epe = $("#parts_extended_parts_select");
		epe.children().remove();
		epe.append('<input class="form_tip validate(required)" id="parts_extended_warranty_part_exp_date" title="Select the part expiration date for the item" name="extended_warranty[parts_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#parts_extended_warranty_part_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertExtendedLaborExpirationSelect: function(date_select_value) {
		var ele = $("#extended_labor_select");
		ele.children().remove();
		ele.append('<input class="form_tip validate(required)" id="extended_warranty_labor_exp_date" title="Select the labor expiration date for the item" name="extended_warranty[labor_exp]" size="30" type="text" value=' + date_select_value + '>');
		$("#extended_warranty_labor_exp_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertReplacementDateSelect: function(date_select_value) {
		var rd = $("#replacement_date_select");
		rd.children().remove();
		rd.append('<input class="form_tip validate(required)" id="part_replacement_date" title="Select the replacement date for a part" name="part[replacement_date]" size="30" type="text" value=' + date_select_value + '>');
		$("#part_replacement_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
	},

	insertReminderDateSelect: function(date_select_value) {
		var sd = $("#start_date_date_select");
		var rd = $("#reminder_date_select");
		
		sd.children().remove();
		sd.append('<input class="form_tip validate(required)" id="reminder_start_date" title="Select a start date for the reminder." name="reminder[start_date]" size="30" type="text" value=' + date_select_value + '>');
		$("#reminder_start_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
		
		rd.children().remove();
		rd.append('<input class="form_tip validate(required)" id="reminder_reminder_date" title="Select a custom reminder date." name="reminder[start_date]" size="30" type="text" value=' + date_select_value + '>');
		$("#reminder_reminder_date").datepicker({
			changeMonth: true,
			changeYear: true
		});
		
	},
	
	elasticNav: function() {
		$("#main_nav_ul").elasticNav({
			overlap : 10,
			reset : 1000,
			opacity : 0.9
		});
	},
	
	subNav: function() {
		var timeout = null,
				subNav = $("#dashboards"),
				subNavlis = subNav.find("li");
				link = $("#int_dashboard");
				mainNavs = $("ul#main_nav_ul li.nav").not('.inner_nav');
				
		link.click(function(e) {
			e.preventDefault();
		});
		
		mainNavs.mouseover(function() {
			base.closeMenu(timeout);
		});
		
		
		link.mouseover(function() {
			if (timeout) clearTimeout(timeout);
			subNav.slideDown('fast').show();
    });

    // sub menu mouseovers keep dropdown open
    subNavlis.mouseover(function() {
    	if (timeout) clearTimeout(timeout);
    }).mouseout(function() {
    	timeout = setTimeout(base.closeMenu, 500);
    });
	},
	
	closeMenu: function(timeout) {
		$("#dashboards").hide();
    if (timeout) clearTimeout(timeout); 
	}

};

//**********Initialize Document**********//
$(document).ready(function() {

	// injects flash div into dom
	flash.injectFlashBox();
	flash.setFlash();
	ajax.setAjaxNotice();
	ajax.setAjaxCallbacks();
	// base.setInternalHovers();
	base.photoToggle();
	base.documentToggle();
	base.avatarToggle();
	base.logoToggle();
	base.setHelpTips();
	base.removeListedLinks();
	ajax.setLiveDatepicker();
});
