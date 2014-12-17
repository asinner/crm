(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('ListUploadsCtrl', ['$scope', 'EVENTS', 'Current', 'Upload', function($scope, EVENTS, Current, Upload) {
		
		$scope.uploads = [];
		
		$scope.$on(EVENTS.navigation.view.files, function(event, data) {
			$scope.list(Current.event);
		});
		
		$scope.$on(EVENTS.current.event.changed, function(event, data) {
			$scope.list(Current.event);
		});
		
		$scope.list = function(event) {
			Upload.query({event_id: event.id},
				function(response) {
					$scope.uploads = response.uploads;
				},
				function(response) {
					
				}
			)
		};
		
	}]);
	
})();