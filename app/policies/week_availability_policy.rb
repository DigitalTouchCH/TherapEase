class WeekAvailabilityPolicy < ApplicationPolicy
  def show?
    owns_record?
  end

  def create?
    therapist?
  end

  def update?
    owns_record?
  end

  def destroy?
    owns_record?
  end

  def index?
    therapist?
  end

  def new?
    therapist?
  end

  def edit?
    owns_record?
  end

  class Scope < Scope
    def resolve
      if user.therapist
        scope.where(therapist: user.therapist)
      else
        scope.none
      end
    end
  end

  private

  def therapist?
    user.therapist.present?
  end

  def owns_record?
    therapist? && record.therapist == user.therapist
  end


end
