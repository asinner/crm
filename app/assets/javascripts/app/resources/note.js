(function() {
	
	var app = angular.module('crmApp');
	
	app.factory('Note', ['$resource', function($resource) {
	
		return $resource('/api/notes/:id', { id: '@id' }, {
			
			'query': { method: 'GET', isArray: false},
			
			'update': { method: 'PATCH' }
			
		});
		
	}]);
	
})()