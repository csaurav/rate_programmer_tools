$(document).ready(function () {
	var password_field = $("#user_current_password");
	var other_inputs = $("input[id!='user_current_password'],textarea");
	other_inputs.attr('disabled',true);
	password_field.keyup(function () {
		if(password_field.val().length)
			other_inputs.removeAttr('disabled');
		else
			other_inputs.attr('disabled',true);
	});
});