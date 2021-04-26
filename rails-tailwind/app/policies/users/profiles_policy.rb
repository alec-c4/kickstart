class Users::ProfilesPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end
end
