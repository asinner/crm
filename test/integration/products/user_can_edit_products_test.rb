require 'test_helper'

class UserCanEditProductsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @product = create_product(@company)
  end

  test 'user can edit product with valid data' do
    patch "/api/products/#{@product.id}", {
      product: {
        name: 'Photobooth',
        description: 'An elegant photobooth service',
        price: 950.00
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    product = json(response.body)[:product]
    assert_equal 'Photobooth', product[:name]
    assert_equal 'An elegant photobooth service', product[:description]
    assert_equal 95_000, product[:price]
    product = Product.last
    assert_equal @company, product.company
  end

  test 'user cannot edit product with invalid data' do
    patch "/api/products/#{@product.id}", {
      product: {
        name: nil,
        description: 'An elegant photobooth service',
        price: 'Abc'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'
  
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 'Photobooth', @product.name
    assert_equal 75_000, @product.price
  end
end
