'use strict';

(function() {
	var app = angular.module('crmApp');

	app.controller('ListLeadNotesCtrl', ['$scope', 'Note', 'Session', 'EVENTS', 'Current', function($scope, Note, Session, EVENTS, Current) {
		
		$scope.notes = [];
		
		$scope.$on(EVENTS.note.created, function(event, data) {
			$scope.notes = $scope.notes.concat(data);
		});
		
		$scope.$on(EVENTS.navigation.view.notes, function(event) {
			$scope.list();
		});
		
		$scope.$on(EVENTS.lead.show, function(event) {
			if ($scope.activeTab == 'notes') {
				$scope.list();
			}
		});
		
		$scope.list = function() {
			Note.query({
				lead_id: Current.getLead().id, 
				token: Session.token
			}, function(response) {
				$scope.notes = response.notes;
			});
		};
		
	}]);
})()