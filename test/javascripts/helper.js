module.exports = {
	signUp: function() {
		browser.get('/sign-up');
		element(by.model('currentUser.name')).sendKeys('Andrew Sinner');
		element(by.model('currentUser.email')).sendKeys('andrew' + new Date().getTime() + '@example.com');
		element(by.model('currentUser.password')).sendKeys('andrew@example.com');
		element(by.id('new-user-submit')).click();
	}
};