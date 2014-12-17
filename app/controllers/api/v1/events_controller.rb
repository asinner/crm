class Api::V1::EventsController < ApplicationController
  wrap_parameters :event, include: Event.attribute_names + [:address_attributes]

  before_action :authenticate_user!
  before_action :authenticate_company!

  def index
    events = current_user.company.events
    render status: 200, json: events
  end

  def create    
    lead = Lead.find(params[:lead_id])
    authorize lead
    event = lead.events.new(event_params)
    event.build_estimate
    event.build_timeline

    if event.save
      render status: 201, json: event
    else
      render status: 422, json: event.errors
    end
  end

  def update
    event = Event.find(params[:id])
    authorize event

    if event.update(event_params)
      render status: 200, json: event
    else
      render status: 422, json: event.errors
    end
  end

  def event_params
    params.require(:event).permit(:name, :date, address_attributes: [:line1, :line2, :city, :state, :zip])
  end
end
