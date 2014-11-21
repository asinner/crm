require 'test_helper'

class HackerCannotCreateTimelineItemsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @event = create_event(@company)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline)

    @hacker = create_user('hacker@example.com')
    sign_in(@hacker)
    create_company(@hacker)
  end

  test 'user can create timeline events with valid data' do
    post "/api/timeline_categories/#{@category.id}/events", {
      timeline_event: {
        description: 'This is an event happening on the timeline'
      },
      token: @hacker.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    res = json(response.body)
    assert_equal 403, response.status
    assert_equal 'You are not authorized for that resource', res[:msg]
  end
end
