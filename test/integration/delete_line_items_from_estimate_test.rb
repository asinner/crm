require 'test_helper'

class DeleteLineItemsFromEstimateTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :product, :estimate])
    @estimate.items << @product
    @estimate.save
  end
  
  test 'user can delete line items from an estimate' do  
    delete "/api/estimates/#{@estimate.id}/items/#{@product.id}", {
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 204, response.status
    assert_equal 0, @estimate.items.count
  end
end
