(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('Event', ['$resource', function($resource) {
		
		return $resource("/api/events", null, {
			
			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
})();