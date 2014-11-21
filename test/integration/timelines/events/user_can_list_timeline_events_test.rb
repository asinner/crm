require 'test_helper'

class UserCanListTimelineEventsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @lead = create_lead(@company)
    @event = create_event(@lead)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline)
    10.times do
      create_timeline_event(@category, Faker::Lorem.sentence)
    end
  end

  test 'user can list timeline events' do
    get "/api/timeline_categories/#{@category.id}/events?token=#{@user.token}",
        nil,
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    categories = json(response.body)[:timeline_events]
    assert_equal 10, categories.count
  end
end
