(function() {
	var app = angular.module('crmApp');
	
	app.controller('LeadsCtrl', ['$scope', 'Lead', 'Session', '$rootScope', 'LEAD_EVENTS', function($scope, Lead, Session, $rootScope, LEAD_EVENTS) {

		$scope.currentLead = {
			first_name: '',
			last_name: '',
			email: '',
			phone_number: ''
		};
		$scope.currentEvent = {
			estimate_location: ''
		};
	
		$scope.create = function(lead) {
			var lead = new Lead($scope.currentLead);
			lead.token = Session.token;
			lead.$save().then(
				function(response) {
					$scope.currentLead = {
						first_name: '',
						last_name: '',
						email: '',
						phone_number: ''
					}
					$rootScope.$broadcast(LEAD_EVENTS.created, {
						lead: response.lead
					});
				},
				function(response, status) {
					console.log([response, status]);
				}
			)
		};
		
	}]);
})()