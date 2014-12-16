require 'test_helper'

class UserCanListNotesForEventTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event])
    sign_in(@user)
    10.times do
      create_note(@event)
    end
  end
  
  test 'user can list notes for event' do
    get "/api/notes?token=#{@user.authentication_token}&event_id=#{@event.id}", {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    notes = json(response.body)[:notes]
    assert_equal 10, notes.count
  end
end
