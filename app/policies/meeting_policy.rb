class MeetingPolicy < ApplicationPolicy
  def index?
    # Only therapists and patients associated with the meeting can see the list of meetings
    user_meetings.exists?
  end

  def show?
    user_is_therapist_for_meeting? || user_is_patient_for_meeting?
  end

  def new?
    create?
  end

  def create?
    record.package.therapist.user == user || record.package.patient.user == user
  end

  def update?
    user_is_therapist_for_meeting? || user_is_patient_for_meeting?
  end

  def destroy?
    user_is_therapist_for_meeting?
  end

  def update_status?
    user_is_therapist_for_meeting?
  end

  private

  def user_is_therapist?
    # Check if the current user is a therapist
    user.therapist.present?
  end
  def user_is_patient?
    # Check if the current user is a patient
    user.patient.present?
  end
  def user_is_therapist_for_meeting?
    # Check if the therapist associated with the package linked to the meeting is the current user
    record.package.therapist == user.therapist
  end
  def user_is_patient_for_meeting?
    # Check if the patient associated with the package linked to the meeting is the current user
    record.package.patient == user.patient
  end

  def user_meetings
    # Return a relation of meetings associated with the current user, either as a therapist or as a patient
    if user_is_therapist?
      Meeting.joins(:package).where(packages: { therapist: user.therapist })
    elsif user_is_patient?
      Meeting.joins(:package).where(packages: { patient: user.patient })
    else
      Meeting.none
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.therapist.present?
        scope.joins(:package).where(packages: { therapist: user.therapist })
      elsif user.patient.present?
        scope.joins(:package).where(packages: { patient: user.patient })
      else
        scope.none
      end
    end
  end
end
