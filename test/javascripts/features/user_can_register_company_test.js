var helper = require('../helper.js');

describe('User can register company', function() {
	it('and be taken to product form', function() {
		helper.signUp();
		expect(element(by.css('.active')).getText()).toEqual('Company');
	});
});