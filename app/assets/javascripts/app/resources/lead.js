(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('Lead', ['$resource', 'Session', function($resource, Session) {
		
		return $resource('/api/leads/:id?token=:token', { id: '@id', token: Session.token }, {
			'query': { method: 'GET', isArray: false},
			'update': { method: 'PATCH' }
		});
		
	}]);

})()