class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def update?
    @user.company.products.include?(@record)
  end
end
