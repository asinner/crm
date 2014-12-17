(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('ListTimelineEventsCtrl', ['$scope', 'EVENTS', 'TimelineEvent', 'Current', function($scope, EVENTS, TimelineEvent, Current) {
		
		$scope.events = [];
		
		$scope.$on(EVENTS.timelineEvent.created, function(event, data) {
			$scope.events.push(data);
		});
		
		$scope.$on(EVENTS.navigation.view.timeline, function(event, data) {
			$scope.list(Current.event.timeline);
		});
		
		$scope.list = function(timeline) {
			TimelineEvent.query({timeline_id: timeline.id}, 
				function(response) {
					$scope.events = response.timeline_events;
				},
				function(response) {
					console.log(response);					
				}
			)
		};
		
	}]);
	
})();