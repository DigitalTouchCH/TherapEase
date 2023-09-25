class PatientPolicy < ApplicationPolicy

  def index?
    user_is_therapist?
  end

  def show?
    user_is_therapist?
  end

  def create?
    user_is_therapist?
  end

  def update?
    user_is_therapist?
  end

  def destroy?
  end

  private

  def user_is_therapist?
    user&.therapist.present?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.therapist.present?
        scope.joins(packages: :therapist).where(packages: { therapist: user.therapist }).order('created_at DESC').distinct
      else
        scope.where(user: user)
      end
    end
  end
end
