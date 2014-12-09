(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('Company', ['$resource', function($resource) {
		
		return $resource('/api/companies/:id', null, {
			
			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
})()