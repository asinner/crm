(function() {
	var app = angular.module('crmApp');
	
	app.controller('ApplicationCtrl', ['$scope', '$location', '$cookieStore', 'AuthService', function($scope, $location, $cookieStore, AuthService) {
		
		$scope.currentUser = null;
		
		AuthService.restoreCredentialsFromCookies().then(
			function(user) {
				$scope.setCurrentUser(user);
			}
		);
		
		$scope.setCurrentUser = function(user) {
			$scope.currentUser = user;
		};
			
	}]);
})()