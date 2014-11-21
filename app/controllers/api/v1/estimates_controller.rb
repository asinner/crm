class Api::V1::EstimatesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    authorize event
    estimate = event.build_estimate
    
    if event.save
      render status: 201, json: estimate
    else
      render status: 422, json: estimate.errors
    end
  end
end
