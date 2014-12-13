(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('LeadNavigationCtrl', ['$scope', '$rootScope', 'EVENTS', function($scope, $rootScope, EVENTS) {
				
		$scope.viewTab = function(tab) {
			$scope.setActiveTab(tab);
			$rootScope.$broadcast(EVENTS.navigation.view[tab])
		};
		
	}]);
	
})();