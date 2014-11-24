require 'test_helper'

class UserCanDeleteUploadsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :upload])
  end
  
  test 'user can delete uploads' do
    delete "/api/events/#{@event.id}/uploads/#{@upload.id}", {
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 204, response.status
    assert_equal 0, @event.uploads.count
  end
end
