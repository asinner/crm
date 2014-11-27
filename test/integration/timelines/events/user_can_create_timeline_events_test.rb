require 'test_helper'

class UserCanCreateTimelineEventsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @lead = create_lead(@company)
    @event = create_event(@lead)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline)
  end

  test 'user can create timeline events with valid data' do
    post "/api/timeline_categories/#{@category.id}/events", {
      timeline_event: {
        description: 'This is an event happening on the timeline'
      },
      token: @user.authentication_token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:timeline_event]
    assert_equal 'This is an event happening on the timeline', event[:description]
    assert_equal 1, @category.events.count
  end

  test 'user cannot create timeline events with invalid data' do
    post "/api/timeline_categories/#{@category.id}/events", {
      timeline_event: {
        description: nil
      },
      token: @user.authentication_token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @category.events.count
  end
end
