class Api::V1::LeadsController < ApplicationController
  before_action :authenticate_user!

  def index
    leads = current_user.company.leads.includes(:events)
    render status: 200, json: leads
  end

  def create
    lead = current_user.company.leads.new(lead_params)

    if lead.save
      render status: 201, json: lead
    else
      render status: 422, json: lead.errors
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone_number)
  end
end
