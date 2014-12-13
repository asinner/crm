(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('Eventt', ['$resource', 'Session', function($resource, Session) {
		
		return $resource("/api/events/:id?token=:token", { id: '@id', token: Session.token }, {
			
			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
})();