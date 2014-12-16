require 'test_helper'

class UserCanListUploadsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event])
    sign_in(@user)
    10.times do
      create_upload(@event)
    end
    
    5.times do
      create_upload(@event, Faker::Name.name, Faker::Name.name, false)
    end
  end
  
  test 'user can list uploads' do
    get "/api/uploads?token=#{@user.authentication_token}&event_id=#{@event.id}", {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    uploads = json(response.body)[:uploads]    
    assert_equal 10, uploads.count
  end
end
