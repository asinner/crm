require 'test_helper'

class UserCanRemoveTokenTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
  end

  test 'user can remove token with valid credentials' do
    delete '/api/tokens', {
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 200, response.status
    user = User.find(@user.id)
    assert_nil user.token
  end
end
