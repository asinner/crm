class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    create?
  end

  def create?
    @user.company.leads.include?(@record.lead)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
