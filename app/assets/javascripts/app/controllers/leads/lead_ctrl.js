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
		
		$scope.setActiveTab = function(tab) {
			$scope.activeTab = tab;
		};
		
		$scope.edit = function(lead) {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lead.editForm.show, lead);
		};
		
		$scope.update = function(lead) {
			var lead = new Lead(lead);
			lead.$update().then(
				function(response) {
					
				},
				function(response) {
					
				}
			)
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
				
	}]);
})();