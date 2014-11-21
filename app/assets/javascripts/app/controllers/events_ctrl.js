(function() {
	var app = angular.module('crmApp');
	
	app.controller('EventsCtrl', ['$scope', '$http', function($scope, $http) {
		
		
		$scope.events = [];
		
		$http({
			method: 'GET',
			url: '/events.json'
		}).then(
			function(data, status) {
				$scope.events = $scope.events.concat(data['data']);
			}, 
			function(data, status) {
				console.log([data, status]);
			}
		);
						
	}]);
})()