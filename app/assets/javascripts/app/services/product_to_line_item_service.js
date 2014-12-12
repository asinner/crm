'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.service('ProductToLineItem', function() {
		
		this.role = 'revenue';
		
		this.qty = 1;
		
		this.create = function(product) {
			return {
				product_id: product.id,
				name: product.name,
				description: product.description,
				amount: product.price,
				qty: this.qty,
				role: this.role
			}
		};
		
	});
	
})();