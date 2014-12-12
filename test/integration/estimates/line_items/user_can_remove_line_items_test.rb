require 'test_helper'

class UserCanRemoveLineItemsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :estimate, :line_item])
  end
  
  test 'user can remove line items' do
    delete "/api/line_items/#{@line_item.id}", {
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 204, response.status
    assert_equal 0, @estimate.items.count
  end
end
