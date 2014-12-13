(function() {
	'use strict';
	
	angular.module('crmApp').controller('LeadCtrl', ['$scope', '$rootScope', '$filter', 'EVENTS', 'Current', 'Lead', function($scope, $rootScope, $filter, EVENTS, Current, Lead) {
		
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
		
		$scope.$on(EVENTS.lead.editForm.show, function(event, data) {
			$scope.show.editForm = true;
		});
		
		$scope.$on(EVENTS.event.currentEventChanged, function(event, data) {
			$scope.currentEvent = data;
		});
		
		$scope.new = function() {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lead.newForm.show);
		};	
		
		$scope.edit = function(lead) {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lead.editForm.show, lead);
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
			$rootScope.$broadcast(EVENTS.event.currentEventChanged);
			Current.setEvent($scope.currentEvent);
		};
		
	}]);
})();