require 'test_helper'

class UserCanEditLineItemsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :estimate, :line_item])
    sign_in(@user)
  end
  
  test 'user can edit line items with valid data' do
    patch "/api/line_items/#{@line_item.id}", {
      name: 'An updated name',
      amount: 1000,
      description: 'An updated description',
      estimate_id: @estimate.id,
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert Mime::JSON, response.content_type
    line_item = json(response.body)[:line_item]
    assert_equal 'An updated name', line_item[:name]
    assert_equal 1000, line_item[:amount]
  end
  
  test 'user cannot edit line items with invalid data' do
    patch "/api/line_items/#{@line_item.id}", {
      name: nil,
      amount: 1000,
      description: 'An updated description',
      estimate_id: @estimate.id,
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert Mime::JSON, response.content_type
  end
end
