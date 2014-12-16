(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('EventCtrl', ['$scope', '$rootScope', 'Eventt', 'Current', 'EVENTS', 'FormCleaner', function($scope, $rootScope, Eventt, Current, EVENTS, FormCleaner) {
		
		$scope.show = { edit: false, new: false };
		
		$scope.current = Current;
		
		$scope.$on(EVENTS.event.edit, function(event, data) {
			$scope.show.edit = true;
			$scope.model = data;
		});
		
		$scope.$on(EVENTS.lightbox.close, function(event, data) {
			$scope.show = { edit: false, new: false };
			FormCleaner.clean($scope.eventForm);
		});
		
		$scope.$on(EVENTS.event.new, function(event, data) {
			$scope.show.new = true;
		});
		
		$scope.edit = function(eventt) {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.event.edit, eventt);
		};
		
		$scope.save = function(eventt) {
			if ($scope.show.new) {
				$scope.create(eventt);
			} else {
				$scope.update(eventt);
			}
		};
		
		$scope.update = function(eventt) {
			var eventt = new Eventt(eventt);
			eventt.$update(
				function(response) {
					$scope.close();
				},
				function(response) {
					console.log(response);
				}
			);
		};
		
	}]);
	
})();