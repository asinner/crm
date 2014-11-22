require 'test_helper'

class LeadCanCreateEstimatesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event])
  end
  
  test 'lead can create estimate after an event is created' do
    post "/api/events/#{@event.id}/estimate", {
      estimate: {
      },
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    estimate = json(response.body)[:estimate]
    assert_equal @event.id, estimate[:event_id]
  end
end
