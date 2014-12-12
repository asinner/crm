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
    line_item = LineItem.find(params[:id])
    authorize line_item.estimate
    line_item.delete
    render status: 204, nothing: true
  end
  
  def update
    line_item = LineItem.find(params[:id])
    authorize line_item.estimate
    
    if line_item.update(line_item_params)
      render status: 200, json: line_item
    else
      render status: 422, json: line_item.errors
    end
  end
  
  private
  
  def line_item_params
    params.require(:line_item).permit(:name, :description, :amount, :qty, :role, :estimate_id)
  end
end
