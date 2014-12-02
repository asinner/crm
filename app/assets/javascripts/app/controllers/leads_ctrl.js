(function() {
	var app = angular.module('crmApp');
	
	app.controller('LeadsCtrl', ['$scope', 'Lead', 'Session', function($scope, Lead, Session) {
				
		$scope.currentLead = {
			first_name: '',
			last_name: '',
			email: '',
			phone_number: ''
		};
		
		$scope.leads = [];
	
		$scope.create = function(lead) {
			var lead = new Lead($scope.currentLead);
			lead.token = Session.token;
			lead.$save().then(
				function(response) {
					console.log(response);
				},
				function(response, status) {
					console.log([response, status]);
				}
			)
		};
		
	}]);
})()