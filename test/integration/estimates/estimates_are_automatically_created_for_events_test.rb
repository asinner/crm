require 'test_helper'

class EstimatesAreAutomaticallyCreatedForEventsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead])
    sign_in(@user)
  end
  
  test 'an estimate is created for a new event' do
    post '/api/events', {
      name: '',
      date: rand(30..180).days.from_now,
      lead_id: @lead.id,
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]
    assert_equal 1, Estimate.count
    assert_equal event[:id], Estimate.last.event_id
  end
end
