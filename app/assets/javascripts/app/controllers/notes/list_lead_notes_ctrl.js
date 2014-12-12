'use strict';

(function() {
	var app = angular.module('crmApp');

	app.controller('ListLeadNotesCtrl', ['$scope', 'Note', 'Session', 'EVENTS', function($scope, Note, Session, EVENTS) {
		
		$scope.notes = [];
		
		$scope.$on(EVENTS.note.created, function(event, data) {
			$scope.notes = $scope.notes.concat(data);
		});
		
		$scope.$on(EVENTS.navigation.viewNotesTab, function(event) {
			Note.query({
				lead_id: $scope.currentLead.id, 
				token: Session.token
			}, function(response) {
				$scope.notes = response.notes;
			});
		});
		
		
	}]);
})()