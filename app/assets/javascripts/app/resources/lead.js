(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('Lead', ['$resource', function($resource) {
		
		return $resource('/api/leads/:id', null, {
			
			'query': { method: 'GET', isArray: false},
			
			'update': { method: 'PATCH' }
			
		});
		
	}]);

})()