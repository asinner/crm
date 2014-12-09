require 'test_helper'

class UserCanAddLineItemsToEstimateTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :estimate])
    sign_in(@user)
  end
  
  test 'user can add line items to estimate with valid data' do
    post '/api/line_items', {
      name: 'Vintage Photobooth',
      description: 'A unique photobooth for your event',
      amount: 750,
      qty: 1,
      estimate_id: @estimate.id,
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'applciation/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    line_item = json(response.body)[:line_item]
    assert_equal 'Vintage Photobooth', line_item[:name]
    assert_equal 'A unique photobooth for your event', line_item[:description]
    assert_equal 750, line_item[:amount]
    assert_equal 1, line_item[:qty]
    assert_equal @estimate.id, line_item[:estimate_id]
  end
  
  test 'user cannot add line items to estimate with invalid data' do
    post '/api/line_items', {
      name: nil,
      description: 'A unique photobooth for your event',
      amount: 750,
      qty: 1,
      estimate_id: @estimate.id,
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'applciation/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @estimate.items.count
  end
end
