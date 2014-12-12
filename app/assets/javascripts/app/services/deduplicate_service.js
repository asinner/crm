(function() {
	'use strict';
	
	var app = angular.module('crmApp');
	
	app.service('Deduplicate', function() {
		
		this.updateOrAdd = function(input, list) {
						
			// List to return
			var results = input;
			
			// Loop through the list to add
			angular.forEach(list, function(k, v) {
				
				// Assume it doesn't already exist
				var doesNotExist = true;
				
				// Loop through input list
				angular.forEach(input, function(kk, vv) {
					
					// If there is a match..
					if (kk.id == k.id) {
						
						// The record exists
						doesNotExist = false;
						
						// And update the results
						results[vv] = k;
						
					};
					
				});
				
				// Add the object it did not already exist
				if (doesNotExist) {
					results.push(k);
				}
				
			});
			
			// Return the results
			return results;
		};
		
	});
	
})();