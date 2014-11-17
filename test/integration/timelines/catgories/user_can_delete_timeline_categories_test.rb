require 'test_helper'

class UserCanDeleteTimelineCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @event = create_event(@company)
    @timeline = create_timeline(@event)
    @category = create_category(@timeline)
  end
  
  test 'user can delete timeline categories' do
    delete "/api/timelines/#{@timeline.id}/categories/#{@category.id}", {
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 204, response.status
    assert_equal 0, @timeline.categories.count
  end
end
