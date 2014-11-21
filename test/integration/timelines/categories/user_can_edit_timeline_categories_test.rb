require 'test_helper'

class UserCanEditTimelineCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @lead = create_lead(@company)
    @event = create_event(@lead)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline)
  end

  test 'user can update timeline categories with valid data' do
    patch "/api/timelines/#{@timeline.id}/categories/#{@category.id}", {
      category: {
        name: 'My new awesome category'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    category = json(response.body)[:timeline_category]
    assert_equal 'My new awesome category', category[:name]
  end

  test 'user cannot update timeline categories with invalid data' do
    patch "/api/timelines/#{@timeline.id}/categories/#{@category.id}", {
      category: {
        name: nil
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
