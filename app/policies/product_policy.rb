class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    update?
  end

  def update?
    @user.company.products.include?(@record)
  end

  def destroy?
    update?
  end
end
