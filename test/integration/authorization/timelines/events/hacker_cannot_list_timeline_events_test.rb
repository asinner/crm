require 'test_helper'

class HackerCannotListTimelineItemsTest < ActionDispatch::IntegrationTest
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

    @hacker = create_user('hacker@example.com')
    sign_in(@hacker)
    create_company(@hacker)
  end

  test 'user can list timeline events' do
    get "/api/timeline_categories/#{@category.id}/events?token=#{@hacker.authentication_token}",
        nil,
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'

    res = json(response.body)
    assert_equal 403, response.status
    assert_equal 'You are not authorized for that resource', res[:msg]
  end
end
