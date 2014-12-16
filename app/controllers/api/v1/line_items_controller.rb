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
    product = Product.find_by(id: params[:product_id])
    list = [params]
    list += product.costs if product
    line_items = LineItemDeduplicator.find_or_initialize(estimate, list)

    saved = LineItem.transaction do
      line_items.each do |i|
        i.save
      end
    end

    if saved
      render status: 201, json: line_items
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
