class Api::V1::UploadsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    authorize event
    upload = event.uploads.build(upload_params)
    upload.path = "/uploads/#{SecureRandom.hex(7)}"
    presigned_post = S3_BUCKET.presigned_post(
      key: upload.path,
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

  def destroy
    upload = Upload.find(params[:id])
    authorize upload
    upload.delete
    S3_BUCKET.objects[upload.path].delete
    render status: 204, nothing: true
  end

  private

  def upload_params
    params.require(:upload).permit(:name, :size, :mime_type)
  end
end
