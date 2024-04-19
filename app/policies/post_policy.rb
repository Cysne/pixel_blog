class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true if user.present?
  end

  def update?
   return true if record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
