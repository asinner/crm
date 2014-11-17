require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest  
  test 'creates a new user with valid data' do
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
    user = json(response.body)
    assert_equal 'Andrew Sinner', user[:name]
    assert_equal 'andrew@example.com', user[:email]
  end
end
