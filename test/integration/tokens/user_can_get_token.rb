require 'test_helper'

class UserCanGetTokenTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: 'Andrew Sinner',
      email: 'andrew@example.com',
      password: '12345678'
    )
  end
  
  test 'user can sign in with valid credentials' do
    post '/api/tokens', {
      email: @user.email,
      password: @user.password
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    res = json(response.body)
    assert_not_nil res[:token]
  end
  
  test 'user can sign in with valid credentials' do
    post '/api/tokens', {
      email: @user.email,
      password: nil
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 401, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
