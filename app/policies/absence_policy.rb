# app/policies/absence_policy.rb

class AbsencePolicy < ApplicationPolicy
  def index?
    user_is_therapist?
  end

  def show?
    user_is_owner_of_absence?
  end

  def create?
    user_is_therapist?
  end

  def update?
    user_is_owner_of_absence?
  end

  def destroy?
    user_is_owner_of_absence?
  end

  private

  def user_is_therapist?
    user.therapist.present?
  end

  def user_is_owner_of_absence?
    record.therapist == user.therapist
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.therapist.present?
        scope.where(therapist: user.therapist)
      else
        scope.none
      end
    end
  end
end
