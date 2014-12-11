(function() {
	var app = angular.module('crmApp');
	
	app.controller('ShowLeadCtrl', ['$scope', '$rootScope', '$filter', 'Current', function($scope, $rootScope, $filter, Current) {
		
		$scope.$on(LEAD_EVENTS.show, function(event, data) {
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
			if (tab == 'info') $rootScope.$broadcast(LEAD_EVENTS.viewInfo);
			if (tab == 'notes') $rootScope.$broadcast(NOTE_EVENTS.viewNotes);
			if (tab == 'estimate') $rootScope.$broadcast(LINE_ITEM_EVENTS.showLineItems);
			if (tab == 'expenseReport') $rootScope.$broadcast(LEAD_EVENTS.viewExpenseReport);
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