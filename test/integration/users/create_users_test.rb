require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest
  test 'creates a new user with valid data' do
    post '/api/users', {
      user: {
        name: 'Andrew Sinner',
        email: 'andrew@example.com',
        password: '12345678'
      }
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    user = json(response.body)[:user]
    assert_equal 'Andrew Sinner', user[:name]
    assert_equal 'andrew@example.com', user[:email]
    assert_equal 1, User.count
  end

  test 'does not create a new user with invalid data' do
    post '/api/users', {
      user: {
        name: 'Andrew Sinner',
        password: '12345678'
      }
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, User.count
  end
end
