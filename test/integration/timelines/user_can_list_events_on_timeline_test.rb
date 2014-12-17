require 'test_helper'

class UserCanListEventsOnTimelineTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :timeline])
    10.times do
      create_timeline_event(@timeline)
    end
    sign_in(@user)
  end
  
  test 'user can list events on timeline' do
    get "/api/timeline_events?token=#{@user.authentication_token}&timeline_id=#{@timeline.id}", {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    timeline_events = json(response.body)[:timeline_events]
    assert_equal 10, timeline_events.count
  end
end
