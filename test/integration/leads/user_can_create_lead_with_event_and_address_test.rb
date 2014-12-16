require 'test_helper'

class UserCanCreateLeadWithEventAndAddressTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company])
  end
  
  test 'user can create lead with event and address' do
    post "/api/leads?token=#{@user.authentication_token}", {
      first_name: 'Andrew',
      last_name: 'Sinner',
      email: 'andrew@example.com',
      phone_number: '(555) 555-5555',
      events_attributes: [
        {
          name: 'Some event name',
          date: rand(30..180).days.from_now,
          address_attributes: {
            line1: '123 Main St',
            line2: nil,
            city: 'New York',
            state: 'NY',
            zip: '11101'
          }
        }
      ]
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    lead = json(response.body)[:lead]
    assert_equal 'Andrew', lead[:first_name]
    assert_equal 'Sinner', lead[:last_name]
    assert_equal 'andrew@example.com', lead[:email]    
    assert_equal '(555) 555-5555', lead[:phone_number]
    assert_equal '123 Main St', lead[:events][0][:address][:line1]
    assert_equal 'New York', lead[:events][0][:address][:city]
    assert_equal 'NY', lead[:events][0][:address][:state]
    assert_equal '11101', lead[:events][0][:address][:zip]
  end
end
