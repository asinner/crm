class Api::V1::TimelineCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_company!
  
  def create
    timeline = Timeline.find(params[:timeline_id])
    category = timeline.categories.new(category_params)
    authorize timeline
    
    if category.save
      render status: 201, json: category
    else
      render status: 422, json: category.errors
    end
  end
  
  def update
    category = TimelineCategory.find(params[:id])    
    authorize category.timeline
    
    if category.update(category_params)
      render status: 200, json: category
    else
      render status: 422, json: category.errors
    end
  end
  
  def destroy
    category = TimelineCategory.find(params[:id])
    authorize category.timeline
    category.destroy
    render status: 204, nothing: true
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end
