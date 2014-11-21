class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    @user.company.leads.include?(@record.lead)
  end

  def update?
    @user.company.events.include?(@record)
  end

  def destroy?
    update?
  end
end
