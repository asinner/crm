(function() {
	var app = angular.module('crmApp');
	
	app.controller('TokensCtrl', ['$scope', 'AuthService', '$location', '$window', function($scope, AuthService, $location, $window) {
		
		$scope.error = '';
		
		$scope.credentials = {
			email: '',
			password: ''
		};
		
		$scope.create = function() {
			AuthService.login($scope.credentials).then(
				function(user) {
					$scope.error = '';
					$window.location.href = '/dashboard';					
					//$rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
					//$location.path('/dashboard');
					//$scope.setCurrentUser(user);
				},
				function(error) {
					$scope.error = error;
					//$rootScope.$broadcast(AUTH_EVENTS.loginFailed, error);
				}
			);
		};
		
	}]);
})()