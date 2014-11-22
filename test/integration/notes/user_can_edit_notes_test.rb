require 'test_helper'

class UserCanEditNotesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :note])
  end

  test 'user can edit notes with valid data' do
    patch "/api/leads/#{@lead.id}/notes/#{@note.id}", {
      note: {
        body: 'This note body was updated!'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    note = json(response.body)[:note]
    assert_equal 'This note body was updated!', note[:body]
  end

  test 'user cannot edit note with invalid data' do
    patch "/api/leads/#{@lead.id}/notes/#{@note.id}", {
      note: {
        body: nil
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 'An awesome note', @note.body
  end
end
