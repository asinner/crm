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
    product = Product.find(params[:product_id])
    authorize product
    item = estimate.items << product

    if estimate.save
      render status: 201, nothing: true
    else
      render status: 422, json: estimate.errors
    end
  end

  def destroy
    estimate = Estimate.find(params[:estimate_id])
    authorize estimate
    product = Product.find(params[:id])
    estimate.items.delete(product)
    render status: 204, nothing: true
  end
end
