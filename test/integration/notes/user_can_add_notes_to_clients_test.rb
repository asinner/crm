require 'test_helper'

class UserCanAddNotesToClientsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead])
  end
  
  test 'user can add notes to client with valid data' do
    post "/api/leads/#{@lead.id}/notes", {
      note: {
        body: 'This is an awesome note body'
      },
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    note = json(response.body)[:note]
    assert_equal 'This is an awesome note body', note[:body]
    assert_equal 1, @lead.notes.count
  end
  
  test 'user cannot add note with invalid data' do
    post "/api/leads/#{@lead.id}/notes", {
      note: {
        body: nil
      },
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @lead.notes.count
  end
end
