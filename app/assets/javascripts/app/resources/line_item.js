(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('LineItem', ['$resource', 'Session', function($resource, Session) {
		
		return $resource('/api/line_items/:id?token=:token', { id: '@id', token: Session.token }, {
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
		});
		
	}]);
		
})();