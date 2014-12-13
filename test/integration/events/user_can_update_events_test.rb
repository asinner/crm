require 'test_helper'

class UserCanUpdateEventsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event])
    sign_in(@user)
  end
  
  test 'user can update event with valid data' do    
    patch "/api/events/#{@event.id}/?token=#{@user.authentication_token}", {
      name: 'Updated name'
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]    
    assert_equal 'Updated name', event[:name]
  end
  
  test 'user cannot update event with invalid data' do    
    patch "/api/events/#{@event.id}/?token=#{@user.authentication_token}", {
      date: nil
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal @event.date, @event.reload.date
  end
end
