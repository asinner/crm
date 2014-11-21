require 'test_helper'

class UserCanCreateProductsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
  end

  test 'user can create product with valid data' do
    post '/api/products', {
      product: {
        name: 'Photobooth',
        description: 'An elegant photobooth service',
        price: 150.00
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    product = json(response.body)[:product]
    assert_equal 'Photobooth', product[:name]
    assert_equal 'An elegant photobooth service', product[:description]
    assert_equal 15_000, product[:price]
    product = Product.last
    assert_equal @company, product.company
  end

  test 'user cannot create product with invalid data' do
    post '/api/products', {
      product: {
        name: nil,
        description: 'An elegant photobooth service',
        price: 150.00
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @company.products.count
  end
end
