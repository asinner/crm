(function() {
	var app = angular.module('crmApp');
	
	app.controller('ShowLeadCtrl', ['$scope', 'LEAD_EVENTS', 'NOTE_EVENTS', '$rootScope', '$filter', function($scope, LEAD_EVENTS, NOTE_EVENTS, $rootScope, $filter) {
		
		$scope.$on(LEAD_EVENTS.show, function(event, data) {
			$scope.setCurrentLead(data);
			$scope.setSelectedEvent($filter('orderBy')(data.events, 'date')[0]);
			$scope.setActiveTab('information');
		});
		
		$scope.setSelectedEvent = function(event) {
			$scope.selectedEvent = event;
		};
		
		$scope.viewTab = function(tab) {
			$scope.setActiveTab(tab);
			if (tab == 'info') $rootScope.$broadcast(LEAD_EVENTS.viewInfo);
			if (tab == 'notes') $rootScope.$broadcast(NOTE_EVENTS.viewNotes);
			
			if (tab == 'estimate') $rootScope.$broadcast(LEAD_EVENTS.viewEstimate, {
				lead: $scope.currentLead
			});

			if (tab == 'expense-report') $rootScope.$broadcast(LEAD_EVENTS.viewExpenseReport);
			if (tab == 'order') $rootScope.$broadcast(LEAD_EVENTS.viewOrder);
		};
		
		$scope.setActiveTab = function(tab) {
			$scope.activeTab = tab;
		};
		
		$scope.setCurrentLead = function(lead) {
			$scope.currentLead = lead;
		};
		
	}]);
})();