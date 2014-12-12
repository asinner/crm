(function() {
	var app = angular.module('crmApp');
	
	app.filter('telephoneNumber', function() {
		return function(input, format) {
			input = input.replace(/[^0-9]/g, '');
			for (var i=0; i < input.length; i++) {
				format.replace('*', input[i]);
			};
			return input;
		};
	});
	
})()