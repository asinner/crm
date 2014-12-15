(function() {
	'use strict';
	
	angular.module('crmApp').controller('ListEventsCtrl', ['$scope', '$rootScope', 'Eventt', 'Current', 'EVENTS', function($scope, $rootScope, Eventt, Current, EVENTS) {
		
		$scope.list = function() {
			Eventt.query({},
				function(response) {
					$scope.events = response.events;
				},
				function(response) {
					console.log(response);		
				}
			)
		};
		
		$scope.show = function(eventt) {
			Current.event = eventt;
		};
		
		$scope.list();
		
	}]);

})();