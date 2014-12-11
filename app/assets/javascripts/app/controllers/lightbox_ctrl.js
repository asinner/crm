'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('LightboxCtrl', ['$scope', 'EVENTS', function($scope, EVENTS) {
		
		$scope.show = false;

		$scope.close = function() {
			$scope.$broadcast(EVENTS.lightbox.close);
			$scope.show = false;
		};
		
		$scope.$on(EVENTS.lightbox.show, function(event) {
			$scope.show = true;
		});
		
	}]);
	
})();