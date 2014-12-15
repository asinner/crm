require 'test_helper'

class UserCanCreateEventsWithAddressTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead])
  end
  
  test 'user can create events with valid address' do
    post "/api/events?token=#{@user.authentication_token}", {
      name: 'Some event',
      date: rand(30..180).days.from_now,
      address_attributes: {
        line1: '123 Main St',
        line2: nil,
        city: 'New York',
        state: 'NY',
        zip: '11101'
      },
      lead_id: @lead.id
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]
    assert_equal '123 Main St', event[:address][:line1]
    assert_equal 'New York', event[:address][:city]
    assert_equal 'NY', event[:address][:state]
    assert_equal '11101', event[:address][:zip]
    assert_equal 1, Address.count
  end
end
