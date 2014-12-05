(function() {
	var app = angular.module('crmApp');

	app.controller('ListLeadNotesCtrl', ['$scope', 'Note', 'Session', 'NOTE_EVENTS', function($scope, Note, Session, NOTE_EVENTS) {
		
		$scope.notes = [];
		
		$scope.$on(NOTE_EVENTS.created, function(event, data) {
			$scope.notes = $scope.notes.concat(data);
		});
		
		$scope.$on(NOTE_EVENTS.viewNotes, function(event) {
			Note.query({
				leadId: $scope.currentLead.id, 
				token: Session.token
			}, function(response) {
				$scope.notes = response.notes;
			});
		});
		
		
	}]);
})()