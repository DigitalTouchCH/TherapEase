class AbsencePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      scope.all #TODO: check with teachers if we can authorize with pundit
      # and not in the controller
    end

  end

  def new?
    return true
  end

  def create?
    return true
  end

  def edit?
    return true
  end

  def update?
    return true
  end

end
