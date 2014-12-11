'use strict';

(function() {
	var app = angular.module('crmApp');
	
	app.controller('CompanyCtrl', ['$scope', 'Company', 'Session', '$location', function($scope, Company, Session, $location) {
		
		$scope.currentCompany = {
			name: ''
		};
		
		$scope.create = function(company) {
			var company = new Company(company);
			company.token = Session.token;
			company.$save().then(
				function(response) {
					$location.path('/dashboard');
				},
				function(response) {
					console.log(response);
				}
			)
		}
		
	}]);
})()