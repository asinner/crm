class Api::V1::UploadsController < ApplicationController
  before_action :authenticate_user!

  def index
    event = Event.find(params[:event_id])
    authorize event
    uploads = event.uploads    
    render status: 200, json: event.uploads
  end

  def create
    event = Event.find(params[:event_id])
    authorize event
    upload = event.uploads.build(upload_params)

    upload.url = loop do
      url = "uploads/#{SecureRandom.hex(10)}"
      break url unless Upload.exists?(url: url)
    end
    
    presigned_post = S3_BUCKET.presigned_post(
      key: upload.url,
      acl: :private,
      success_action_status: 201,
      content_length: 0..10.megabytes
    )

    if upload.save
      render status: 201, json: {
        presigned_post: presigned_post.fields,
        url: presigned_post.url.to_s,
        upload: upload
      }
    else
      render status: 422, json: upload.errors
    end
  end

  def destroy
    upload = Upload.find(params[:id])
    authorize upload
    upload.delete
    S3_BUCKET.objects[upload.path].delete
    render status: 204, nothing: true
  end

  def update
    upload = Upload.find(params[:id])
    authorize upload.event
    
    if upload.update(update_params)
      render status: 200, json: upload
    else
      render status: 422, json: upload.errors
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:name, :size, :mime_type)
  end
  
  def update_params
    params.require(:upload).permit(:uploaded);
  end
end
