(function() {
	'use strict';
	
	angular.module('crmApp').controller('LeadCtrl', ['$scope', '$rootScope', '$filter', 'EVENTS', 'Current', 'Lead', function($scope, $rootScope, $filter, EVENTS, Current, Lead) {
		
		$scope.currentEvent = {
			name: '',
			date: ''
		};
		
		$scope.show = {
			newForm: false,
			editForm: false
		};
		
		$scope.activeTab = 'information';
		
		$scope.$on(EVENTS.lightbox.close, function(event, data) {
			$scope.resetForm();
			$scope.hideForms();
			$scope.resetCurrentLead();
		});
		
		$scope.$on(EVENTS.lead.show, function(event, data) {
			Current.setLead(data);
			Current.setEvent($filter('orderBy')(data.events, 'date')[0]);
			$scope.currentEvent = Current.getEvent();
			$scope.currentLead = Current.getLead();
		});
		
		$scope.$on(EVENTS.lead.newForm.show, function(event, data) {
			$scope.show.newForm = true;
		});
		
		$scope.$on(EVENTS.lead.editForm.show, function(event, data) {
			$scope.show.editForm = true;
		});
		
		$scope.$on(EVENTS.event.currentEventChanged, function(event, data) {
			$scope.currentEvent = data;
			Current.setEvent(data);
		});
		
		$scope.new = function() {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lead.newForm.show);
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
					$rootScope.$broadcast(EVENTS.lead.created, response.lead);
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
		
		$scope.setActiveTab = function(tab) {
			$scope.activeTab = tab;
		};
		
		$scope.resetForm = function() {
			$scope.leadForm.$setPristine();
			$scope.leadForm.$setUntouched();
		};
		
		$scope.hideForms = function() {
			$scope.showDeleteConfirm = false;
			$scope.show.newForm = false;
			$scope.show.editForm = false;
		};		
		
		$scope.resetCurrentLead = function() {
			$scope.currentLead = {
				first_name: '',
				last_name: '',
				email: '',
				phone_number: ''
			}
		};
				
		$scope.changeCurrentEvent = function() {
			$rootScope.$broadcast(EVENTS.event.currentEventChanged, $scope.currentEvent);
		};
		
	}]);
})();