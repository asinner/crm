describe('Signing up a user', function() {
	it('with valid data redirects to a start page', function() {			
		browser.get('/');
		element(by.id('call-to-sign-up')).click();
		element(by.model('currentUser.name')).sendKeys('Andrew Sinner');
		element(by.model('currentUser.email')).sendKeys('andrew' + new Date().getTime() + '@example.com');
		element(by.model('currentUser.password')).sendKeys('andrew@example.com');
		element(by.id('new-user-submit')).click();
		expect(element(by.css('.getting-started')).getText()).toEqual('Getting Started');
	});
});