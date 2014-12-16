require 'test_helper'

class UserCanUpdateLeadsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead])
    sign_in(@user)
  end
  
  test 'user can update lead with valid data' do  
    patch "/api/leads/#{@lead.id}?token=#{@user.authentication_token}", {
      first_name: 'Updated name',
      last_name: 'Updated last name'
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    lead = json(response.body)[:lead]
    assert_equal 'Updated name', lead[:first_name]
    assert_equal 'Updated last name', lead[:last_name]
  end
  
  test 'user cannot update lead with invalid data' do  
    patch "/api/leads/#{@lead.id}?token=#{@user.authentication_token}", {
      first_name: '',
      last_name: 'Updated last name'
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
