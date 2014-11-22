class EstimatePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def create?
    @user.company.leads.include?(@record.event.lead)
  end
  
  def destroy?
    create?
  end
end
