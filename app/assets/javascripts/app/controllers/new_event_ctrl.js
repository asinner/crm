(function() {

	var app = angular.module('crmApp');
	
	app.controller('NewEventCtrl', ['$scope', 'LEAD_EVENTS', 'Event', 'Session', function($scope, LEAD_EVENTS, Event, Session) {
		
		$scope.currentEvent = {
			date: '',
			name: ''
		};
		
		$scope.$on(LEAD_EVENTS.created, function(event, data) {
			console.log(data.lead);
			console.log($scope.currentEvent);
			$scope.create(data.lead, $scope.currentEvent);
		});
				
		$scope.create = function(lead, currentEvent) {
			var eventt = new Event(currentEvent);
			eventt.token = Session.token;
			eventt.lead_id = lead.id;
			eventt.$save().then(
				function(response) {
					$scope.close();
					$scope.currentEvent = {};
					$scope.resetForm();
				},
				function(response) {
					console.log(response);
				}
			)
		};
		
	}]);
	
})();
