require 'test_helper'

class UserCanListLeadNotesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead])
    10.times do
      create_note(@lead)
    end
  end
  
  test 'user can list leads' do
    get "/api/leads/#{@lead.id}/notes?token=#{@user.authentication_token}", {
     'Accept' => 'application/json',
     'Content-Type' => 'application/json' 
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    notes = json(response.body)[:notes]
    assert_equal 10, notes.length
  end  
end
