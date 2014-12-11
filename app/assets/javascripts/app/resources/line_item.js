(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('LineItem', ['$resource', function($resource) {
		
		return $resource('/api/line_items/:id?token=:token', { id: '@id', token: '@token' }, {
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
		});
		
	}]);
		
})();