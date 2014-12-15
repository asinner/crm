require 'test_helper'

class UserCanUpdateEventAddressesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :address])
  end
  
  test 'user can update event address' do
    patch "/api/addresses/#{@address.id}?token=#{@user.authentication_token}", {
      line1: '12345 Example St',
      city: 'Nowhere',
      state: 'Somewhere'
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    address = json(response.body)[:address]
    assert_equal '12345 Example St', address[:line1]
    assert_equal 'Nowhere', address[:city]
    assert_equal 'Somewhere', address[:state]
  end
end
