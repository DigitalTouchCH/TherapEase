class TimeBlockPolicy < ApplicationPolicy

  def create?
    user_is_therapist? && owns_week_availability?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def edit?
    create?
  end

  def show?
    create?
  end

  private

  def user_is_therapist?
    user&.therapist.present?
  end

  def owns_week_availability?
    user.therapist == record.week_availability.therapist
  end

  class Scope < Scope
    def resolve
      if user.therapist.present?
        scope.where(therapist: user.therapist)
      else
        scope.none
      end
    end
  end
end
