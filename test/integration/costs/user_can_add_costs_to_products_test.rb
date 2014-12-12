require 'test_helper'

class UserCanAddCostsToProductsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :product])
    sign_in(@user);
  end
  
  test 'user can create cost for product with valid data' do
    post '/api/costs', {
      name: 'Paper & Ink',
      description: 'HitiJet printer supplies',
      amount: 100.25,
      qty: 1,
      product_id: @product.id,
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    cost = json(response.body)[:cost]
    assert_equal 'Paper & Ink', cost[:name]
    assert_equal 'HitiJet printer supplies', cost[:description]
    assert_equal 100.25, cost[:amount]
    assert_equal @product.id, cost[:product_id]
  end
  
  test 'user cannot create cost for product with invalid data' do
    post '/api/costs', {
      name: '',
      description: 'HitiJet printer supplies',
      amount: 100.25,
      qty: 1,
      product_id: @product.id,
      token: @user.authentication_token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, Cost.count
  end
end
