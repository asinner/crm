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
     
    line_item = estimate.items.where(
      name: params[:name],
      description: params[:description],
      amount: params[:amount] * 100
    ).first_or_initialize(
      name: params[:name],
      description: params[:description],
      amount: params[:amount],
      role: params[:role]
    )
    line_item.qty = (line_item.qty ||= 0) + params[:qty]
        
    #line_item = estimate.items.find_or_initialize_by(
    #  name: params[:name],
    #  description: params[:description],
    #  amount: params[:amount]
    #  #amount: params[:amount] * 100,
    #  #role: params[:role]
    #)
    #line_item.qty = (line_item.qty ||= 0) + params[:qty]

    puts "************************\n"
    puts line_item.inspect
    puts "****************************\n"
    
    line_items = [line_item]
    
    #if params[:product_id]
    #  Product.find(params[:product_id]).costs.each do |c|
    #    item = estimate.items.find_or_initialize_by(
    #      name: c.name,
    #      description: c.description,
    #      amount: c.amount * 100,
    #      role: 'expense'
    #    )
    #    item.qty = (item.qty ||= 0) + c.qty
    #    line_items.push(item)
    #  end
    #end
    
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
