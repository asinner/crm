class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_company!
  
  def create
    event = @user.company.events.new(event_params)
    
    if event.save
      render status: 201, json: event
    else
      render status: 422, json: event.errors
    end
  end
  
  def update
    event = Event.find(params[:id])
    
    if event.update(event_params)
      render status: 200, json: event
    else
      render status: 422, json: event.errors
    end
  end
  
  def event_params
    params.require(:event).permit(:name)
  end
end
