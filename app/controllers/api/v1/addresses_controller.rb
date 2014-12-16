class Api::V1::AddressesController < ApplicationController
  before_action :authenticate_user!
  
  def update
    address = Address.find(params[:id])
    authorize address.event
    
    if address.update(address_params)
      render status: 200, json: address
    else
      render status: 422, json: address.errors
    end
  end
  
  def address_params
    params.require(:address).permit(:line1, :line2, :city, :state, :zip)
  end
end
