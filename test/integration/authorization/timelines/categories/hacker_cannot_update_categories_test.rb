require 'test_helper'

class HackerCannotUpdateCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @company = create_company(@user)
    @lead = create_lead(@company)
    @event = create_event(@lead)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline, Faker::Lorem.sentence)

    @hacker = create_user('hacker@example.com')
    sign_in(@hacker)
    create_company(@hacker)
  end

  test 'hacker cannot update category' do
    patch "/api/timelines/#{@timeline.id}/categories/#{@category.id}", {
      category: {
        name: 'L33t h@x'
      },
      token: @hacker.authentication_token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    res = json(response.body)
    assert_equal 403, response.status
    assert_equal 'You are not authorized for that resource', res[:msg]
  end
end
