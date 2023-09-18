class PackagePolicy < ApplicationPolicy
  def index?
    # Only therapists and patients associated with the package can see the list of packages
    user_packages.any?
  end

  def show?
    # The associated therapist or the patient can view a specific package
    user_is_therapist? || user_is_patient?
  end

  def new?
    true
  end

  def create?
    # Patients and therapists can create a package
    true
  end

  def edit?
    user_is_therapist_for_package?
  end

  def update?
    # Only the associated therapist can update the package
    user_is_therapist_for_package?
  end

  def destroy?
    # Only the associated therapist can delete the package
    user_is_therapist_for_package?
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

  def user_is_therapist_for_package?
    # Check if the therapist associated with the package is the current user
    record.therapist == user.therapist
  end

  def user_packages
    # Return a list of packages associated with the current user, either as a therapist or as a patient
    if user_is_therapist?
      Package.where(therapist: user.therapist)
    elsif user_is_patient?
      Package.where(patient: user.patient)
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
        scope.where(therapist: user.therapist)
      elsif user.patient.present?
        scope.where(patient: user.patient)
      else
        scope.none
      end
    end
  end
end
