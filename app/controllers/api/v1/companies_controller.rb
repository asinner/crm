class Api::V1::CompaniesController < ApplicationController
  before_action :authenticate_user!

  def create
    return render status: 400, json: { msg: 'You have already created a company' } if @user.company
    company = Company.create(company_params)
    company.users << @user
    if company.save
      render status: 201, json: company
    else
      render status: 422, json: company.errors
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
