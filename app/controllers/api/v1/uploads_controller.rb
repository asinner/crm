class Api::V1::UploadsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    event = Event.find(params[:event_id])
    authorize event
    upload = event.uploads.build(upload_params)
    upload.url = "/uploads/#{SecureRandom.hex(7)}"
    presigned_post = S3_BUCKET.presigned_post(
      key: upload.url,
      acl: :private,
      success_action_status: 201,
      content_length: 0..1.gigabytes
    )
        
    if upload.save
      render status: 201, json: { 
        presigned_post: presigned_post.fields,
        url: presigned_post.url,
        upload: upload
      }
    else
      render status: 422, json: upload.errors
    end
  end
  
  private
  
  def upload_params
    params.require(:upload).permit(:name, :size, :mime_type)
  end
end
