(function() {
	
	'use strict';
	
	angular.module('crmApp').service('FormCleaner', [ function() {
		
		var formCleaner = {};
		
		formCleaner.clean = function(form) {
			form.$setPristine();
			form.$setUntouched();
		};
		
		return formCleaner;
		
	}]);
	
})();