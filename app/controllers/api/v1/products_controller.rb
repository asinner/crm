class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = current_user.company.products.new(product_params)

    if product.save
      render status: 201, json: product
    else
      render status: 422, json: product.errors
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
