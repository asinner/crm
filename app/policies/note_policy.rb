class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def update?
    @user.company.leads.include?(@record.lead)
  end
  
  def destroy?
    update?
  end
end
