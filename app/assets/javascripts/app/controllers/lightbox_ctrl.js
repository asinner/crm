(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('LightboxCtrl', ['$scope', 'LIGHTBOX_EVENTS', function($scope, LIGHTBOX_EVENTS) {
		
		$scope.show = false;

		$scope.close = function() {
			$scope.$broadcast(LIGHTBOX_EVENTS.close);
			$scope.show = false;
		};
		
		$scope.$on(LIGHTBOX_EVENTS.show, function(event) {
			$scope.show = true;
		});
		
	}]);
	
})();