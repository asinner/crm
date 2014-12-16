(function() {
	
	angular.module('crmApp').factory('Eventt', ['$resource', 'Session', function($resource, Session) {
		
		return $resource("/api/events/:id?token=:token", { id: '@id', token: Session.token }, {
			
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
})();