require "test_helper"

class CanFindUserByEmailTest < ActionDispatch::IntegrationTest
  setup do
    create_user('my-awesome-user@example.com')
  end
  
  test 'can find user with registered email' do
    get '/api/users/emails?email=my-awesome-user@example.com', {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
  end
  
  test 'cannot find user with unregistered email' do
    get '/api/users/emails?email=bad-email@example.com', {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 404, response.status

    get '/api/users/emails', {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 404, response.status
  end
end
