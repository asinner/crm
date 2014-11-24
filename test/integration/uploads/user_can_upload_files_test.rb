require 'test_helper'

class UserCanUploadFilesTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event])
  end
  
  test 'user can upload file information with valid data' do
    post "/api/events/#{@event.id}/uploads", {
      upload: {
        name: 'Some Document.docx',
        size: 1_234_567,
        mime_type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      },
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    
    presigned_post = json(response.body)[:presigned_post]
    url = json(response.body)[:url]
    upload = json(response.body)[:upload]
    
    assert_equal ENV['AWS_ACCESS_KEY_ID'], presigned_post[:AWSAccessKeyId]
    assert_equal 'private', presigned_post[:acl]
    assert_equal "#{S3_BUCKET.name}.s3.amazonaws.com", url[:host]
    assert_not_nil presigned_post[:key]
    assert_not_nil presigned_post[:policy]
    assert_not_nil presigned_post[:signature]
    assert_equal 'Some Document.docx', upload[:name]
    assert_equal 1_234_567, upload[:size]
    assert_equal 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', upload[:mime_type]
    assert_equal 1, @event.uploads.count
  end
  
  test 'user cannot upload file information with invalid data' do
    post "/api/events/#{@event.id}/uploads", {
      upload: {
        name: nil,
        size: 1_234_567,
        type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      },
      token: @user.token
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @event.uploads.count
  end
end
