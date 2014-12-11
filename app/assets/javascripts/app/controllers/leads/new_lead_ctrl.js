'use strict';

(function() {
	var app = angular.module('crmApp');
	
	app.controller('NewLeadCtrl', ['$scope', 'Lead', 'Session', '$rootScope', 'EVENTS', function($scope, Lead, Session, $rootScope, EVENTS) {
		
		$scope.show = false;
		
		// Listeners
		$scope.$on(LIGHTBOX_EVENTS.close, function(event, data) {
			$scope.newLead.$setPristine();
			$scope.newLead.$setUntouched();
			$scope.show = false;
		});
		
		$scope.$on(LEAD_EVENTS.showForm, function(event, data) {
			$scope.show = true;
		});
				
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
	
		$scope.currentEvent = {
			name: '',
			date: ''
		};
	
		$scope.create = function(lead) {
			var lead = new Lead($scope.currentLead);
			lead.events_attributes = [ $scope.currentEvent ];
			lead.token = Session.token;
			lead.$save().then(
				function(response) {
					$scope.currentLead = {
						first_name: '',
						last_name: '',
						email: '',
						phone_number: ''
					};
					$scope.resetForm();
					$scope.$broadcast(EVENTS.lead.created, response.lead);
				},
				function(response, status) {
					console.log([response, status]);
				}
			)
		};
		
	}]);
})()