require 'test_helper'

class UserCanUpdateTimelineEventTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @event = create_event(@company)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline)
    @timeline_event = create_timeline_event(@category)
  end

  test 'user can update timeline events with valid data' do
    patch "/api/timeline_categories/#{@category.id}/events/#{@timeline_event.id}", {
      timeline_event: {
        description: 'My newly updated timeline event'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:timeline_event]
    assert_equal 'My newly updated timeline event', event[:description]
  end

  test 'user cannot update timeline events with ivalid data' do
    patch "/api/timeline_categories/#{@category.id}/events/#{@timeline_event.id}", {
      timeline_event: {
        description: nil
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
