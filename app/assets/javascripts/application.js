// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require angular/angular
//= require angular-route/angular-route
//= require angular-resource/angular-resource
//= require angular-animate/angular-animate
//= require angular-cookies/angular-cookies
//= require spin.js/spin.js
//= require angular-spinner/angular-spinner
//= require angular-bootstrap/ui-bootstrap
//= require angular-bootstrap/ui-bootstrap-tpls
//= require crm

$(document).ready(function() {
	$('body').on('keypress', 'input.phone-number', function() {
		var acceptedKeys = [13, 40, 41, 32];
		var acceptedRange = [48, 57];
		if (((event.keyCode < 48 && event.keyCode != 13) && event.keyCode > 57)) return false;
		if ((event.keyCode < 48) || (event.keyCode > 57)) return false;
		var input = $(this).val().replace(/[^0-9]/g, '');	
		if (input.length >= 10) return false;
		var chars = input.split('');
		if (input.length >= 0) chars.splice(0, 0, "(");
		if (input.length >= 3) chars.splice(4, 0, ")");
		if (input.length >= 3) chars.splice(5, 0, " ");
		if (input.length >= 6) chars.splice(9, 0, "-");
		$(this).val(chars.join(''));		
	});
});