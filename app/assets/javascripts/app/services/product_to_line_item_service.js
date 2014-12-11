'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.service('ProductToLineItem', function() {
		
		this.defaultQty = 1;
		
		this.create = function(product) {
			return {
				name: product.name,
				description: product.description,
				amount: product.price,
				qty: this.defaultQty
			}
		};
		
	});
	
})();