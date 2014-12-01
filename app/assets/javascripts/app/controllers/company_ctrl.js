(function() {
	var app = angular.module('crmApp');
	
	app.controller('CompanyCtrl', ['$scope', 'Company', 'Session', function($scope, Company, Session) {
		
		$scope.currentCompany = {
			name: ''
		};
		
		$scope.create = function(company) {
			var company = new Company(company);
			company.token = Session.token;
			company.$save().then(
				function(response) {
					$window.location.href = '/dashboard';
				},
				function(response) {
					console.log(response);
				}
			)
		}
		
	}]);
})()