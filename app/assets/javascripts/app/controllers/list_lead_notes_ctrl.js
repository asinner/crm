'use strict';

(function() {
	var app = angular.module('crmApp');

	app.controller('ListLeadNotesCtrl', ['$scope', 'Note', 'Session', function($scope, Note, Session) {
		
		$scope.notes = [];
		
		$scope.$on(NOTE_EVENTS.created, function(event, data) {
			$scope.notes = $scope.notes.concat(data);
		});
		
		$scope.$on(NOTE_EVENTS.viewNotes, function(event) {
			Note.query({
				lead_id: $scope.currentLead.id, 
				token: Session.token
			}, function(response) {
				$scope.notes = response.notes;
			});
		});
		
		
	}]);
})()