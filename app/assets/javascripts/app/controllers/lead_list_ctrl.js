(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('LeadListCtrl', ['$scope', 'Lead', 'Session', 'LEAD_EVENTS', function($scope, Lead, Session, LEAD_EVENTS) {
		
		$scope.leads = [];
		
		$scope.$on(LEAD_EVENTS.created, function(event, data) {
			$scope.leads = $scope.leads.concat(data.lead);
		});
		
		Lead.query({token: Session.token},
			function(response) {
				$scope.leads = response.leads;
			}
		);
		
		
	}]);
	
})()