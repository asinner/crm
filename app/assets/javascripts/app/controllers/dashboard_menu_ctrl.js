(function() {
	var app = angular.module('crmApp');
	
	app.controller('DashboardMenuCtrl', ['$scope', '$http', 'Session', function($scope, $http, Session) {
		
		$scope.leads = [{
			first_name: 'andrew',
			last_name: 'sinner',
		}];
		
		$http({
			method: 'GET',
			url: '/api/leads?token=' + Session.token
		})
		 .success(function(response, data) {
			
		})
		.error(function(response, data) {
			
		});
		
	}]);
})()