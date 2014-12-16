require 'test_helper'

class UserCanAddNotesToEventTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event])
  end
  
  test 'user can add notes to event with valid data' do
    post "/api/notes?token=#{@user.authentication_token}", {
      body: 'Some new note body',
      event_id: @event.id
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    note = json(response.body)[:note]
    assert_equal 'Some new note body', note[:body]
    assert_equal @event.id, note[:event_id]
    assert_equal 1, @event.notes.count
  end
  
  test 'user cannot add notes to event with invalid data' do
    post "/api/notes?token=#{@user.authentication_token}", {
      body: nil,
      event_id: @event.id
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @event.notes.count
  end
end
