(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('EventCtrl', ['$scope', '$rootScope', 'EVENTS', 'Eventt', 'Current', function($scope, $rootScope, EVENTS, Eventt, Current) {
		
		$scope.show = {
			newForm: false,
			editForm: false
		};
		
		$scope.currentEvent = {
			name: '',
			date: ''
		};
		
		$scope.$on(EVENTS.lightbox.close, function(event, data) {
			$scope.resetForm();
			$scope.hideForms();
			$scope.resetCurrentLead();
		});
		
		$scope.$on(EVENTS.event.newForm.show, function(event, data) {
			$scope.show.newForm = true;
		});
		
		$scope.$on(EVENTS.event.editForm.show, function(event, data) {
			$scope.currentEvent = data;
			$scope.show.editForm = true;
		});
				
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
			var eventt = new Eventt(eventt);
			eventt.lead_id = Current.getLead().id;
			eventt.$save().then(
				function(response) {
					Current.getLead().events.push(response.event);
					Current.setEvent(response.event);
					$rootScope.$broadcast(EVENTS.event.currentEventChanged, response.event);
					$scope.close();
				},
				function(response) {
					console.log(response);					
				}
			)
		};
		
		$scope.update = function(eventt) {
			var eventt = new Eventt(eventt);
			eventt.$update().then(
				function(response) {
					$scope.close();
				},
				function(response) {
					console.log(response);					
				}
			)
		};
		
		$scope.edit = function() {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.event.editForm.show, Current.getEvent());
		};
		
		$scope.resetForm = function() {
			$scope.eventForm.$setPristine();
			$scope.eventForm.$setUntouched();
		};
		
		$scope.hideForms = function() {
			$scope.showDeleteConfirm = false;
			$scope.show.newForm = false;
			$scope.show.editForm = false;
		};		
		
		$scope.resetCurrentLead = function() {
			$scope.currentEvent = {
				name: '',
				date: ''
			}
		};
		
		
	}]);
	
})();