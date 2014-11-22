require 'test_helper'

class UserCanDeleteNotesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :note])
  end
  
  test 'user can delete notes' do
    delete "/api/leads/#{@lead.id}/notes/#{@note.id}", {
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 204, response.status
    assert_equal 0, @lead.notes.count
  end
end
