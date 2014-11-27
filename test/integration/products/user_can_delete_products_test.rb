require 'test_helper'

class UserCanDeleteProductsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @product = create_product(@company)
  end

  test 'user can delete product' do
    delete "/api/products/#{@product.id}", {
      token: @user.authentication_token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 204, response.status
    assert_equal 0, Product.count
    assert_equal 0, @company.products.count
  end
end
