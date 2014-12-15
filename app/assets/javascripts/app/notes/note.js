(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('Note', ['$resource', 'Session', function($resource, Session) {
	
		return $resource('/api/notes/:id?token=:token', { id: '@id', token: Session.token }, {
			
			'query': { method: 'GET', isArray: false},

			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
})()