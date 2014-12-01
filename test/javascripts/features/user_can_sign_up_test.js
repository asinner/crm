var helper = require('../helper.js');

describe('Signing up a user', function() {
	it('with valid data redirects to a start page', function() {			
		helper.signUp();
		expect(element(by.css('.getting-started')).getText()).toEqual('Getting Started');
	});
});