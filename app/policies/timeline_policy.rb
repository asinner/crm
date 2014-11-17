class TimelinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def create?
    @user.company.events.include?(record.event)
  end
  
  def update?
    create?
  end
  
  def destroy?
    create?
  end
end
