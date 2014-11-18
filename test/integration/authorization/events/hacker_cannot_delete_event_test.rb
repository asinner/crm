require 'test_helper'

class HackerCannotDeleteEventTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @company = create_company(@user)
    @event = create_event(@company)
    
    @hacker = create_user('hacker@example.com')
    sign_in(@hacker)
    create_company(@hacker)
  end
  
  test 'user can delete events' do
    delete "/api/events/#{@event.id}", {
      token: @hacker.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    res = json(response.body)
    assert_equal 403, response.status
    assert_equal 'You are not authorized for that resource', res[:msg]
  end  
end
