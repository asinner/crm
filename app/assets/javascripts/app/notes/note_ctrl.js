(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('NoteCtrl', [ '$scope', '$rootScope', 'Note', 'Current', 'EVENTS', function($scope, $rootScope, Note, Current, EVENTS) {
		
		$scope.model = {};
		
		$scope.create = function(note) {
			var note = new Note(note);
			note.event_id = Current.event.id;
			note.$save(
				function(response) {
					$scope.model = {};
					$rootScope.$broadcast(EVENTS.note.created, response.note);
				},
				function(response) {
					
				}
			)
		};
		
	}]);
	
})();