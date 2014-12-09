(function() {
	
	var app = angular.module('crmApp');
	
	app.service('Session', function() {
		
		this.create = function(token) {
			this.token = token;
		};
		
	});
	
})();