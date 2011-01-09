
var hns_validations = {
	
	signupValidations: function() {
    $('#signup_form').validate({
      rules: {
        "user[first_name]": {required: true, minlength: 2, lettersonly: true},
				"user[last_name]": {required: true, minlength: 2, lettersonly: true},
        "user[email]": {required: true, email: true},
				"user[phone]": {required: true, phoneUS: true},
				"location[address]": {required: true, alphanumeric: true, spaces: true},
				"location[city]": {required: true, lettersonly: true},
				"location[state_id]": "required",
				"location[zipcode]": {required: true, digits: true, minlength: 5, maxlength: 5},
				"user[username]": "required",
				"user[password]": "required",
				"user[password_confirmation]": {required: true, equalTo: "#user_password"},
				"chargify[credit_card]": {required: true, creditcard: true},
				"chargify[cvv]": {required: true, digits: true, minlength: 3, maxlength: 4},
				"chargify[billing_zip]": {required: true, digits: true, minlength: 5, maxlength: 5}
      },
      messages: {
				"user[first_name]": {
					required: "First name required", 
					minlength: "Minimum 2 Chars", 
					lettersonly: "Letters only"
				},
				
				"user[last_name]": {
					required: "Last name required", 
					minlength: "Minimum 2 Chars", 
					lettersonly: "Letters only"
				},
				
        "user[email]": {
          required: "Please enter an email address", 
          email: "your email is not valid."
				},
				
				"user[phone]": {
					required: "Phone number required", 
					phoneUS: "Invalid phone number"
				},
				"location[address]": {
					required: "Enter a valid address", 
					alphanumeric: "Letters and numbers only"
				},
				"location[city]": {
					required: "Enter a City",
					lettersonly: "Enter letters only"
				},
				"location[state_id]": "Select a state",
				"location[zipcode]": {
					required: "Must be a valid Zip", 
					digits: "Numbers only", 
					minlength: "Must be 5 numbers",
					maxlength: "Must be 5 numbers"
				},
				"user[username]": "Is required",
				"user[password]": "Required",
				"user[password_confirmation]": {
					required: "Password Confirmation",
					equalTo: "Passwords don't match"
				},
				"chargify[credit_card]": {
					required: "Credit Card Required", 
					creditcard: "Invalid Credit Card"
				},
				"chargify[cvv]": {
					required: "# Req",
					digits: "# Only", 
					minlength: "Min 3 #",
					maxlength: "Max 4 #"
				},
				"chargify[billing_zip]": {
					required: "Billing Zip Required", 
					digits: "Numbers only", 
					minlength: "Must be 5 numbers",
					maxlength: "Must be 5 numbers"
				}		
      }
    });

	},

	warrantyItemValidations: function() {
		$('#warranty_item_form').validate({
    	rules: {
				"warranty_item[name]": {required: true, minlength: 2},
				"warranty_item[item_serial_number]": {required: true, minlength: 2, alphanumeric: true},
				"warranty_item[purchased_from]": {required: true, minlength: 2, alphanumeric: true},
      	"warranty_item[item_model]": {required: true, minlength: 2},
				"warranty_item[item_make]": {required: true, minlength: 2},
				"warranty_item[original_cost]": {required: true, digits: true}
			},
			messages: {
				"warranty_item[name]": {
					required: "Item name required", 
					minlength: "2 Characters Minimum"
				},
				"warranty_item[item_serial_number]": {
					required: "Enter a Valid Serial Number", 
					minlength: "Minimum 2 Characters Required", 
					alphanumeric: "Letters and Numbers Only"
				},
				"warranty_item[item_model]": {
					required: "Enter a Item Model", 
					minlength: "Minimum 2 Characters"
				},
				"warranty_item[purchased_from]": {
					required: "Enter Retailer", 
					minlength: "Must be Minimum 2 Characters", 
					alphanumeric: "Letters and Numbers Only"
				},
				"warranty_item[item_make]": {
					required: "Enter Manufacturer Name", 
					minlength: "Minimum 2 Characters"
				},
				"warranty_item[original_cost]": {
					required: "Enter Original Cost", 
					digits: "Enter Numbers Only"
				}
			}	
		});
 	}

};