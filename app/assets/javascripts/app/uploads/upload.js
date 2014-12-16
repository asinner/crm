(function() {
	
	'use strict';
	
	angular.module('crmApp').factory('Upload', ['$resource', 'Session', function($resource, Session) {
		
		return $resource("/api/uploads/:id?token=:token", { id: '@id', token: Session.token }, {
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
		});
		
	}]);
	
})();