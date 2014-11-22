require 'test_helper'

class CreateLineItemsForEstimateTest < ActionDispatch::IntegrationTest
  setup do 
    create([:user, :company, :lead, :event, :product, :estimate])
  end
  
  test 'line item can be added to estimates' do
    post "/api/estimates/#{@estimate.id}/items", {
      product_id: @product.id,
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert 1, @estimate.items.count
  end
end
