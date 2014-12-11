'use strict';

(function() {
	var app = angular.module('crmApp');
	
	app.controller('ShowLeadCtrl', ['$scope', '$rootScope', '$filter', 'Current', 'EVENTS', function($scope, $rootScope, $filter, Current, EVENTS) {
		
		$scope.$on(EVENTS.lead.show, function(event, data) {
			Current.setEvent($filter('orderBy')(data.events, 'date')[0]);
			Current.setLead(data);
			$scope.currentEvent = Current.getEvent();
			$scope.currentLead = Current.getLead();
			$scope.setActiveTab('information');
		});
		
		$scope.setSelectedEvent = function(event) {
			$scope.selectedEvent = event;
		};
		
		$scope.viewTab = function(tab) {
			$scope.setActiveTab(tab);
			if (tab == 'info') $rootScope.$broadcast(EVENTS.navigation.viewInfoTab);
			if (tab == 'notes') $rootScope.$broadcast(EVENTS.navigation.viewNotesTab);
			if (tab == 'estimate') $rootScope.$broadcast(EVENTS.navigation.viewEstimateTab);
			if (tab == 'expenseReport') $rootScope.$broadcast(EVENTS.navigation.viewExpenseReportTab);
		};
		
		$scope.setActiveTab = function(tab) {
			$scope.activeTab = tab;
		};
		
		$scope.setCurrentLead = function(lead) {
			$scope.currentLead = lead;
		};
		
	}]);
})();