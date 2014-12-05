(function() {
	var app = angular.module('crmApp');
	
	app.controller('NewLeadNoteCtrl', ['$scope', 'Note', 'Session', 'LEAD_EVENTS', function($scope, Note, Session, LEAD_EVENTS) {
		
		$scope.notes = [];
		
		$scope.$on(LEAD_EVENTS.viewNotes, function(event) {
			Note.query({
				leadId: $scope.currentLead.id, 
				token: Session.token
			}, function(response) {
				$scope.notes = response.notes;
			});
		});
		
		$scope.currentNote = {
			body: ''
		};
		
		$scope.create = function(note) {
			var note = new Note($scope.currentNote);
			note.lead_id = $scope.currentLead.id;
			note.token = Session.token;
			note.$save().then(
				function(response) {
					console.log(response);
				},
				function(response) {
					console.log(response);					
				}
			);
		};
		
	}]);
})()