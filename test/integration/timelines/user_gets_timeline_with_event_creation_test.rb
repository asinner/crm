require 'test_helper'

class UserGetsTimelineWithEventCreationTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company])
    sign_in(@user)
  end
  
  test "user gets timeline with event creation" do
    post "/api/leads?token=#{@user.authentication_token}", {
      first_name: 'Andrew',
      last_name: 'Sinner',
      email: 'andrew@example.com',
      events_attributes: [
        {
          date: rand(30..180).days.from_now
        }
      ]
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    puts response.body
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]
    assert_equal 1, Timeline.count
    assert_not_nil event[:timeline]
  end
end
