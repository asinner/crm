class LeadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    @user.company.leads.include?(@record)
  end

  def create?
    index?
  end
  
  def update?
    index?
  end
end
