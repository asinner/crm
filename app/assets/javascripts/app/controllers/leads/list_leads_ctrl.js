(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListLeadsCtrl', ['$scope', 'Lead', 'Session', 'LEAD_EVENTS', 'LIGHTBOX_EVENTS', '$rootScope', '$filter', function($scope, Lead, Session, LEAD_EVENTS, LIGHTBOX_EVENTS, $rootScope, $filter) {
				
		$scope.leads = [];
		
		$scope.$on(LEAD_EVENTS.created, function(event, data) {
			$scope.leads = $scope.leads.concat(data.lead);
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
		
		$scope.showNewLead = function() {
			$rootScope.$broadcast(LIGHTBOX_EVENTS.show);
			$rootScope.$broadcast(LEAD_EVENTS.showNewLead);
		};
		
		$scope.showLead = function(lead) {
			$rootScope.$broadcast(LEAD_EVENTS.show, lead);
		};
		
		$scope.upcomingEvent = function(lead) {
			var events = $filter('orderBy')(lead.events, 'date');
			return events[0].date;
		};
		
		
	}]);
	
})()