(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('User', ['$resource', function($resource) {
		
		return $resource('/api/users/:id', null, {
			
			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
})()