(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('LeadNavigationCtrl', ['$scope', '$rootScope', 'EVENTS', 'Current', function($scope, $rootScope, EVENTS, Current) {
		
		$scope.current = Current;
		
		$scope.current.tab = 'information';
		
		$scope.viewTab = function(tab) {
			Current.tab = tab;
		};
		
	}]);
	
})();