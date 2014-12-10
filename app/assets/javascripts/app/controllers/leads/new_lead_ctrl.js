(function() {
	var app = angular.module('crmApp');
	
	app.controller('NewLeadCtrl', ['$scope', 'Lead', 'Session', '$rootScope', 'LEAD_EVENTS', 'LIGHTBOX_EVENTS', function($scope, Lead, Session, $rootScope, LEAD_EVENTS, LIGHTBOX_EVENTS) {
		
		$scope.show = false;
		
		// Listeners
		$scope.$on(LIGHTBOX_EVENTS.close, function(event, data) {
			$scope.show = false;
		});
		
		$scope.$on(LEAD_EVENTS.showForm, function(event, data) {
			$scope.show = true;
		});
		
		$scope.show = false;
		
		$scope.resetForm = function() {
			$scope.newLead.$setPristine();
			$scope.newLead.$setUntouched();
		};

		$scope.currentLead = {
			first_name: '',
			last_name: '',
			email: '',
			phone_number: ''
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