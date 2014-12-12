(function() {
	var app = angular.module('crmApp');
	
	app.factory('Product', ['$resource', 'Session', function($resource, Session) {
		
		return $resource('/api/products/:id?token=:token', { id: '@id', token: Session.token }, {
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
		});
		
	}]);
	
})()