(function() {
	var app = angular.module('crmApp');
	
	app.controller('NewLeadNoteCtrl', ['$scope', 'Note', 'Session', '$rootScope', function($scope, Note, Session, $rootScope) {
				
		$scope.currentNote = {
			body: ''
		};
		
		$scope.create = function(note) {
			var note = new Note($scope.currentNote);
			note.lead_id = $scope.currentLead.id;
			note.token = Session.token;
			note.$save().then(
				function(response) {
					$rootScope.$broadcast(NOTE_EVENTS.created, response.note);
					$scope.currentNote = {};
					$scope.newLeadNoteForm.$setPristine();
				},
				function(response) {
					console.log(response);					
				}
			);
		};
		
	}]);
})()