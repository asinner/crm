(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('TimelineEventCtrl', ['$scope', '$rootScope', '$filter', 'TimelineEvent', 'Current', 'EVENTS', 'DateTime', function($scope, $rootScope, $filter, TimelineEvent, Current, EVENTS, DateTime) {
				
		$scope.model = {start: {}, end: {}};
		
		$scope.$on(EVENTS.navigation.view.timeline, function(event, data) {
			$scope.setDefaultTimes();
			$scope.model.start.date = Current.event.date;
			$scope.model.end.date = Current.event.date;
		});
		
		$scope.setDefaultTimes = function() {
			$scope.model.start.time = DateTime.newDateWithTime({ hours: 12, mins: 0, seconds: 0 });
			$scope.model.end.time = DateTime.newDateWithTime({ hours: 12, mins: 30, seconds: 0 });			
		};	
				
		$scope.create = function(timelineEvent) {
			
			var timelineEvent = new TimelineEvent(timelineEvent);
			
			timelineEvent.start_time = DateTime.addTimeToDate({
				time: $scope.model.start.time,
				date: $scope.model.start.date
			});
			
			timelineEvent.end_time = DateTime.addTimeToDate({
				time: $scope.model.end.time,
				date: $scope.model.end.date
			});
			
			timelineEvent.timeline_id = Current.event.timeline.id;
			timelineEvent.$save().then(
				function(response) {
					$rootScope.$broadcast(EVENTS.timelineEvent.created, response.timeline_event);
					$scope.model.body = '';
				},
				function(response) {
					console.log(response);					
				}
			)
		};
				
	}]);
	
})();