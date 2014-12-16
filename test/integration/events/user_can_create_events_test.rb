require 'test_helper'

class UserCanCreateEventsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead])
  end
  
  test 'user can create event with valid data' do
    date = rand(30..180).days.from_now
    
    post "/api/events?token=#{@user.authentication_token}", {
      name: 'Appleton Wedding',
      date: date,
      lead_id: @lead.id
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]    
    assert_equal 'Appleton Wedding', event[:name]
    assert_equal date.to_i, DateTime.parse(event[:date]).to_i
    assert_equal @lead.id, event[:lead_id]
  end
  
  test 'user cannot create event with invalid data' do
    date = rand(30..180).days.from_now
    
    post "/api/events?token=#{@user.authentication_token}", {
      name: 'Appleton Wedding',
      date: nil,
      lead_id: @lead.id
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, Event.count
  end
end
