require 'test_helper'

class UserCanDeleteTimelineEventsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @event = create_event(@company)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline)
    @timeline_event = create_timeline_event(@category)
  end

  test 'user can delete timeline events' do
    delete "/api/timeline_categories/#{@category.id}/events/#{@timeline_event.id}", {
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 204, response.status
    assert_equal 0, @category.events.count
  end
end
