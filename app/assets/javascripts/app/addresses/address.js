(function() {
	
	'use strict';
	
	angular.module('crmApp').factory('Address', ['$resource', 'Session', function($resource, Session) {
		
		return $resource("/api/addresses/:id?token=:token", { id: '@id', token: Session.token }, {
			
			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
	
})();