(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('EventCtrl', ['$scope', '$rootScope', 'EVENTS', 'Eventt', 'Current', function($scope, $rootScope, EVENTS, Eventt, Current) {
		
		$scope.show = {
			newForm: false,
			editForm: false
		};
		
		$scope.$on(EVENTS.event.newForm.show, function(event, data) {
			$scope.show.newForm = true;
		});
		
		$scope.currentEvent = {
			name: '',
			date: ''
		};
				
		$scope.new = function() {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.event.newForm.show);
		};
		
		$scope.save = function(eventt) {
			if ($scope.show.newForm) {
				$scope.create(eventt);
			} else {
				$scope.update(eventt);
			}
		};
		
		$scope.create = function(eventt) {
			
			console.log(eventt);
			
			var eventt = new Eventt(eventt);
			eventt.lead_id = Current.getLead().id;
			eventt.$save().then(
				function(response) {
					console.log(response);
				},
				function(response) {
					console.log(response);					
				}
			)
		};
		
	}]);
	
})();