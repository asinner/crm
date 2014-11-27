(function() {
	var app = angular.module('crmApp');
	
	app.directive('unique', function($q, $timeout) {
	  return {
	    require: 'ngModel',
	    link: function(scope, elm, attrs, ctrl) {
	      ctrl.$asyncValidators.unique = function(modelValue, viewValue) {
							
	      	if (ctrl.$isEmpty(modelValue)) return $q.when();
        
	        var def = $q.defer();

 					$timeout(function() {
						scope.findByUnique(modelValue)
						.then(
							function() {
								// Is not unique
								def.reject();
							},
							function() {
								// Is unique
								def.resolve();
							}
						);
	        }, 200);
        
	        return def.promise;
	      };
	    }
	  };
	});
	
})()