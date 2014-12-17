(function() {
	
	'use strict';
	
	angular.module('crmApp').factory('TimelineEvent', ['$resource', 'Session', function($resource, Session) {
		
		return $resource("/api/timeline_events/:id?token=:token", { id: '@id', token: Session.token }, {
			'query': { method: 'GET', isArray: false },
			'update': { method: 'PATCH' }
		});
		
	}]);
	
})();