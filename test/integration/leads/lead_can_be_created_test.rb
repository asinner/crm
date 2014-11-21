require 'test_helper'

class LeadCanBeCreatedTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
  end
  
  test 'lead can be created with valid data' do
    post '/api/leads', {
      lead: {
        first_name: 'Andrew',
        last_name: 'Sinner',
        email: 'andrew@example.com',
        phone_number: '(555) 123-4567'
      },
      token: @user.token
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
    assert_equal '(555) 123-4567', lead[:phone_number]
    lead = Lead.last
    assert_equal @company, lead.company
  end
end
