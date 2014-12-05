(function() {
	var app = angular.module('crmApp');
	
	app.controller('NewLeadNoteCtrl', ['$scope', 'Note', 'Session', 'LEAD_EVENTS', function($scope, Note, Session, LEAD_EVENTS) {
				
		$scope.currentNote = {
			body: ''
		};
		
		$scope.create = function(note) {
			var note = new Note($scope.currentNote);
			note.lead_id = $scope.currentLead.id;
			note.token = Session.token;
			note.$save().then(
				function(response) {
					$scope.currentNote = {};
					$scope.newLeadNoteForm.setPristine();
				},
				function(response) {
					console.log(response);					
				}
			);
		};
		
	}]);
})()