require 'test_helper'

class UserCanListTimelineCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @event = create_event(@company)
    @timeline = create_timeline(@event)
    10.times do
      create_category(@timeline, Faker::Lorem.sentence)
    end
  end
  
  test 'user can list timeline categories' do
    get "/api/timelines/#{@timeline.id}/categories?token=#{@user.token}", nil, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    categories = json(response.body)[:timeline_categories]
    assert_equal 10, categories.count
  end
end
