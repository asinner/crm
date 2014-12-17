(function() {
	
	'use strict';
	
	angular.module('crmApp').factory('DateTime', [function() {
		
		var dateTime = {};
		
		dateTime.newDateWithTime = function(units) {
			var date = new Date();
			if (typeof units.hours != 'undefined') date.setHours(units.hours);
			if (typeof units.mins != 'undefined') date.setMinutes(units.mins);
			if (typeof units.seconds != 'undefined') date.setSeconds(units.seconds);
			return date;
		}
		
		dateTime.addTimeToDate = function(args) {			
			var date = new Date(args.date);
			var time = args.time;
			
			date.setHours(time.getHours());
			date.setMinutes(time.getMinutes());
			date.setSeconds(time.getSeconds());
			
			return date;
		}
		
		return dateTime;
		
	}]);
	
})();