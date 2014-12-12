'use strict';

(function() {
	var app = angular.module('crmApp');
	
	app.controller('NewLeadNoteCtrl', ['$scope', 'Note', 'Session', '$rootScope', 'EVENTS', function($scope, Note, Session, $rootScope, EVENTS) {
				
		$scope.currentNote = {
			body: ''
		};
		
		$scope.create = function(note) {
			var note = new Note($scope.currentNote);
			note.lead_id = $scope.currentLead.id;
			note.token = Session.token;
			note.$save().then(
				function(response) {
					$rootScope.$broadcast(EVENTS.note.created, response.note);
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