require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest  
  test 'create a new user with valid data' do
    post '/api/users', {
      name: 'Andrew Sinner',
      email: 'andrew@example.com',
      password: '12345678'
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
