require 'test_helper'

class UserCanListProductsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company])
    sign_in(@user)
    10.times do
      create_product(@company)
    end
  end
  
  test 'user can list products' do
    get "/api/products?token=#{@user.authentication_token}", {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    products = json(response.body)[:products]
    assert_equal 10, products.count
  end
end
