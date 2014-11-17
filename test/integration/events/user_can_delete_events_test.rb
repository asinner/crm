require 'test_helper'

class UserCanDeleteEventsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @event = create_event(@company)
  end
  
  test 'user can delete events' do
    delete "/api/events/#{@event.id}", {
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 204, response.status
    assert_equal 0, @user.company.events.count
  end
end
