(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('LeadListCtrl', ['$scope', 'Lead', 'Session', 'LEAD_EVENTS', '$rootScope', function($scope, Lead, Session, LEAD_EVENTS, $rootScope) {
		
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
		
		$scope.viewLead = function(lead) {
			$rootScope.$broadcast(LEAD_EVENTS.viewLead, lead);
			$scope.activeLead = lead.id;
		};
		
		
	}]);
	
})()