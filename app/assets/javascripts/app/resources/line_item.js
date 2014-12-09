(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('LineItem', ['$resource', function($resource) {
		
		return $resource('/api/line_items/:id', { id: '@id' }, {
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
		});
		
	}]);
	
})();