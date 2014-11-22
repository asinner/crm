require 'test_helper'

class UserCanListLineItemsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :estimate])
    
    products = []
    10.times do
      products.push(create_product(@company))
    end

    products.each do |p|
      @estimate.items << p
    end
    @estimate.save
  end
  
  test "user can list line items for estimate" do
    get "/api/estimates/#{@estimate.id}/items?token=#{@user.token}", {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 200, response.status
    items = json(response.body)[:line_items]
    assert_equal 10, items.count
  end
end
