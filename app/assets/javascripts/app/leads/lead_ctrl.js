(function() {
	'use strict';
	
	angular.module('crmApp').controller('LeadCtrl', ['$scope', '$rootScope', '$filter', 'EVENTS', 'Current', 'Lead', 'FormCleaner', function($scope, $rootScope, $filter, EVENTS, Current, Lead, FormCleaner) {
		
		$scope.model = {};
		
		$scope.addressModel = {};
		
		$scope.eventModel = {};
		
		$scope.show = { edit: false, new: false };
		
		$scope.$on(EVENTS.lightbox.close, function(event, data) {
			$scope.model = {};
			$scope.addressModel = {};
			$scope.eventModel = {};
			$scope.show = { edit: false, new: false };
			FormCleaner.clean($scope.leadForm);
		});
				
		$scope.$on(EVENTS.lead.new, function(event, data) {
			$scope.show.new = true;
		});
		
		$scope.$on(EVENTS.lead.edit, function(event, data) {
			$scope.show.edit = true;
		});
		
		$scope.new = function() {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lead.new);
		};	
		
		$scope.edit = function(lead) {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lead.editForm.show, lead);
		};
		
		$scope.create = function(lead, eventt, address) {
			var lead = new Lead(lead);
			eventt.address_attributes = address;
			lead.events_attributes = [ eventt ];
			lead.$save(
				function(response) {					
					$rootScope.$broadcast(EVENTS.event.created, response.event);
					$scope.close();
				},
				function(response) {
					console.log(response);
				}
			)
		};
		
		$scope.update = function(lead) {
			var lead = new Lead(lead);
			lead.$update().then(
				function(response) {
					$scope.close();
				},
				function(response) {
					console.log(response);
				}
			)
		};
		
	}]);
})();