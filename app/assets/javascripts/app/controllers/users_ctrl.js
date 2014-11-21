(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('UsersCtrl', [ '$scope', '$http', 'User', function($scope, $http, User) {

		$scope.currentUser = {
			name: '',
			email: '',
			password: ''
		};

		$scope.create = function() {
			var user = new User($scope.currentUser);
			user.$save().then(
				function(response) {
					console.log(response);
				},
				function(response) {
					console.log(response.data);
				}
			);
		};
				
	}]);
	
})()
