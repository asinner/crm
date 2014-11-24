class UploadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def destroy?
    @user.company.leads.include?(@record.event.lead)
  end
end
