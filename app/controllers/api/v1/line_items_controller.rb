class Api::V1::LineItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    estimate = Estimate.find(params[:estimate_id])
    authorize estimate
    render status: 200, json: estimate.items
  end

  def create
    estimate = Estimate.find(params[:estimate_id])
    authorize estimate
    
    line_item = LineItem.new(line_item_params)

    if line_item.save
      render status: 201, json: line_item
    else
      render status: 422, json: line_item.errors
    end
  end

  def destroy
    estimate = Estimate.find(params[:estimate_id])
    authorize estimate
    product = Product.find(params[:id])
    estimate.items.delete(product)
    render status: 204, nothing: true
  end
  
  private
  
  def line_item_params
    params.require(:line_item).permit(:name, :description, :amount, :qty, :estimate_id)
  end
end
