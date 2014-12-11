'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ProductCtrl', ['$scope', 'ProductToLineItem', function($scope, ProductToLineItem) {
		
		$scope.addToEstimate = function(product) {
			var lineItem = new LineItem(ProductToLineItem.new(product));
		};
		
	}]);
	
})();