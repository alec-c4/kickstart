class Users::IdentitiesPolicy < ApplicationPolicy
  def destroy?
    true
  end
end
