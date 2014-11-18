class Api::V1::TimelineEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_company!
  
  def create
    category = TimelineCategory.find(params[:timeline_category_id])
    authorize category.timeline
    
    timeline_event = category.events.new(timeline_event_params)
    
    if timeline_event.save
      render status: 201, json: timeline_event
    else
      render status: 422, json: timeline_event.errors
    end
  end
  
  def update
    timeline_event = TimelineEvent.find(params[:id])
    authorize timeline_event.category.timeline
    
    if timeline_event.update(timeline_event_params)
      render status: 200, json: timeline_event
    else
      render status: 422, json: timeline_event.errors
    end
  end
  
  def timeline_event_params
    params.require(:timeline_event).permit(:description)
  end
end
