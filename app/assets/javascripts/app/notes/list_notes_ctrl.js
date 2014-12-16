(function() {

	'use strict';
	
	angular.module('crmApp').controller('ListNotesCtrl', ['$scope', 'EVENTS', 'Current', 'Note', function($scope, EVENTS, Current, Note) {
		
		$scope.notes = [];
		
		$scope.$on(EVENTS.note.created, function(event, data) {
			$scope.notes = $scope.notes.concat(data);
		});
		
		$scope.$on(EVENTS.current.event.changed, function(event, data) {
			$scope.list(Current.event);
		});
		
		$scope.$on(EVENTS.navigation.view.notes, function(event, data) {
			$scope.list(Current.event);
		});
		
		$scope.list = function(eventt) {
			Note.query({event_id: eventt.id}, 
				function(response) {
					$scope.notes = response.notes;
				},
				function(response) {
					console.log(response);
				}
			)
		};
		
		$scope.destroy = function(note) {
			var note = new Note(note);
			note.$delete().then(
				function(response) {
					angular.forEach($scope.notes, function(k, v) {
						if (k.id == note.id) {
							$scope.notes.splice(v, 1);
						};
					});
				},
				function(response) {
					
				}
			);
		};
		
	}]);
	
})();
