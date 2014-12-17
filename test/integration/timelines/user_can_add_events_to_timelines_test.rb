require 'test_helper'

class UserCanAddEventsToTimelinesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :timeline])
  end
  
  test "user can add events to timeline" do
    post "/api/timeline_events?token=#{@user.authentication_token}", {
      timeline_id: @timeline.id,
      start_time: 10.days.from_now,
      end_time: 10.days.from_now,
      body: 'Some timeline item body'
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    timeline_event = json(response.body)[:timeline_event]
    assert_equal 'Some timeline item body', timeline_event[:body]
    assert_equal 1, @timeline.events.count
  end
end
