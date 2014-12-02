(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('LeadListCtrl', ['$scope', 'Lead', 'Session', function($scope, Lead, Session) {
		
		Lead.query({token: Session.token},
			function(response) {
				$scope.leads = response.leads;
			}
		);
		
		
	}]);
	
})()