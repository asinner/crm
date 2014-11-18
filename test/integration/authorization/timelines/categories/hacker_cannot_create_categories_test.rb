require 'test_helper'

class HackerCannotCreateCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    @company = create_company(@user)
    @event = create_event(@company)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline, Faker::Lorem.sentence)
    
    @hacker = create_user('hacker@example.com')
    sign_in(@hacker)
    create_company(@hacker)
  end

  
  test 'users can create categories for a timeline' do
    post "/api/timelines/#{@timeline.id}/categories", {
      category: {
        name: 'Pre-departure'
      },
      token: @hacker.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    res = json(response.body)
    assert_equal 403, response.status
    assert_equal 'You are not authorized for that resource', res[:msg]    
  end
end
