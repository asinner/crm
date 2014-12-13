class Api::V1::LeadsController < ApplicationController
  wrap_parameters :lead, include: Lead.attribute_names + [:events_attributes]
  
  before_action :authenticate_user!

  def index
    leads = current_user.company.leads.includes(events: :estimate)
    render status: 200, json: leads
  end

  def create
    lead = current_user.company.leads.build(lead_params)
    lead.events.first.build_estimate if lead.events.first
    
    if lead.save
      render status: 201, json: lead
    else
      render status: 422, json: lead.errors
    end
  end
  
  def update
    lead = Lead.find(params[:id])
    authorize lead
    
    if lead.update(lead_params)
      render status: 200, json: lead
    else
      render status: 422, json: lead.errors
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone_number, events_attributes: [:name, :date])
  end
end
