(function() {
	'use strict';
	
	var app = angular.module('crmApp');
	
	app.service('Deduplicate', function() {
		
		this.updateOrAdd = function(input, list) {
			var results = input;
			angular.forEach(list, function(k, v) {
				var doesNotExist = true;
				angular.forEach(input, function(kk, vv) {
					if (kk.id == k.id) {
						doesNotExist = false;
						results[vv] = k;
					};
				});
				if (doesNotExist) {
					results.push(k);
				}				
			});
			return results;
		};
		
	});
	
})();