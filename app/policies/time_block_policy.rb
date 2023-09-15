class TimeBlockPolicy < ApplicationPolicy
  class Scope < Scope
    def show?
      # Autoriser la visualisation uniquement si l'utilisateur est le propriétaire de la "Week Availability"
      user == record.week_availability.therapist.user
    end
  end
end
