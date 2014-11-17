require 'test_helper'

class UserCanCreateEventsForCompanyTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
  end
  
  test 'user can create event for company with valid data' do
    post '/api/events', {
      event: {
        name: 'The Awesome Wedding'
      },
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]
    assert_equal 'The Awesome Wedding', event[:name]
    assert_equal 1, @user.company.events.count
  end
  
  test 'user cannot create event for company with invalid data' do
    post '/api/events', {
      event: {
        name: nil
      },
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @user.company.events.count
  end
end