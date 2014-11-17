require 'test_helper'

class UserCanListEventsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    10.times do
      create_event(@company, Faker::Name.name)
    end
  end
  
  test 'user can list events' do
    get "/api/events?token=#{@user.token}", nil, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    events = json(response.body)[:events]
    assert_equal 10, events.count
  end
end
