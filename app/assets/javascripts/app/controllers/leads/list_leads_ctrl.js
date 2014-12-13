'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListLeadsCtrl', ['$scope', 'Lead', 'Session', '$rootScope', '$filter', 'EVENTS', function($scope, Lead, Session, $rootScope, $filter, EVENTS) {
				
		$scope.leads = [];
		
		// Listeners
		$scope.$on(EVENTS.lead.created, function(event, lead) {
			$scope.leads = $scope.leads.concat(lead);
		});
		
		$scope.$on(EVENTS.event.created, function(event, data) {
			$scope.leads[$scope.leads.indexOf(data.lead)].events.push(data.event);
		});
		
		$scope.search = function(lead) {
			var query = angular.lowercase($scope.query) || '';
			if (query == '') return true;
			var name = angular.lowercase(lead.first_name + ' ' + lead.last_name);
			if (name.indexOf(query) != -1) return true;
			return false;
		}
		
		Lead.query({token: Session.token},
			function(response) {
				$scope.leads = response.leads;
			}
		);
						
		$scope.upcomingEvent = function(lead) {
			var events = $filter('orderBy')(lead.events, 'date');
			return events[0].date;
		};
		
		$scope.show = function(lead) {
			$rootScope.$broadcast(EVENTS.lead.show, lead);
		};
		
	}]);
	
})()