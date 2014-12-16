require 'test_helper'

class UserCanDestroyNotesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :note])
    sign_in(@user)
  end
  
  test 'user can destroy notes' do
    delete "/api/notes/#{@note.id}?token=#{@user.authentication_token}"

    assert_equal 204, response.status
    assert_equal 0, Note.count
  end
end
