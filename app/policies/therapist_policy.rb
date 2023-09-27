class TherapistPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user_is_therapist?
  end

  def update?
    user_is_therapist?
  end

  def destroy?
    therapist == current_user.therapist
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
