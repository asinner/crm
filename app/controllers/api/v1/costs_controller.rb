class Api::V1::CostsController < ApplicationController
  def create
    authorize Product.find(params[:product_id])
    cost = Cost.new(cost_params)
    
    if cost.save
      render status: 201, json: cost
    else
      render status: 422, json: cost.errors
    end
  end
  
  private
  
  def cost_params
    params.require(:cost).permit(:product_id, :name, :description, :amount, :qty, :automatic)
  end
end
