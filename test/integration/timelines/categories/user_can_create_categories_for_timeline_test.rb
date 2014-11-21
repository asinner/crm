require 'test_helper'

class UserCanCreateCategoriesForTimelineTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @lead = create_lead(@company)
    @event = create_event(@lead)
    @timeline = create_timeline(@event)
  end

  test 'users can create categories for a timeline' do
    post "/api/timelines/#{@timeline.id}/categories", {
      category: {
        name: 'Pre-departure'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    category = json(response.body)[:timeline_category]
    assert_equal 'Pre-departure', category[:name]
    assert_equal 1, @timeline.categories.count
  end

  test 'users cannot create categories for a timeline with invalid data' do
    post "/api/timelines/#{@timeline.id}/categories", {
      category: {
        name: nil
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @timeline.categories.count
  end
end
