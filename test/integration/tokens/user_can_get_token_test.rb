require 'test_helper'

class UserCanGetTokenTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
  end

  test 'user can get token with valid credentials' do
    post '/api/tokens', {
      email: @user.email,
      password: @user.password
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    res = json(response.body)
    assert_not_nil res[:token]
  end

  test 'user cannot get token without valid credentials' do
    post '/api/tokens', {
      email: @user.email,
      password: nil
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 401, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
