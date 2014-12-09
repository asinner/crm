(function() {
	var app = angular.module('crmApp');
	
	app.factory('Product', ['$resource', function($resource) {
		
		return $resource('/api/products', null, {
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
		});
		
	}]);
	
})()