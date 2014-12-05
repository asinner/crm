(function() {
	var app = angular.module('crmApp');
	
	app.controller('ViewLeadCtrl', ['$scope', 'LEAD_EVENTS', '$rootScope', function($scope, LEAD_EVENTS, $rootScope) {
		
		$scope.$on(LEAD_EVENTS.viewLead, function(event, data) {
			$scope.setActiveTab('info');
			$scope.setCurrentLead(data);
		});
		
		$scope.viewTab = function(tab) {
			$scope.setActiveTab(tab);
			if (tab == 'info') $rootScope.$broadcast(LEAD_EVENTS.viewInfo);
			if (tab == 'notes') $rootScope.$broadcast(LEAD_EVENTS.viewNotes);
			if (tab == 'estimate') $rootScope.$broadcast(LEAD_EVENTS.viewEstimate);
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
})()